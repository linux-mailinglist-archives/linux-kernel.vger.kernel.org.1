Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23A62965EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371579AbgJVUYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371571AbgJVUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:24:15 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D57C0613CE;
        Thu, 22 Oct 2020 13:24:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h12so2331302qtu.1;
        Thu, 22 Oct 2020 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JIPJmwTsNh5SVdjulcT6ULsOeryNuUVx7QrsaWRXGKE=;
        b=nB0juPaUvd+woSG83TZ0AtJVc8++wFINyUBploVSCp0nxbvoc/z/4vXPGLSfrqaEx2
         IB1ZO07vjVmzjZcridIesfQwGVab2hAXDu5I7z199M1MujNygXvXZOUQi3Z07B3fvNru
         7GCnBSIdkZ/wuIf/l7s1FqmkeQ+8av9/9JvxZZPJys0g5y0CeN7e2CzlErDd118oxVwf
         EA+kL1pyBJUo/HcEeG0Et0h9Ua5UGIAYtNypZCGSk7bvaJryD2Odc+AApR6KE1j82dS8
         Y+6451+53Rp+d2q6kIlEtYEC3dIvKdi7yi828/vRusRI+E3euoJYzJ1cS/5gFnR8Wyl3
         qskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JIPJmwTsNh5SVdjulcT6ULsOeryNuUVx7QrsaWRXGKE=;
        b=tlUmLXN4sDpVTGVKh8j8RXrc/YweikOnWNO8lJAYsVd5ZSIZ1wvMP+RxANAUrUSt/I
         mBfNS+nx6+LN9qwiavhhHbcJq9E+KsLnWZQ3eT8lW0yDEXZ+TCnnrKpctCFh3p42BDaR
         4RE/fwjpmTuWIAVO+H0gZCwDUtVvKfHWQWykVtHoHof2prQlugqmNlVvVOsAdREyCyOh
         l5bRKYXX24W2G1Kz670LwyjKKr6blnjz8TBtyiLqHYyGUOSIH5cFKB28cDBmi0RF/rk+
         U5C9L2g6bNtNBrsiHUIe8z7OPOor5BN6oIDUPbeUsuAPBgOhcHYI+yl7n06lxPor4luV
         yIDg==
X-Gm-Message-State: AOAM532JNOb9sPLCq418bvzSBIiFuJ9C+xTS9Ktx8KtXPkkIeak5GqNm
        yoPjgnJvwsjJcuSNSSI9ygA=
X-Google-Smtp-Source: ABdhPJzSBVQwe2YS0J/jcDJaxNvFDUtn2abbKQMDEvq0ttZUwl6OjsuzpKL8e5ZqGlsLPbLc1zRPTA==
X-Received: by 2002:ac8:977:: with SMTP id z52mr4038145qth.132.1603398254045;
        Thu, 22 Oct 2020 13:24:14 -0700 (PDT)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id b23sm1830786qkh.68.2020.10.22.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 13:24:13 -0700 (PDT)
Date:   Thu, 22 Oct 2020 16:24:11 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     florian.fainelli@broadcom.com, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: BCM5301X: Linksys EA9500 add port 5 and port 7
Message-ID: <20201022202411.GA254260@ubuntu>
References: <cover.1602701516.git.npcomplete13@gmail.com>
 <c51b1d53c9411a4321ddcb1dbcdb0a42945b23c4.1602701516.git.npcomplete13@gmail.com>
 <20201022201656.GA240761@ubuntu>
 <fc925a63-2caf-92d6-8e60-1cdb6f0d4c6d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc925a63-2caf-92d6-8e60-1cdb6f0d4c6d@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:21:10PM -0700, Florian Fainelli wrote:
> On 10/22/20 1:16 PM, Vivek Unune wrote:
> > On Wed, Oct 14, 2020 at 03:27:27PM -0400, Vivek Unune wrote:
> >> Add ports 5 and 7 which are connected to gmac cores 1 & 2.
> >> These will be disabled for now.
> >>
> >> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> >> ---
> >>  .../boot/dts/bcm47094-linksys-panamera.dts    | 24 +++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> >> index 9fcd215177d7..0ff502d5aa0c 100644
> >> --- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> >> +++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> >> @@ -242,6 +242,30 @@ port@4 {
> >>  			label = "wan";
> >>  		};
> >>  
> >> +		port@5 {
> >> +			reg = <5>;
> >> +			ethernet = <&gmac0>;
> >> +			label = "cpu";
> >> +			status = "disabled";
> >> +
> >> +			fixed-link {
> >> +				speed = <1000>;
> >> +				full-duplex;
> >> +			};
> >> +		};
> >> +
> >> +		port@7 {
> >> +			reg = <7>;
> >> +			ethernet = <&gmac1>;
> >> +			label = "cpu";
> >> +			status = "disabled";
> >> +
> >> +			fixed-link {
> >> +				speed = <1000>;
> >> +				full-duplex;
> >> +			};
> >> +		};
> >> +
> >>  		port@8 {
> >>  			reg = <8>;
> >>  			ethernet = <&gmac2>;
> >> -- 
> >> 2.25.1
> >>
> > 
> > Any feedback? 
> 
> Going through my queue of patches, I should be able to apply this patch
> soon.

Hi Florian,

Thanks for quick response!

-Vivek
