Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846252B70DF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKQVXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQVXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:23:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93510C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:23:08 -0800 (PST)
Received: from zn.tnic (p200300ec2f10130053cbbcbd889a5460.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:1300:53cb:bcbd:889a:5460])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18FBB1EC04B9;
        Tue, 17 Nov 2020 22:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605648187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x3UrhrGPN+9oncUVOMwc/Shd/swOmOyRSPQXEE/TNBQ=;
        b=XyoG9BG/jFuearKcQWJ0aiGMPi4DrwtL5zuLUFrj/QvDyLa9LTx1gMcplrtlhPf4CRXNBH
        B3GaIGqbSTV+BOABUF9upfD333uTHSu+SM0CSdMl4E3O8qYTAMwY5BAsvte6dSl6RYct2i
        AKrzJ1N7TmpL5oyldjXcv9+RxpLySUw=
Date:   Tue, 17 Nov 2020 22:23:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, junaids@google.com, oweisse@google.com,
        rppt@linux.vnet.ibm.com, graf@amazon.de, mgross@linux.intel.com,
        kuzuno@gmail.com
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
Message-ID: <20201117212307.GR5719@zn.tnic>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
 <20201117165539.GG5719@zn.tnic>
 <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
 <20201117182809.GK5719@zn.tnic>
 <33a1c6ee-0122-0b0c-ed2d-1578b29ef7c1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33a1c6ee-0122-0b0c-ed2d-1578b29ef7c1@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 08:02:51PM +0100, Alexandre Chartre wrote:
> No. This prevents the guest VM from gathering data from the host
> kernel on the same cpu-thread. But there's no mitigation for a guest
> VM running on a cpu-thread attacking another cpu-thread (which can be
> running another guest VM or the host kernel) from the same cpu-core.
> You cannot use flush/clear barriers because the two cpu-threads are
> running in parallel.

Now there's your justification for why you're doing this. It took a
while...

The "why" should always be part of the 0th message to provide
reviewers/maintainers with answers to the question, what this pile of
patches is all about. Please always add this rationale to your patchset
in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
