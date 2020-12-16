Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9AE2DBD24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgLPIzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLPIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:55:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420CEC061793
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:55:14 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i9so22383295wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2X0i4LnWvhmDFLe5iRLCVbqdwzEb8VnCa7MUUVftSIM=;
        b=KKmFkvJ6+Pp0k13eW7K9dRJ/GBUKcTyFvlGvGPyPit+Bpk+KcV+OAAahNMFpxvU/Bb
         Wztaqcp4EgYcBCeaAwGe21cdweZAM1n6zvXnos7neKCAXNLclMWC72JjcM73dLQQyLt8
         CqS1tUPM/GBFgcsxYBuoK4evReKaupUR6e7vsQgHU7V6speuCHLs4OJEmZJpN7WZTZpm
         y5TuGzZj/Q3dqObtYThHAx54Ws5c+/PYXhj415osZcGp57dEQ16ub/6pn/glREnzl5s4
         lc8Li4PwLuY5Gzan+UxSJnRFIIa/xv80WavF6eaKPXhUVSknBwtJ8G75gvTfOPrjwCOu
         K3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2X0i4LnWvhmDFLe5iRLCVbqdwzEb8VnCa7MUUVftSIM=;
        b=X3iiKSoBpi5SEDOEGJwm1s12I6zuWeCeDos0PImwny8atMYuo0oxprev3tdJeLXfUd
         7b+vkRtqY4+AU2+Oz9TFmsuEre43Hw1OzuVUNW/5mWV3/OQaLnoemN67gRDV4Wyutis8
         Sva25CNvzi4IQHP/cFURl4J2JFty+J3MdteGWk43xKu2+zu5Xl83OXVKBPbP2Z302/Y8
         f9XZGfYgDg0+DB6YDganB13xunmUp5bhi785tXX1xuykCfS2ZefrJLMXA8A8ank76e8A
         YkzgBFGknxd+DzQDFVLwQJfjs45SdNWVHk9l2QlVOo8eUUr8FC23tDBXNANC7KjLGdFl
         2TUg==
X-Gm-Message-State: AOAM530vIyC7h7hdnZuL//ybeHesMMhKMxMueS1+LSnFGG2LvFVziYfz
        CmAdpbVDO2gNWLluklFqdz+WD/vm87y8niDa
X-Google-Smtp-Source: ABdhPJwnGtS9A/gGhOBAsI7ahIG2u0mP9aR4+czSbE59/b/1ukS60p297avYZmDALN8JBC/eVFK0rQ==
X-Received: by 2002:adf:a29d:: with SMTP id s29mr36867749wra.272.1608108913046;
        Wed, 16 Dec 2020 00:55:13 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id b73sm5275396wmb.0.2020.12.16.00.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 00:55:12 -0800 (PST)
Date:   Wed, 16 Dec 2020 08:55:10 +0000
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
Subject: Re: [RFC PATCH v2 6/6] MFD: bd71828: differentiate bd71828 and
 bd71827 chargers
Message-ID: <20201216085510.GH4776@dell>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
 <a892b00bd90bcd09e124b3a8e306ededebb64d08.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a892b00bd90bcd09e124b3a8e306ededebb64d08.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Dec 2020, Matti Vaittinen wrote:

> BD71828 and BD71827 charger blocks have some minor differencies.
> Use own name for BD71828 so that charger driver can differentiate
> these by device-id.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> This patch is also provided in this RFC version only for the sake
> of the completeness.
> 
>  drivers/mfd/rohm-bd71828.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
