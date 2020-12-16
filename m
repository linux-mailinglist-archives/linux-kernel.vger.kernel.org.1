Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815C72DBCFD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgLPItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgLPItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:49:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:49:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v14so1560013wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l4pG1Pz6PU6BYg+Ons56js1u6LMgRJqpxucbIg8sLcU=;
        b=JV7DcFcoPU8Q06Eo6cBJlSHy15JlVZIYxasCySaRNv0rB8RyGK8UzkJaFagpeQai8s
         FtmmCynbYdCGGdpl21trfNc79mILT3t4PsbQJXX354R9ck8vxaqDGqEX7MYv104kD+ig
         +tXdvD5d05Q5IZFaXqzsLvFHRrN44Ilm93YISFq4vlzgHk45rBX8HjRn8g49kOJcuuSa
         CMqZIArqYsEq6Q/1qb/Z2+xLxCHyMEsQJYFZ7PMIB9EpR/RKwkszxQFLzx6jzJibBt5y
         DpaLxzQzwP6zTdod2WbOs2zBm411sViebUWooQfuKC69Wc7DdKn0kwjGq2i8Tmau09CO
         YX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l4pG1Pz6PU6BYg+Ons56js1u6LMgRJqpxucbIg8sLcU=;
        b=jvNrqMTeJ/QMbGn7SCsDtFN5Doom6Rtb9hjEiJJfkQFMjo/G8eXdh15NzJYXdsxn2G
         AGTKQVB8t6hEDRTdBs6UzbUsG+x7C7i+tjD3CmIt7CIOPEKdPyMz5brf3EM18srES91i
         24i4XTnRuxUQ/XvQrr4yOWf1IIehEsGYXO2Fx4bj9AL6n5NEBr0ipQPcN6nSYJ4NDozg
         RUfyukR4Z3YcAnzgV6g5G3LqFXNOUzXDqqtVPJBSjaZHDQGfvAHhmHw7WKR2ODq0VUpq
         /+LHNrC71ZuZY2H/Hafx3GfWWT162zDKP0PSp5mtOqjnljVcWgesz3J+VxpU0LwILOVz
         BTtg==
X-Gm-Message-State: AOAM532AWPXU4IjCKwAsidHMfu42d+oDzYEukeOtAOnOU3Cpfn4aEtau
        jYVk4Sr21hqKR2FM3fH3xfP5qQ==
X-Google-Smtp-Source: ABdhPJynNviiVsoHEVLV5Stk9nh4YhwIKNs2V/N5RfPELL4AjIonhzQgP5UtN3WBhFivqikNHqKIGA==
X-Received: by 2002:a1c:c305:: with SMTP id t5mr2193290wmf.63.1608108550701;
        Wed, 16 Dec 2020 00:49:10 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id x13sm2112513wrp.80.2020.12.16.00.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 00:49:09 -0800 (PST)
Date:   Wed, 16 Dec 2020 08:49:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Cong Pham <cpham2403@gmail.com>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/6] mfd: prepare to support BD718xx-charger
Message-ID: <20201216084907.GF4776@dell>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
 <ebcd976ba60a8cf417787b8b0643f12dcc68cf0a.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebcd976ba60a8cf417787b8b0643f12dcc68cf0a.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Dec 2020, Matti Vaittinen wrote:

> Add definitions for ROHM BD718(27/28/78) PMIC's charger blocks.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> This patch was not in v1. This brings in some charger registers
> for the BD71828 charger driver which is in following patches. Patch
> split here reflects the subsystem change (for non RFC submitted for
> inclusion this would probably be Lee's territory). Now provided in
> this RFC series to give more context
> 
>  include/linux/mfd/rohm-bd71828.h | 65 ++++++++++++++++++++++++++++++++
>  include/linux/mfd/rohm-generic.h |  2 +
>  2 files changed, 67 insertions(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
