Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D92B3BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgKPD7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 22:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgKPD7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 22:59:49 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C1C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 19:59:49 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n129so15870645iod.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 19:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoKkCk1ViZ7cyDkfkn32mt+pu9Euhk6ljleTl1w5KYw=;
        b=GtuRtmU2k/VKyIq+ohLxciYqRhsG36XyT2Up2675OxXUTvoXTWC7KZhuIvJyEPVqvN
         kGBGaVgXxwwd2ECUdGovuvR9rq0QTmAWDsvcZoivebj1HL2fs5HNnxXVG7aT2026D5T3
         iKo/ZG41NBzjLxqF+7TOFwuTo+hizHQp49eYXNuKtBZoR2OpzvUOvVe9hT0Pt6q98zYe
         K/Gho1PNJzLYS5De7S4ogij5gdEdQ/irIGCydRcmVSoFT/zcs1jlwS5tn4pDeNc8wJBu
         TE97xZmA2gfe3l0eYljhh6SX9v+v3AhXQHnrCuqHLi8XO6M8Z2HHMTXHnS2GhsYslpkk
         KJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoKkCk1ViZ7cyDkfkn32mt+pu9Euhk6ljleTl1w5KYw=;
        b=geSiFe2mUpO4Btqa6wUrXkTvLcJAIhIsHfBWxdHlELyfGZpW67zVlNLK/GR6d6FZHs
         OLZsw4C3ngyr15ORk6YMqOIpFSRG2FfcHY6yuWwsOBh9Lr8lwB12neOM12ntzsq5hXEq
         EEny8p/D1sqfYgvyVXi6wuIFYR0HB5tQCPAgg36d+ZXLAqwK63SgfktOAVfpOeV4HXgj
         gJNK4E34M6w1baPpNa/N7irc3U/ExJIWPUGqAlglpr/YGKVmpHryb/X/2rnOpNgxEZiG
         1iNm5pMC874KJvYzxQBIdfEZ+A+rkLqDqiU6NJzEmAjTIXbPGSvqCKhW2q+h9ccqhwQF
         sHOg==
X-Gm-Message-State: AOAM530WOooE5zal8MgvpErXy1pes9F5cnBwuY6DeMOEZ55a07yclrep
        T8O6hLbR/MufoznbAwKJ+pYccEtRkAOYyNMwSNg=
X-Google-Smtp-Source: ABdhPJwGD3kzZ3e8UsaE7X+yrU5zBbAwhLXF3V30+nVXHbWI5xKA5BVVCJbTdJcDDXa/KJrF2fP+9nfnsY70Ezxhyaw=
X-Received: by 2002:a02:2e52:: with SMTP id u18mr9220183jae.29.1605499188480;
 Sun, 15 Nov 2020 19:59:48 -0800 (PST)
MIME-Version: 1.0
References: <BN7PR11MB26097166B6B46387D8A1ABA4FDE30@BN7PR11MB2609.namprd11.prod.outlook.com>
In-Reply-To: <BN7PR11MB26097166B6B46387D8A1ABA4FDE30@BN7PR11MB2609.namprd11.prod.outlook.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Sun, 15 Nov 2020 19:59:37 -0800
Message-ID: <CAAH8bW_WVomz45dUAth9OqVRe=+nYcBBcc9iW4tmXkDSnJOUhw@mail.gmail.com>
Subject: Re: bitmap: Remove unused function declaration
To:     "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(CC related people)

Since there is no actual implementation for them, there's , I think
it's safe (and better)
to remove the declarations. Thanks for the catch.

Acked-by: Yury Norov <yury.norov@gmail.com>

On Sun, Nov 15, 2020 at 7:17 PM Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
>
> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
> ---
>  include/linux/bitmap.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 99058eb81042..6f08965c69a5 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -126,8 +126,6 @@ extern void bitmap_free(const unsigned long *bitmap);
>   * lib/bitmap.c provides these functions:
>   */
>
> -extern int __bitmap_empty(const unsigned long *bitmap, unsigned int nbits);
> -extern int __bitmap_full(const unsigned long *bitmap, unsigned int nbits);
>  extern int __bitmap_equal(const unsigned long *bitmap1,
>                           const unsigned long *bitmap2, unsigned int nbits);
>  extern bool __pure __bitmap_or_equal(const unsigned long *src1,
> --
> 2.28.0
