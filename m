Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DB12B59F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgKQG7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 01:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgKQG7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 01:59:45 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82DFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 22:59:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 3669ECE6;
        Tue, 17 Nov 2020 07:59:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kIirWhfqeZay; Tue, 17 Nov 2020 07:59:42 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 02F1788F;
        Tue, 17 Nov 2020 07:59:41 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1keuxo-00GZtO-Nh; Tue, 17 Nov 2020 07:59:40 +0100
Date:   Tue, 17 Nov 2020 07:59:40 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        w.d.hubbs@gmail.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH] speakup: fix uninitialized flush_lock
Message-ID: <20201117065940.pcfjrbyrg4h5ona4@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        w.d.hubbs@gmail.com, gregkh@linuxfoundation.org
References: <20201117012229.3395186-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117012229.3395186-1-yangyingliang@huawei.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Yingliang, le mar. 17 nov. 2020 09:22:29 +0800, a ecrit:
> The flush_lock is uninitialized, use DEFINE_SPINLOCK
> to define and initialize flush_lock.
> 
> Fixes: c6e3fd22cd53 ("Staging: add speakup to the staging directory")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/accessibility/speakup/speakup_dectlk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/speakup_dectlk.c b/drivers/accessibility/speakup/speakup_dectlk.c
> index 780214b5ca16..ab6d61e80b1c 100644
> --- a/drivers/accessibility/speakup/speakup_dectlk.c
> +++ b/drivers/accessibility/speakup/speakup_dectlk.c
> @@ -37,7 +37,7 @@ static unsigned char get_index(struct spk_synth *synth);
>  static int in_escape;
>  static int is_flushing;
>  
> -static spinlock_t flush_lock;
> +static DEFINE_SPINLOCK(flush_lock);
>  static DECLARE_WAIT_QUEUE_HEAD(flush);
>  
>  static struct var_t vars[] = {
> -- 
> 2.25.1
> 
