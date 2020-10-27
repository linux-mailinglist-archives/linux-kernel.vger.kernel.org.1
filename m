Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1D29A967
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897796AbgJ0KUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:20:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54218 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897798AbgJ0KTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:19:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id d78so810610wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pZ4tF9Q35IB/PKnNsjsCcJxf1aDEpdznaVzDYuv50v0=;
        b=C/n8t7qiHHIkKH6qBlW/WOBQPU58wfsvqwRg3TcTxZVnfjMweZXACSUeQ2Yr0SJona
         bdgxQpS37set3XzGvi8D9HYTSw1RmWWModldxM0e+cGehXYXRU3K1mTjOK4kL6y6nXo5
         /axUIi8EVPPR1jt57T2cmyeoVG/atnjZdaO6/010kCwExM5C4qTg8Gv2OwtoRDRI/Wxn
         BmXfJXcLVV6OgliOWyqFM9J+HmGm+kg7QrCtLylTtWhX7bp2PpYVCEtkQbYr2pOTj/vX
         hOgbmlhiz1rrdO/0zg6f1qwltCzISSTi3Q6IV68wglD4tuMZOCdDa7vWfcS9uy2c4oGG
         wz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pZ4tF9Q35IB/PKnNsjsCcJxf1aDEpdznaVzDYuv50v0=;
        b=GduZe0MPD7/llQzk7RtRQfZch54wkEx3s2Kl63gK/RC9jpUKWnk/4CfWvyBZGmWWqn
         wzkmWfJvoXvuFQvmadCVTBxVRn4lWxmQ/9reh7gmjFEx43zUIgITMtbSBn1bFcxs5lfW
         tyj6XIFHs96uldcxsgwq6FTSd7Ss4FnhGUAR1InZfQXAjdm7y22g7mDYbtkxnAleGnOX
         uO39HHXSC40aASewjOuxv2DprYke0fiwbJTU6ZP+tFoI/cFB8PdWrjo4+8ZyQKyGKW+R
         XCl3QmCdvrm7OgHFm/QGMW489vQJRB7BsYbrYm/juGdWvDiESb2n35rX1VqhiceqZjhe
         mnTQ==
X-Gm-Message-State: AOAM530tXVqaPYLLnbkqMQ0mkR01WJ+Kme57nuUPn64tFBMOCBTfrm1e
        e5rDUkSq8Fk36Aa1htzNXjU/Cg==
X-Google-Smtp-Source: ABdhPJzce/1cq7vO5et/wMCpGxoUY58Gq/wHtjsAUhmiTgM1W35aRGvgZYGxLwfJWRUAVClAG3qCoA==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr1911316wml.178.1603793987905;
        Tue, 27 Oct 2020 03:19:47 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451? ([2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451])
        by smtp.googlemail.com with ESMTPSA id l16sm1472264wrx.5.2020.10.27.03.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 03:19:47 -0700 (PDT)
Subject: Re: [PATCH 1/3] dt-bindings: thermal: mediatek: make resets property
 optional
To:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com
References: <20201021164231.3029956-1-fparent@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d8a5ce64-04da-7a4a-bcb9-1cc25cea42db@linaro.org>
Date:   Tue, 27 Oct 2020 11:19:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021164231.3029956-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2020 18:42, Fabien Parent wrote:
> MT8516 Thermal IP does not support reset. Make the resets property
> optional in order to be able to support MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---

Applied, thanks




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
