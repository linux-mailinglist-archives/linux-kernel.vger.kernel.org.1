Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0249252807
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHZHBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 03:01:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40606 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHZHAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:00:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id k20so637217wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 00:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OVk17pjlFWM7xWR15mxNLFPj8fOx57j7Mfhg8pmLRG0=;
        b=Nxlu9u6nhaVqkVipPRF4cCxkrNBnrY8U/4wv9LWzUBA3w0sw5On6PkgrgP5Mn82wj2
         o0w/n/Y63kjRxUplhmZVLZPy2j7DjoSSZWCZOxxlJWuKIBa+fDoh33XDNr6/5njscOjS
         AIP5TnLCs3gK0LwzN44OkxeC8m3hrXPS24QM3ltOZ0ByGoeqajSbOX8qLK8CAvLVmHVR
         PfsLFdrZkKgWcvPbUjOe9WiM7pU84SN8+1RKv6Y+59o3jS00UGrnajf/tej/iwCeQvhB
         dn+YqGshah43ky9CAAmkX34+QjIFvgTdo5q502UJAvbHfgPBiYYiT6mfQRl0bAKbAkHq
         fgVQ==
X-Gm-Message-State: AOAM531RK4ehPwQ9Dai/HNy0nb5C5rp+esKIVFMIgXytyXwQSXTafIrT
        OXaNe11R7yJjE3aRGJ9bbwI=
X-Google-Smtp-Source: ABdhPJxI8FkLyBVze6eElk1QqldyEB1YyDRAe2hVpo9bFtvx6TSwY7XDX26las8DNz4XRhxmwv0XaA==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr5362592wmi.19.1598425206295;
        Wed, 26 Aug 2020 00:00:06 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id b204sm3340413wmd.34.2020.08.26.00.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 00:00:05 -0700 (PDT)
Date:   Wed, 26 Aug 2020 09:00:03 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, andriy.shevchenko@intel.com,
        thomas.langer@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v1 4/9] extcon: extcon-ptn5150: Switch to BIT() for cable
 detach macro
Message-ID: <20200826070003.GD12271@pi3>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818065727.50520-5-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818065727.50520-5-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:57:22PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Switch to BIT() macro for the cable detach.

Squash it.

Best regards,
Krzysztof

> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/extcon/extcon-ptn5150.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index fab862d9aad8..50fff148b772 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -45,10 +45,7 @@ enum ptn5150_reg {
>  #define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
>  
>  #define PTN5150_REG_INT_CABLE_ATTACH_MASK	BIT(0)
> -
> -#define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
> -#define PTN5150_REG_INT_CABLE_DETACH_MASK	\
> -	(0x1 << PTN5150_REG_CC_CABLE_DETACH_SHIFT)
> +#define PTN5150_REG_INT_CABLE_DETACH_MASK	BIT(1)
>  
>  struct ptn5150_info {
>  	struct device *dev;
> -- 
> 2.11.0
> 
