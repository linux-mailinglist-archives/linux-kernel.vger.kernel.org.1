Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FAC2965E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371411AbgJVURA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S367981AbgJVUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:16:59 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93381C0613CE;
        Thu, 22 Oct 2020 13:16:59 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c15so2304966qtc.2;
        Thu, 22 Oct 2020 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EQsWz3VPU1vMWM27JV3KasG3iRuntrc+EW0ua4woOM8=;
        b=GvfykBIR+fXX0CgLL1YLF0O6IJh6RlO0usHaiJtl4ge1gVnYQqhyXZt4iAh7izQ+sC
         dEYE8yYAYsaDpqcxIHZXCvmflx09vM9r5ieKDoNOM4CT2f39Y3+qBPKF1tVinAHauPVU
         98W8l6nmWuCx5aXvUzNbx2ttPXg7/qXrh1APJcyIpGydifUJW6A/2xVM1zpNLzSJ5hrN
         7YuoTnU6sdLIWliQo8N7O89zakJgcPLpBmrweDuKBbdvuwYp/Swf29uDk2rpX4mZWdv2
         +SmynaeKwjFxWVeBkVHeVf2aKgPRbKsV40CgfnA4P4pVsOKVhbusGNB9lQr9mcnhM6Be
         tn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EQsWz3VPU1vMWM27JV3KasG3iRuntrc+EW0ua4woOM8=;
        b=ocwbYhwMzj9hW9AE46gDp20hvDhpre7enlIMkvGIYiGEBgA8SVUduslMz5XWJ6hfGQ
         MjcEEqH30gkWpXO39LvJEyedWL6OEsCj6/v6+ET9b66ATDydQleAGPEumvbvBT80XQNA
         iU6ikBpX5wpxlCGF17JIUNgrUOMIEWBmrO/RZyft9EBmHQRVHSxxHM8Od9Wdlph91qaL
         bGLdW+vsSRwbpUtIemmGkOE1ydmaSQUzmeIXb2LoK+ysgItfjSYjm1bYkgjhQLuUjcGn
         luZJTydaS5L0PL/F42+UFSdyL6Jjpng3G8+weXNV1DQdFkYSaWo5dSY/Rxty47koxaoH
         Xmvw==
X-Gm-Message-State: AOAM5339Pjg4qnK3aZ1ZJsPN+6Tb89t0eCbl2YsAQv+Mrx/D3Eu/J505
        XXaeFLx7lEVMTzvJeS1NNCs=
X-Google-Smtp-Source: ABdhPJxxGfqRkFgwWgKLd/TE9bcmEfGkWWIHyB5ci3QoXiEWYYGulYlyUgpIZywfpcqI2wsz3LGesw==
X-Received: by 2002:ac8:588d:: with SMTP id t13mr3818913qta.380.1603397818818;
        Thu, 22 Oct 2020 13:16:58 -0700 (PDT)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id v204sm1847486qka.4.2020.10.22.13.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 13:16:58 -0700 (PDT)
Date:   Thu, 22 Oct 2020 16:16:56 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     florian.fainelli@broadcom.com, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: BCM5301X: Linksys EA9500 add port 5 and port 7
Message-ID: <20201022201656.GA240761@ubuntu>
References: <cover.1602701516.git.npcomplete13@gmail.com>
 <c51b1d53c9411a4321ddcb1dbcdb0a42945b23c4.1602701516.git.npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c51b1d53c9411a4321ddcb1dbcdb0a42945b23c4.1602701516.git.npcomplete13@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 03:27:27PM -0400, Vivek Unune wrote:
> Add ports 5 and 7 which are connected to gmac cores 1 & 2.
> These will be disabled for now.
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> ---
>  .../boot/dts/bcm47094-linksys-panamera.dts    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> index 9fcd215177d7..0ff502d5aa0c 100644
> --- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> +++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> @@ -242,6 +242,30 @@ port@4 {
>  			label = "wan";
>  		};
>  
> +		port@5 {
> +			reg = <5>;
> +			ethernet = <&gmac0>;
> +			label = "cpu";
> +			status = "disabled";
> +
> +			fixed-link {
> +				speed = <1000>;
> +				full-duplex;
> +			};
> +		};
> +
> +		port@7 {
> +			reg = <7>;
> +			ethernet = <&gmac1>;
> +			label = "cpu";
> +			status = "disabled";
> +
> +			fixed-link {
> +				speed = <1000>;
> +				full-duplex;
> +			};
> +		};
> +
>  		port@8 {
>  			reg = <8>;
>  			ethernet = <&gmac2>;
> -- 
> 2.25.1
>

Any feedback? 

Thanks!

Vivek
