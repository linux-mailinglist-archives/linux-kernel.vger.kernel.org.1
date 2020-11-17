Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0A82B70E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgKQV0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:26:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C417C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:26:10 -0800 (PST)
Received: from zn.tnic (p200300ec2f10130053cbbcbd889a5460.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:1300:53cb:bcbd:889a:5460])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95B311EC03FA;
        Tue, 17 Nov 2020 22:26:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605648368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mdlatLQLA3IrahHrmrq1ojL+zzTVd5uHpcM6WKS/HMQ=;
        b=DYsUMLz/dS7BTVXoTb4HloaqoXXVKn2w6QCCCF2E/fSASIv/vhHZ7YWqbtz/N3ru7QbmSI
        gVTD8rT68TxxpD9YNicnJFsrhB6hU92Cf5aNs0VvKA+U2NruhYBrtuFyDt54A9cckzqsCh
        EeZOd+i02B978beqVFxyTFGGq8UmOvA=
Date:   Tue, 17 Nov 2020 22:26:08 +0100
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
Message-ID: <20201117212608.GS5719@zn.tnic>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
 <20201117165539.GG5719@zn.tnic>
 <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 07:12:07PM +0100, Alexandre Chartre wrote:
> Some benchmarks are available, in particular from phoronix:

What I was expecting was benchmarks *you* have run which show that
perf penalty, not something one can find quickly on the internet and
something one cannot always reproduce her-/himself.

You do know that presenting convincing numbers with a patchset greatly
improves its chances of getting it upstreamed, right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
