Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875542746A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIVQ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:29:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC6C061755;
        Tue, 22 Sep 2020 09:29:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKlA5-003sl7-Vo; Tue, 22 Sep 2020 16:29:02 +0000
Date:   Tue, 22 Sep 2020 17:29:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        oleg@redhat.com, guoren@kernel.org
Subject: Re: [PATCH] csky: Fix a size determination in gpr_get()
Message-ID: <20200922162901.GA3421308@ZenIV.linux.org.uk>
References: <20200922091505.471-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922091505.471-1-zhenzhong.duan@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 05:15:05PM +0800, Zhenzhong Duan wrote:
> "*" is missed  in size determination as we are passing register set
> rather than a pointer.

Ack.  I can push it to Linus today, unless you want it to go through
csky tree.  Preferences?

> Fixes: dcad7854fcce ("sky: switch to ->regset_get()")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>  arch/csky/kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
> index d822144906ac..a4cf2e2ac15a 100644
> --- a/arch/csky/kernel/ptrace.c
> +++ b/arch/csky/kernel/ptrace.c
> @@ -83,7 +83,7 @@ static int gpr_get(struct task_struct *target,
>  	/* Abiv1 regs->tls is fake and we need sync here. */
>  	regs->tls = task_thread_info(target)->tp_value;
>  
> -	return membuf_write(&to, regs, sizeof(regs));
> +	return membuf_write(&to, regs, sizeof(*regs));
>  }
>  
>  static int gpr_set(struct task_struct *target,
> -- 
> 2.25.1
> 
