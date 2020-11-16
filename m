Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3EC2B3C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 06:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKPFbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 00:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPFbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 00:31:39 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1DBC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 21:31:38 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id q28so1712381pgk.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 21:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=em2aRWqLoXd4CW8zaAHxO6kJilyxwLBRlU1LpIuKuIk=;
        b=cP6HwIn7i/7u30GMj+L50RKMW1ROS0v+FYsDSlIOPx5/CS62Of/adg6cRB5z5Jb1m4
         amopqQ78NceXOeKLvtmZPstA9OGrqn1Wtg06YSEomNjeCYgsZBBFVkPuWyUeodHc6oJ4
         B1H+zNtO0JYVOvr93VGe1U9gZS+9tW39cxc3eUykSRuUpsviWPbr76DdIx3VuqJ25eYw
         loCFUncSpPpyEJXxPxZWx9gEJNYH5pjNR48pD8aDKtnaHEuiwKMl3Zvc4bgS+oCsv5Ra
         6kGu1w1y3Li6y4BHgxZIum2RMElaniXwL/tPH3V1IMORQLX4ZEm1GUwJ1ldSZOxQ7IS2
         3eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=em2aRWqLoXd4CW8zaAHxO6kJilyxwLBRlU1LpIuKuIk=;
        b=mQxrB11ECneWSuR676p9rWCtMahnMfvkAxr2CgnH80y5OUT23s5+0j2naBowSRhsNI
         zlxuAaRT1ADo02CaWMcEB3u3kU1ohtlbSdP17Zbzk6YKlo+3yPUoBSRz+R/xzn0WLknb
         Hk96U3FH21g5cMuhDCcbqaatvKmQr50ldnbZ6UNyXhZ8FIJzSql9Ya75a7SBDNJTi0VN
         ZXgp5b3xs6muQNDRIQ2P+vvJ5m/JN4JqaPyJPVKhEZrnWlO+gdf385YWnpy1AJ2dlN6t
         RQtGEJpw1UTTY1adtfQLhYuxlOhKYuzO9PKSH1jMdaIjtD3g8rz4hbEhHTRgucUNXVoY
         ZmZA==
X-Gm-Message-State: AOAM531KbwfqiSCI0V2L4CUUhXy00BL63+SAcYJNBG4KnNC/jcueguhk
        uYNWjW4H3mZa6ZKIkgJsl6Rm
X-Google-Smtp-Source: ABdhPJzFHa4y1tosjPGnd5jjbThKIaetC5yVC6l6va4nTn9/COL9furdcF2QzcQLmtGLT0rMB1OLIA==
X-Received: by 2002:a62:6304:0:b029:164:38fe:771e with SMTP id x4-20020a6263040000b029016438fe771emr12863077pfb.1.1605504697837;
        Sun, 15 Nov 2020 21:31:37 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:618e:9b0a:75fd:1290:bf5c:a350])
        by smtp.gmail.com with ESMTPSA id a11sm16893231pfn.125.2020.11.15.21.31.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Nov 2020 21:31:37 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:01:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/8] arm64: dts: bitmain: Use generic "ngpios" rather
 than "snps,nr-gpios"
Message-ID: <20201116053128.GC3926@Mani-XPS-13-9360>
References: <20201109170258.4a70c768@xhacker.debian>
 <20201109170431.5687732e@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109170431.5687732e@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 05:04:31PM +0800, Jisheng Zhang wrote:
> This is to remove similar errors as below:
> 
> OF: /.../gpio-port@0: could not find phandle
> 
> Commit 7569486d79ae ("gpio: dwapb: Add ngpios DT-property support")
> explained the reason of above errors well and added the generic
> "ngpios" property, let's use it.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/bitmain/bm1880.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
> index fa6e6905f588..53a9b76057aa 100644
> --- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
> +++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
> @@ -127,7 +127,7 @@ porta: gpio-controller@0 {
>  				compatible = "snps,dw-apb-gpio-port";
>  				gpio-controller;
>  				#gpio-cells = <2>;
> -				snps,nr-gpios = <32>;
> +				ngpios = <32>;
>  				reg = <0>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> @@ -145,7 +145,7 @@ portb: gpio-controller@0 {
>  				compatible = "snps,dw-apb-gpio-port";
>  				gpio-controller;
>  				#gpio-cells = <2>;
> -				snps,nr-gpios = <32>;
> +				ngpios = <32>;
>  				reg = <0>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> @@ -163,7 +163,7 @@ portc: gpio-controller@0 {
>  				compatible = "snps,dw-apb-gpio-port";
>  				gpio-controller;
>  				#gpio-cells = <2>;
> -				snps,nr-gpios = <8>;
> +				ngpios = <8>;
>  				reg = <0>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> -- 
> 2.29.2
> 
