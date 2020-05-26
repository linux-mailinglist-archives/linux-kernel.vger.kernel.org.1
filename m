Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995DF1D41D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 01:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgENXpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 19:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgENXpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:45:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D6C05BD09
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:45:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so98491pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TS6m3tA7iP1dUmXkdet+rM4d6JbY2zF/WsqwIammF8E=;
        b=YjE6uPBGNr4Xe2rTD6hCoXF0Vo9fHrPRc8MeseKVAqIDzm93Jk/d4QULhMOfJ8ilHN
         Zi+1iu5vNwfDcdCueh1FAVNZq4QKsfXe4HeVxZ3O4Sm3d4u9KQh5EYd4GWvVNH8cfzkT
         qmyscxwZ7Tq16XPqH5qqJR6toOuYAZyl+KBnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TS6m3tA7iP1dUmXkdet+rM4d6JbY2zF/WsqwIammF8E=;
        b=D3RWO8mUXiA0J3r1EqnJFVUov0ZD64VkFkYxIsHdPbdM67GeaITKYabryI7Zk4GyWi
         yMirFHijQ5/iNa7ud9Juv7BR8Ha5tPSBVsaafFVmUpeWTN8jKDwPT00q7N2XwRmcQhCd
         /k3x5Xk/ytBnK373CY6hujJuTjxzh4dRhcOR3Ka9nHZ3E2aSJzUiDmeaIVNSYKkaWCga
         wlahrDNb/jYNph1HGRIzznqVLndjXunDXZzBs/dk3Oade64ufuJbuhg33oKvWWuVBP4V
         +frlIRP98qyJ9N9BePbpwt0tPCkylAn0MiaODn4PIfmKdfFaGt373HyFoj6Y7j2yy07I
         ii/Q==
X-Gm-Message-State: AOAM530b1zwZ5kT9ktxCkjfbIdw7oslq+GHWFTUOdvfWQXdXCsE5i80I
        VC8ETiEl7mmwKhwQRe8m1qWCLA==
X-Google-Smtp-Source: ABdhPJx4mHQv2BFmu1UqFEL0Rzavx5iPrdT2xRUY4noa8VccK+9T65lv35xK9Ign6IhTDiC7W+uE/Q==
X-Received: by 2002:a63:1845:: with SMTP id 5mr519761pgy.69.1589499907739;
        Thu, 14 May 2020 16:45:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w84sm265543pfc.116.2020.05.14.16.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 16:45:07 -0700 (PDT)
Date:   Thu, 14 May 2020 16:45:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        georgi.djakov@linaro.org
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sc7180: Add opp-peak-kBps to GPU
 opp
Message-ID: <20200514234506.GS4525@google.com>
References: <1589453659-27581-1-git-send-email-smasetty@codeaurora.org>
 <1589453659-27581-3-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1589453659-27581-3-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:24:15PM +0530, Sharat Masetty wrote:

> Subject: arm64: dts: qcom: sc7180: Add opp-peak-kBps to GPU opp

nit: s/opp/OPPs/

>
> Add opp-peak-kBps bindings to the GPU opp table, listing the peak
> GPU -> DDR bandwidth requirement for each opp level. This will be
> used to scale the DDR bandwidth along with the GPU frequency dynamically.
> 
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 0ce9921..89f7767 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1392,36 +1392,43 @@
>  				opp-800000000 {
>  					opp-hz = /bits/ 64 <800000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					opp-peak-kBps = <8532000>;
>  				};
> 
>  				opp-650000000 {
>  					opp-hz = /bits/ 64 <650000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					opp-peak-kBps = <7216000>;
>  				};
> 
>  				opp-565000000 {
>  					opp-hz = /bits/ 64 <565000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					opp-peak-kBps = <5412000>;
>  				};
> 
>  				opp-430000000 {
>  					opp-hz = /bits/ 64 <430000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-peak-kBps = <5412000>;

I suppose it's intentional that the bandwidth is the same as for opp-565000000,
just want to mention it for if it's a C&P error.


>  				};
> 
>  				opp-355000000 {
>  					opp-hz = /bits/ 64 <355000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					opp-peak-kBps = <3072000>;
>  				};
> 
>  				opp-267000000 {
>  					opp-hz = /bits/ 64 <267000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					opp-peak-kBps = <3072000>;
>  				};

ditto

>  				opp-180000000 {
>  					opp-hz = /bits/ 64 <180000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +					opp-peak-kBps = <1804000>;
>  				};
>  			};
>  		};

assuming the repeated bandwidths are indeed intentional:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
