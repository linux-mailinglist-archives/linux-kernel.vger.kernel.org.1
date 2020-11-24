Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835BA2C2354
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbgKXKyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732309AbgKXKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:54:08 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF92C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:54:07 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a186so2013327wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kvdr8KP4BhHPunB6/HiX28Sf9PSdmI9kMBfi8vaUsaQ=;
        b=Al1ICsudCsEbcON7RNT7a0Aq78qbaIjzkhprm1rz6a59jc1X7l9uuJitKRcl/SxyGM
         3RadN3gB39d3VNCKxPPNecy9fP1t9roSKy8Bnyrv1s26sin9R9GPRKSv37d7pn9zfDKu
         YV9HGC59lYbc3LsGq3TFTSt7MM2h6gUeTGAD7YcWL7Sv6G6x3hJ2iUUHMQ/B5Qh09KCg
         /ScovBicjTLEts2r89XApTzbaljzMdjLcFFP9o9TsYEA/tQys8UKzWbbqEgFAhW6ci0x
         YLTt4F8odZQmK+5KeZazDes3cq4gk1EOTq0sNTS7PitYkQe8hIsdF+UKlhlJyp+lFmBx
         wvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kvdr8KP4BhHPunB6/HiX28Sf9PSdmI9kMBfi8vaUsaQ=;
        b=ugHYzaRqFyMkFt7Ux7QBVqTWwyrBUERFI9plWitF021mQ3uCZojjbWI9GQnZ6oKGwL
         IXwsxx7JAHUyjxlV7zKpn6IWkpBifUhjO3p9jZAQtVJA/TT9gZ9yehqjuiK+BilhXlo7
         6X4feUnSqaE8HDosSudtz+w5dNwXqIEJpaBwdi/+l6JbiXQg3HVNq3aDQQ65ljis3k30
         MCz+0EXOm1vBJ9Z0UsKgRDqJRHQX5U59pvBq7EU0WhosE4fJU1Mxz72bXVavK8igCPHp
         0H0l6i6CNpqK2E12tIl0yICzlvYPzO0r8Ij59gOP5ipJcTarvvVyg2RrhXP5FafO/AAZ
         PWdA==
X-Gm-Message-State: AOAM532/BBhG71gsZ2eL0LVpSaUzpjYyEm6TlD7cE5D+pUVvFG5ED/YG
        hQCftK1+dEIE9PzKeCbHCO14Wg==
X-Google-Smtp-Source: ABdhPJxdsl2r1PW9eMx03bqdIbiAzAu599V8F/cQEp3EzXU3lEc4g9vLOKzCqj4J2BCsZVy4Ht54Ig==
X-Received: by 2002:a1c:2c88:: with SMTP id s130mr3773241wms.79.1606215246270;
        Tue, 24 Nov 2020 02:54:06 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id z8sm18928761wrv.0.2020.11.24.02.54.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 02:54:05 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: mtk-efuse: add documentation for
 MT8516 SoC
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org
References: <20201016171837.3261310-1-fparent@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d5cade4b-de2e-9137-ef0d-afd3c11d1884@linaro.org>
Date:   Tue, 24 Nov 2020 10:54:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201016171837.3261310-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/10/2020 18:18, Fabien Parent wrote:
> Add binding documentation for MT8516 SoCs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

I have picked up the dt-bindings patch, but dts changes have to go via 
arm-soc tree!

--srini
