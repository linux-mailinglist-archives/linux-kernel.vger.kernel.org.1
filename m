Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838AE29EBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJ2Mb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:31:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:37876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgJ2Mbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:31:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3DE19AD31;
        Thu, 29 Oct 2020 12:31:54 +0000 (UTC)
Date:   Thu, 29 Oct 2020 13:31:53 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jessica Yu <jeyu@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: set MODULE_STATE_GOING state when a module fails
 to load
In-Reply-To: <20201028122106.GA6867@linux-8ccs>
Message-ID: <alpine.LSU.2.21.2010291310210.1688@pobox.suse.cz>
References: <20201027140336.15409-1-mbenes@suse.cz> <20201028122106.GA6867@linux-8ccs>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020, Jessica Yu wrote:

> +++ Miroslav Benes [27/10/20 15:03 +0100]:
> >If a module fails to load due to an error in prepare_coming_module(),
> >the following error handling in load_module() runs with
> >MODULE_STATE_COMING in module's state. Fix it by correctly setting
> >MODULE_STATE_GOING under "bug_cleanup" label.
> >
> >Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> >---
> > kernel/module.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/kernel/module.c b/kernel/module.c
> >index a4fa44a652a7..b34235082394 100644
> >--- a/kernel/module.c
> >+++ b/kernel/module.c
> >@@ -3991,6 +3991,7 @@ static int load_module(struct load_info *info, const
> >char __user *uargs,
> >  			     MODULE_STATE_GOING, mod);
> >  	klp_module_going(mod);
> >  bug_cleanup:
> >+	mod->state = MODULE_STATE_GOING;
> >  /* module_bug_cleanup needs module_mutex protection */
> >  mutex_lock(&module_mutex);
> >  module_bug_cleanup(mod);
> 
> Thanks for the fix! Hmm, I am wondering if we also need to set the
> module to GOING if it happens to fail while it is still UNFORMED.
> 
> Currently, when a module is UNFORMED and encounters an error during
> load_module(), it stays UNFORMED until it finally goes away. That
> sounds fine, but try_module_get() technically permits you to get a
> module while it's UNFORMED (but not if it's GOING). Theoretically
> someone could increase the refcount of an unformed module that has
> encountered an error condition and is in the process of going away.

Right.

> This shouldn't happen if we properly set the module to GOING whenever
> it encounters an error during load_module().

That's correct.
 
> But - I cannot think of a scenario where someone could call
> try_module_get() on an unformed module, since find_module() etc. do
> not return unformed modules, so they shouldn't be visible outside of
> the module loader. So in practice, I think we're probably safe here..

Hopefully yes. I haven't found anything that would contradict it.

I think it is even safer to leave UNFORMED there. free_module() explicitly 
sets UNFORMED state too while going through the similar process.

ftrace_release_mod() is the only inconsistency there. It is called with 
UNFORMED in load_module() if going through ddebug_cleanup label 
directly, and with GOING in both do_init_module() before free_module() is 
called and delete_module syscall. But it probably does not care.

Miroslav

