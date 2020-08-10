Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC83F2403F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHJJZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 05:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgHJJZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:25:28 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B385020709;
        Mon, 10 Aug 2020 09:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597051528;
        bh=hCWECxFulMLwx8A0QXoIH8ZqwiSK3iOXC6sfqduEbWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bhn8xKcrtJdNa0bXWMuLr2Op5DtNK695AGw2c3S/pEKU0OqAwwZPV6EnxjssOG5du
         J4YOikaRuyj2U/dBtc1ZdlqvfIg7xt9/haoz5NzjohEd5LiBwC0GFtLMo9+zh4dkSg
         xLc5D1H0LCMM7doOq46I3OI4IEtvVN8x3+Lfoqpk=
Date:   Mon, 10 Aug 2020 11:25:23 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, h@linux-8ccs
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200810092523.GA8612@linux-8ccs>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200808101222.5103093e@coco.lan>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Mauro Carvalho Chehab [08/08/20 10:12 +0200]:
[snip]
>Right now, what happens is:
>
>	# modprobe wlcore
>	modprobe: ERROR: could not insert 'wlcore': Exec format error
>
>This seems to be failing for all modules, as doesn't show anything
>probed.
>
>Btw, IMO, it would be useful to have some pr_debug() infra in order to
>explain why insmod is failing, or to have more error codes used there,
>as nothing was printed at dmesg. That makes harder to debug issues
>there. I ended losing a lot of time yesterday rebuilding the Kernel
>and checking the FS, before deciding to add some printks inside the
>Kernel ;-)
>
>In order for modprobe to start working again, I had to apply this
>dirty hack:
>
><hack>
>diff --git a/kernel/module.c b/kernel/module.c
>index 910a57640818..10d590dc48ad 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2051,11 +2051,12 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> 	const unsigned long shf_wx = SHF_WRITE|SHF_EXECINSTR;
> 	int i;
>
>+#if 0
> 	for (i = 0; i < hdr->e_shnum; i++) {
> 		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
> 			return -ENOEXEC;
> 	}
>-
>+#endif
> 	return 0;
> }
></hack>

All this hunk does it reject loading modules that have any sections
that have both the writable and executable flags. You're saying it's
happening for all modules on your setup - I am curious as to which
sections have both these flags - what does readelf -S tell you?

Thanks,

Jessica


