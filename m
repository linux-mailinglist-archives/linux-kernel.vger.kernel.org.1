Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE5E21E49A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 02:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGNAgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 20:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgGNAgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:36:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CACFC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:36:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a14so6808725pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A7lpw6xuEk98E7l/Wdgz5P9zvThUyBZ2UkYBSt1Hrdo=;
        b=RjJpjRvCeLyEGpg4MIYDt/ZGKyckJkPDjyT4JZAk6F8Zjul6IXJY/mNRnwqtUXKLLs
         hs5kBKjpaeqx/ZOx1JR3zh+Ekb9aGAl9d5RmQq3GJyz0u1vkJCUMbPizqbQRmbBxufTf
         VGxEHkDEfwsPwbmHPG9bzuaridwPz03UJUv5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7lpw6xuEk98E7l/Wdgz5P9zvThUyBZ2UkYBSt1Hrdo=;
        b=QbTn1iKze8VlbZXgK6B1lKzivRC9ATFTKO5wohiz1tsqF4CLf3bA/7VTzhGsN/PSIP
         lXkHK02HFI62Vq8hJpeLSXpbILhHiE4davXlL2uDvTJyIA1aAI6DWx5lCBLtqFBHVQpI
         nsdiQaMmi/JwKzJ4PDzwoz/KlQPH690UjFG3uBms37sR+1nYFslW82bje42vnxMh4Y1A
         cSI7o8r1uz6El06ZBqeqJJuVlhEVP9374vTIEAYImiWpXuLw/NPRCtg34Gc3sHgblNoN
         9X7kCgqlGj81FAmXS9C+Klupir+BgTbqa1MV83vctTw6ggBqGwypZ5/PZdiQfH0nOysy
         IpHQ==
X-Gm-Message-State: AOAM530AoX5l0frOYJWRQ7gu1CMTPLN5h89Jsr72zozyeCvjuqv3bCJE
        iGYRR8b/vo29Qjc5Qn02ae/UBg==
X-Google-Smtp-Source: ABdhPJxHMHL3gvRbWi8K6hyKlsY+h7vOtYivEYiBYHkW/4wu/JcZ+ysku+NUBYwSAHd9i63V7asVEw==
X-Received: by 2002:a63:e24d:: with SMTP id y13mr1415981pgj.248.1594686966735;
        Mon, 13 Jul 2020 17:36:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id 186sm15402499pfe.1.2020.07.13.17.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 17:36:05 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:36:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     stanimir.varbanov@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: sc7180: Add OPP tables and power-domains
 for venus
Message-ID: <20200714003603.GP3191083@google.com>
References: <1593603638-19296-1-git-send-email-rnayak@codeaurora.org>
 <1593603638-19296-4-git-send-email-rnayak@codeaurora.org>
 <20200701165414.GB3191083@google.com>
 <1ce702e1-6deb-8f13-3e17-38170b136b2c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ce702e1-6deb-8f13-3e17-38170b136b2c@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 02:26:14PM +0530, Rajendra Nayak wrote:
> 
> On 7/1/2020 10:24 PM, Matthias Kaehlcke wrote:
> > On Wed, Jul 01, 2020 at 05:10:38PM +0530, Rajendra Nayak wrote:
> > > Add the OPP tables in order to be able to vote on the performance state
> > > of a power-domain
> > > 
> > > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sc7180.dtsi | 35 +++++++++++++++++++++++++++++++++--
> > >   1 file changed, 33 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > index ad57df2..738a741 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > @@ -2392,8 +2392,10 @@
> > >   			reg = <0 0x0aa00000 0 0xff000>;
> > >   			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> > >   			power-domains = <&videocc VENUS_GDSC>,
> > > -					<&videocc VCODEC0_GDSC>;
> > > -			power-domain-names = "venus", "vcodec0";
> > > +					<&videocc VCODEC0_GDSC>,
> > > +					<&rpmhpd SC7180_CX>;
> > > +			power-domain-names = "venus", "vcodec0", "opp-pd";
> > > +			operating-points-v2 = <&venus_opp_table>;
> > >   			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> > >   				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> > >   				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
> > > @@ -2414,6 +2416,35 @@
> > >   			video-encoder {
> > >   				compatible = "venus-encoder";
> > >   			};
> > > +
> > > +			venus_opp_table: venus-opp-table {
> > > +				compatible = "operating-points-v2";
> > > +
> > > +				opp-200000000 {
> > > +					opp-hz = /bits/ 64 <150000000>;
> > > +					required-opps = <&rpmhpd_opp_low_svs>;
> > > +				};
> > > +
> > > +				opp-320000000 {
> > > +					opp-hz = /bits/ 64 <270000000>;
> > > +					required-opps = <&rpmhpd_opp_svs>;
> > > +				};
> > > +
> > > +				opp-380000000 {
> > > +					opp-hz = /bits/ 64 <340000000>;
> > > +					required-opps = <&rpmhpd_opp_svs_l1>;
> > > +				};
> > > +
> > > +				opp-444000000 {
> > > +					opp-hz = /bits/ 64 <434000000>;
> > > +					required-opps = <&rpmhpd_opp_nom>;
> > > +				};
> > > +
> > > +				opp-533000000 {
> > > +					opp-hz = /bits/ 64 <500000000>;
> > > +					required-opps = <&rpmhpd_opp_turbo>;
> > > +				};
> > 
> > the labels of the OPP nodes don't match the specified frequencies
> 
> Oops, I'll fix and respin.

ping, it seems the respin is still pending
