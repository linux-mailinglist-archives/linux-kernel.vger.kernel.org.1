Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990F32665F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIKRTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgIKO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 10:58:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE58C0612FA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:58:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so5110569wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=47HWWMOcIrgjxWNrOxRLwACAIvLTkQGng5OfXu+L5SE=;
        b=T2wtZsJtWqU30Uhs/GnSs80/peil8RrcGioN8mdgi8nf/GYDJoj4yhExfKBTMekU8h
         sKA+501GIXNHntziWnMZ6LN1+jpLBe4p7spZvGNI6Fp/+bZWVCzApIigP4rXTBzTx4K0
         pj5/bXAoQOvTRuet5WZnRmetFaJbUp2MQOLuGNrexoPTjy6icKeTYYMOVmWXDy1wq3Mc
         iA25n+GMFzeMMBv2i96riJ4DTCHCEQyrU0obGCSW/OhKvcftwjqrC4fctm0eeXK9dOZ3
         gJRpCBFpW/vhaQaATycjAj7IMz62srogrFvgzjo2J0UvM2vJpng6qizno47+ApCJ7P69
         0YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=47HWWMOcIrgjxWNrOxRLwACAIvLTkQGng5OfXu+L5SE=;
        b=ZiF0x91boSmA5lsJoD8czObR3ybr3noC8BPtmfvo5FhMUc8yJBTC2LkAnf8oqvnjmg
         ZXbVTmYYKGPV+RbuhozJuuhpUEn4PaUPLrBOWbw/hSmc83tIQWVuEg6hJyL5sqfwnhb0
         9wgUin1/kmjABYeXJPA5vN1CnjtyfhRQ+r3VpbyqrxvQreKE78mOHeAA8ia1WdSEsrGh
         3FK9oFoSXWlIZtpvor2JbTLx4JcZGsd9ATz8D6EFkizn4a6qWSY99F8z/g6KKR9H5sfD
         XYRH1ydIpcCMA4I1s4xd6nU3atnCyV93gsCp2kdV5PVe2UUrosx/Z9Z601tXR2ftzfA3
         DUCw==
X-Gm-Message-State: AOAM533Ci8FAYi2ClvMjcN9x3mEaMpR3neRRaxInP8THMvwwv7d+EGMp
        gn+WQPh9NDTaHtMPnKU64CebNA==
X-Google-Smtp-Source: ABdhPJyo65hhUPqdC7qH/YNM45eSsLSFdmMydCBAF7qEoh5wI1GKL7WMPaWI3Pg2s/OuAflz8AHBcg==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr2761125wmj.134.1599836287971;
        Fri, 11 Sep 2020 07:58:07 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f23sm11551550wmc.3.2020.09.11.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 07:58:06 -0700 (PDT)
Date:   Fri, 11 Sep 2020 15:58:05 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/debug: Fix spelling mistake in debug_core.c
Message-ID: <20200911145805.oh3pcre66rrp2she@holly.lan>
References: <1596793480-22559-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596793480-22559-1-git-send-email-tangyouling@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 05:44:40PM +0800, Youling Tang wrote:
> Fix typo: "notifiter" --> "notifier"
> 	  "overriden" --> "overridden"
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

Applied. Thanks.


> ---
>  kernel/debug/debug_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index b16dbc1..3eeee0a 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -80,7 +80,7 @@ static int			exception_level;
>  struct kgdb_io		*dbg_io_ops;
>  static DEFINE_SPINLOCK(kgdb_registration_lock);
>  
> -/* Action for the reboot notifiter, a global allow kdb to change it */
> +/* Action for the reboot notifier, a global allow kdb to change it */
>  static int kgdbreboot;
>  /* kgdb console driver is loaded */
>  static int kgdb_con_registered;
> @@ -163,7 +163,7 @@ early_param("nokgdbroundup", opt_nokgdbroundup);
>  
>  /*
>   * Weak aliases for breakpoint management,
> - * can be overriden by architectures when needed:
> + * can be overridden by architectures when needed:
>   */
>  int __weak kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
>  {
> -- 
> 2.1.0
