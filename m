Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9FC1AE31C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgDQRFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgDQRFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:05:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4F1C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:05:14 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jPUQM-0003TL-Qf; Fri, 17 Apr 2020 19:05:06 +0200
Date:   Fri, 17 Apr 2020 19:05:06 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kaitao Cheng <pilgrimtao@gmail.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, namit@vmware.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH RESEND] kernel/smp: Use smp_call_func_t in on_each_cpu()
Message-ID: <20200417170506.ldz2eee4mm4szqij@linutronix.de>
References: <20200417162451.91969-1-pilgrimtao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417162451.91969-1-pilgrimtao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-18 00:24:51 [+0800], Kaitao Cheng wrote:
> There is already a typedef smp_call_func_t, so we can just use it,
> maybe better.
> 
> Fixes: 3a5f65df5a0fc ("Typedef SMP call function pointer")
> Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>

I would not go as far as the Fixes: tag but otherwise:

  Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> ---
>  kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 786092aabdcd..84303197caf9 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -620,7 +620,7 @@ void __init smp_init(void)
>   * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
>   * of local_irq_disable/enable().
>   */
> -void on_each_cpu(void (*func) (void *info), void *info, int wait)
> +void on_each_cpu(smp_call_func_t func, void *info, int wait)
>  {
>  	unsigned long flags;
>  

Sebastian
