Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3A2B9B40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgKSTKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgKSTKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:10:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45DCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 11:10:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605813047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fqTlt+xmV+wxcpS5yo4wjoab1yCJzP8iG04Acn2vaKA=;
        b=FU/TB9NKttAWjhk1K07OlHEPQFhYFoPYGEZ0DUIdWthJ5rznjwFWEBmTm0IfmPzdJmG0hj
        eTGegEMk8exhni9N1UsGdF4oWrTgABHv8n1r00A9iRVn5UGkrzlSDRraZ4WQo0sqzpetZr
        NCC6B9cCNRd1vRenYoGyrO/ajGEVpc3lWMtxl6n5Iooeu8f5Mr79U76x/fdmhC9k6YqP2e
        iVcvbNf+7CLE8xuXHm4mX/9ymp7ipU07ju96haHsNaXmVOsCxJ0ipN9R9sHSv5eGeCaiX3
        2v3Yy7vm4oA/AS+W8Sg4WDnwtmKzuU7l/a1VSN1Z/EVfgANqh2ymSopry+mRcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605813047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fqTlt+xmV+wxcpS5yo4wjoab1yCJzP8iG04Acn2vaKA=;
        b=cqA167oJl8YpjT3h2H01mJN4qfrIVA7UJcPEWlupJM+9T0y03BkbkNla3eZmyK4rxX1qmk
        FUoi/S1jlPi7kHBw==
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Junaid Shahid <junaids@google.com>,
        oweisse@google.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>, mgross@linux.intel.com,
        kuzuno@gmail.com
Subject: Re: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of trampoline stack
In-Reply-To: <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com> <20201116144757.1920077-13-alexandre.chartre@oracle.com> <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com> <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com>
Date:   Thu, 19 Nov 2020 20:10:46 +0100
Message-ID: <87ft55p3gp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16 2020 at 19:10, Alexandre Chartre wrote:
> On 11/16/20 5:57 PM, Andy Lutomirski wrote:
>> On Mon, Nov 16, 2020 at 6:47 AM Alexandre Chartre
>> <alexandre.chartre@oracle.com> wrote:
> When executing more code in the kernel, we are likely to reach a point
> where we need to sleep while we are using the user page-table, so we need
> to be using a per-thread stack.
>
>> I can't immediately evaluate how nasty the page table setup is because
>> it's not in this patch.
>
> The page-table is the regular page-table as introduced by PTI. It is just
> augmented with a few additional mapping which are in patch 11 (x86/pti:
> Extend PTI user mappings).
>
>>  But AFAICS the only thing that this enables is sleeping with user pagetables.
>
> That's precisely the point, it allows to sleep with the user page-table.

Coming late, but this does not make any sense to me.

Unless you map most of the kernel into the user page-table sleeping with
the user page-table _cannot_ work. And if you do that you broke KPTI.

You can neither pick arbitrary points in the C code of an exception
handler to switch to the kernel mapping unless you mapped everything
which might be touched before that into user space.

How is that supposed to work?

Thanks,

        tglx

