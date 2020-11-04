Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666162A674F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgKDPTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgKDPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:19:22 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5704AC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:19:20 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so2720708wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D9YsrGN9wWLv3mX7dkJBqjaJH+HqiYhxAqtKcEQZoEQ=;
        b=ESOcqmcmdlSBpst0NLiwQTyp6ATQj/xVBJ8v/wHN0bGElMDhQzgtCbKjzMxYDimtOM
         QyBNdwZVHihtaYz9l9uXrPp5n8/UvcnVUMbVR1HBqL2iXmZFIDbNHdmwG8j4vvoCs1vq
         Q+0Embfu1d/pSYvA8ayGkQZsCW3dBfwAlpCTj6Z4sykz4keNk22VH+wgAMOuCuiHmQ0l
         Ib+NRQBONXAI+teuxoTRmG8CEjgy8p0VEWvPaSpCAkSMDVFQgWcWS+BD4vzNAi/2F5Vg
         gL1e+/LmL+JNuWxR+7yOpRWHPwGPoxebE4aZO2NDOTSobd1QUU9XN0++hxyXyZApuiTK
         lGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D9YsrGN9wWLv3mX7dkJBqjaJH+HqiYhxAqtKcEQZoEQ=;
        b=iE5O8IDDzLwpG7xvpTed7aQTPfntRQjJuAVzVFc5UemNxUh63uroFYEadOBJmlO1mJ
         qsisWAsOZIvBXegLmV3DN0q/2NG7hhYxAFyYVN5J8rxCclHGN/u9xxgM+9uPJAJr+hYK
         OTFxXva0+RuFsNoX7rr2oq+nwK0nsMzlgQTDVsWWy8BSizIbMnIbIqGr9/0ofHTao4cb
         e5ZYvxF7OGSOc0PNdNpv7FlWGzF3ABqhkgDg6BoB0nbWhACGJao7TasBTk4ylDm/qOYK
         b2oLea5jc6D7kny1WoXsW4dAcVydkChpPOOXPstBg/PIfpX855KpnHfo0fC+Tl4ZpNJM
         oA1g==
X-Gm-Message-State: AOAM5325YxEmWh8IIdtTGjGnkE8CcMSqLs8gUU50vz1cQ3lkWaXe4cAz
        /djU4D2ARKgjb2Uc/vDVkvP5oA==
X-Google-Smtp-Source: ABdhPJwjO9gdBQ3A1EtXca/y3WeuvIcYU20JPYHU2jSpFYSGJCsfNFJNSgvD9gAQ0LrvY1egrHrDjw==
X-Received: by 2002:a1c:6405:: with SMTP id y5mr5165258wmb.150.1604503158966;
        Wed, 04 Nov 2020 07:19:18 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id d20sm3205552wra.38.2020.11.04.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:19:18 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:19:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: rohm,bd71837-pmic: Add common
 properties
Message-ID: <20201104151916.GL4488@dell>
References: <20200917193754.542-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917193754.542-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020, Krzysztof Kozlowski wrote:

> Add common properties appearing in DTSes (clock-names,
> clock-output-names) with the common values (actually used in DTSes) to
> fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml:
>     pmic@4b: 'clock-names', 'clock-output-names', do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Define the names, as used in existing DTS files.
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
