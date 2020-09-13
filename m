Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584862681EC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 01:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgIMXv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 19:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgIMXvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 19:51:22 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AACCC061787
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 16:51:22 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so15326269qki.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 16:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XLWo34hVmrRnf5YKo6+XZqj/MmF2UL5Q5POaUTSSFD4=;
        b=Oxb/XftV9EJLx2usmOAADNyqYCAUr9ixeBY4PxTr9dbotHOeaxq7pDy6oMZhPlPqvS
         JpF7WsxeZ2vlWZsk9CRndihWd0BD6+Xz33ANgiZEfT/0Z4a641vatesd4TM3XcvdbF+U
         uCVzQY/MYDik5l1IVpOd+wvmUcrM4aVmGcBaVYu6ynXh/Ln4o2ZXMq4Y4HG/2TgiSGqg
         e7W0xODdKoBsAvbJ+cQmvAOIIs8tm4Io2o3TtfO6EHaKFK6iaXzIpp5hIJ6hhGspBX01
         WOa4vPHS8jGQRSyGfKaPIUSYvYBlfV5YQ4J+vquXArURpkFQeeiUYOQRh0PnEiYo2sJ+
         kfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XLWo34hVmrRnf5YKo6+XZqj/MmF2UL5Q5POaUTSSFD4=;
        b=AxmbYtRbYZAN+e6SbYzTbCPWAPlQ6eRdGP7aKPATQWWPAdTv6wdh9+L0aNJIrSFBHr
         V9/SUTcpvkXrmz/FB+KUDbeo3t0HkG4CIvkG1sgS01kn+YsQhVUvOP7x5ase0E4G5/4P
         SEe1ahYEaRlxu0xCqOs28exVkg0Swm6oC/dbqdO9fjUCEQAMnFNRzXdywp/Q00KiX2Qo
         /pu8YoSkjl+R1frP0TYQCJZarMTv5U9rkn/v4JQgBF2VOt20PrdoUCobnn2Urhmj7esz
         7Jj/sDwGZzIGu0MbY6QWLXhoC3OvZp6I0SKwnk59w/H8tPzRba8G18HEewEafsYyLJv8
         V76A==
X-Gm-Message-State: AOAM532CIVafJVk8WFU0HZpx/5QZNngr6GAfNsgz+1JLsSyouz+WqhFq
        YXqAgmT4aTH8dTh9rqWcHcKpDg==
X-Google-Smtp-Source: ABdhPJwyMYMBmANq3AG/NorWJ3U6hjr9n5RXkcGdotOIi3gXPMKLWDHHS8TA2LSD1U+xVfHdpE0UvQ==
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr10923317qkw.65.1600041080727;
        Sun, 13 Sep 2020 16:51:20 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id u13sm12022354qtv.57.2020.09.13.16.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 16:51:20 -0700 (PDT)
Date:   Sun, 13 Sep 2020 23:51:18 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org
Subject: Re: [RESEND v1] arm64: dts: qcom: sc7180: Remove clock for bluetooth
 on SC7180 IDP board
Message-ID: <20200913235118.GD472@uller>
References: <1599734980-22580-1-git-send-email-gubbaven@codeaurora.org>
 <C8D04890-4F62-4EEB-9113-BAFFF46E32BD@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8D04890-4F62-4EEB-9113-BAFFF46E32BD@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11 Sep 07:11 UTC 2020, Marcel Holtmann wrote:

> Hi,
> 

Hi Marcel,

> > Removed voting for RPMH_RF_CLK2 which is not required as it is
> > getting managed by BT SoC through SW_CTRL line.
> > 
> > Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> > ---
> > arch/arm64/boot/dts/qcom/sc7180-idp.dts | 1 -
> > 1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > index 4e9149d..b295d01 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > @@ -348,7 +348,6 @@
> > 		vddrf-supply = <&vreg_l2c_1p3>;
> > 		vddch0-supply = <&vreg_l10c_3p3>;
> > 		max-speed = <3200000>;
> > -		clocks = <&rpmhcc RPMH_RF_CLK2>;
> > 	};
> > };
> 
> is anybody picking up this patch or should I take it through the bluetooth-next tree?
> 

I've now picked it through the qcom tree.

Thanks,
Bjorn
