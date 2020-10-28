Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E635129DF76
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgJ2BB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbgJ1WR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:27 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD2824709;
        Wed, 28 Oct 2020 12:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603887671;
        bh=5zAZ59dxvdbTmx70RmxNAB7Own5NvWVOautNnVo9W1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CY/O0b6KyuWbUxIz6O2QRpemZqsP6Fhu7NYEJVpyFJVNYZmoHGYV1fmR/PIFFb4Nv
         LVm6eee/1zGfmKdtDZE2x/+FAUKPbYVkOa6rVP+X0gMmKfkGzxJJuE1mWnVBmNpP4l
         GMhZV+S457TZXf0oF8MQrzRQzCi/zCsnUtvwDPUU=
Date:   Wed, 28 Oct 2020 13:21:06 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: set MODULE_STATE_GOING state when a module fails
 to load
Message-ID: <20201028122106.GA6867@linux-8ccs>
References: <20201027140336.15409-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201027140336.15409-1-mbenes@suse.cz>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [27/10/20 15:03 +0100]:
>If a module fails to load due to an error in prepare_coming_module(),
>the following error handling in load_module() runs with
>MODULE_STATE_COMING in module's state. Fix it by correctly setting
>MODULE_STATE_GOING under "bug_cleanup" label.
>
>Signed-off-by: Miroslav Benes <mbenes@suse.cz>
>---
> kernel/module.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index a4fa44a652a7..b34235082394 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -3991,6 +3991,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> 				     MODULE_STATE_GOING, mod);
> 	klp_module_going(mod);
>  bug_cleanup:
>+	mod->state = MODULE_STATE_GOING;
> 	/* module_bug_cleanup needs module_mutex protection */
> 	mutex_lock(&module_mutex);
> 	module_bug_cleanup(mod);

Thanks for the fix! Hmm, I am wondering if we also need to set the
module to GOING if it happens to fail while it is still UNFORMED.

Currently, when a module is UNFORMED and encounters an error during
load_module(), it stays UNFORMED until it finally goes away. That
sounds fine, but try_module_get() technically permits you to get a
module while it's UNFORMED (but not if it's GOING). Theoretically
someone could increase the refcount of an unformed module that has
encountered an error condition and is in the process of going away.
This shouldn't happen if we properly set the module to GOING whenever
it encounters an error during load_module().

But - I cannot think of a scenario where someone could call
try_module_get() on an unformed module, since find_module() etc. do
not return unformed modules, so they shouldn't be visible outside of
the module loader. So in practice, I think we're probably safe here..

