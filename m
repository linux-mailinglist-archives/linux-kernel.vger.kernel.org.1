Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480811DE3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgEVKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 06:15:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbgEVKPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:15:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6AA25AC52;
        Fri, 22 May 2020 10:15:11 +0000 (UTC)
Date:   Fri, 22 May 2020 12:15:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     root <wang.yi59@zte.com.cn>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        jiang.xuexin@zte.com.cn,
        =?utf-8?B?5rGq5YuHMTAyNjk1NjY=?= <wang.yong12@zte.com.cn>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] [PATCH]Fixed: line break of pr_cont not take effect in
 linux-rt
Message-ID: <20200522101507.GI3464@linux-b0ei>
References: <1590025064-14433-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1590025064-14433-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-05-21 09:37:44, root wrote:
> From: 汪勇10269566 <wang.yong12@zte.com.cn>
> 
> Line break of pr_cont not take effect.
> Use several pr_cont to print continuous paragraph, it is expected to
> have line break when line ends up with  '\n', however the paragraph
> does not have line break
> -printk_kthread_func will not print info before log_store insert msg
>  into printk_rb, and pr_cont calls cont_add to keep data in buffer.
>  cont_add only when the following conditions are met insert msg to
>  printk_rb
>  1.cpu != c->cpu_owner || !(flags & LOG_CONT)
>  2.c->len + len > sizeof(c->buf)
> 
> Signed-off-by: 汪勇10269566 <wang.yong12@zte.com.cn>
> ---
>  kernel/printk/printk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 0605a74..d898f50 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1871,6 +1871,7 @@ static void cont_add(int ctx, int cpu, u32 caller_id, int facility, int level,
>  	// but later continuations can add a newline.
>  	if (flags & LOG_NEWLINE) {
>  		c->flags |= LOG_NEWLINE;
> +		cont_flush(ctx);

What kernel sources is this patch against, please?

The console_flush() call is in the current Linus' tree. It does not
have any parameter there. And there is no printk_kthread_func.

Is this against RT patchset?

Best Regards,
Petr
