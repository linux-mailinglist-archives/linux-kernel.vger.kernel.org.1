Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C632C815F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgK3JtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbgK3JtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:49:03 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0387C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:48:22 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d3so14549795wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UUC9TeaDt9H+HkNFYhBbM/UEMd5LTexKU46ek/gKx0k=;
        b=wIoujYJEt5nZ0wsrvBh+wUJgyeXGVojtiXDhiHQCR0m2n4rALbTqmBtA4zr922Kww2
         Th+Sn76q0ClBBBC4rnRvIh1bXxaASAf6qEkP1OH3ORCMT/iHmP/Z2pxfx66AYpDRq7lJ
         vyYQI1+8wigLwmXb13FiUbYMWhvoxT6IHnVes8K1wI9h5apsga8cTaqMr9zghwcuhGbk
         D+M7gcRJ1Cs39p4tKHCHRbgnRjKdT9Eedsk3Iu3pRQMPTwjfAFISZJ3XX6jYtbiQTGmJ
         Vq4k6yArWHzjhX34r7FYauHJa4iG1HSHREoZJlePp9oHDse75uovr7i6gKS992Mkz5q2
         9TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UUC9TeaDt9H+HkNFYhBbM/UEMd5LTexKU46ek/gKx0k=;
        b=e3lZbdAvp9aIg0H/FpSMVGHjgFyHmi0m0tb3A+SJr6/xNu6xyKhLheNAPrcexnFCYr
         sILFLb1RRslQmzLhyfgVpf11D7FXD6cqA9ipaubRaZ0jrXk1lowc67CwmKHgtu3SoXft
         FksO4/gMSRfKEvgySFawfRgk1NI7V23UIV1VrDwEm288BLr3bQ5LfVg+LcYJnCl5Acg7
         7d8Hk1H0+0pbASlANewfbJqkNgBKYmShceu/54LYPIp1u1YtHsoiHiKdGnYd52o//VHd
         hAHhW7/ANE5jchsuPjM3snEbAGtgXZ7YBnL/630Zr+JabwOblaFe4GsCk4v0t2v5Qk6S
         QF2g==
X-Gm-Message-State: AOAM532Pcluag8j3SMZSqT7Caaxb8PJq0b6IywcWYo2Y0U8PJNMoKBw9
        hn2S3auGsZ+RvbqTpVNBrtjAxw==
X-Google-Smtp-Source: ABdhPJzpbS2D5PSEImmJ9SGWzBH48Cl4LQCF8ul7eaXWpe+pFOLqtlp/EKVVXKRrSnCPVR8kmE4f2w==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr22293158wmj.76.1606729701414;
        Mon, 30 Nov 2020 01:48:21 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id s13sm6274987wmj.28.2020.11.30.01.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 01:48:20 -0800 (PST)
Subject: Re: [PATCH v10 01/19] dt-bindings: memory: tegra20: emc: Document
 opp-supported-hw property
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201123002723.28463-1-digetx@gmail.com>
 <20201123002723.28463-2-digetx@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <46b3bab7-1c2c-2f50-6e41-f411e532357b@linaro.org>
Date:   Mon, 30 Nov 2020 11:48:18 +0200
MIME-Version: 1.0
In-Reply-To: <20201123002723.28463-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.20 2:27, Dmitry Osipenko wrote:
> Document opp-supported-hw property, which is not strictly necessary to
> have on Tegra20, but it's very convenient to have because all other SoC
> core devices will use hardware versioning, and thus, it's good to maintain
> the consistency.

Hi Dmitry,

I believe Krzysztof is waiting for Ack on the binding before merging
this patch (and the rest), but unfortunately it was not sent to the
DT mailing list for review.

Thanks,
Georgi

> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   .../bindings/memory-controllers/nvidia,tegra20-emc.txt      | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> index 67ac8d1297da..fe99ce1013bd 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> @@ -16,6 +16,12 @@ Properties:
>   - #interconnect-cells : Should be 0.
>   - operating-points-v2: See ../bindings/opp/opp.txt for details.
>   
> +For each opp entry in 'operating-points-v2' table:
> +- opp-supported-hw: One bitfield indicating SoC process ID mask
> +
> +	A bitwise AND is performed against this value and if any bit
> +	matches, the OPP gets enabled.
> +
>   Optional properties:
>   - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
>   
> 

