Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF272C61B2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgK0J3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgK0J3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:29:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1500C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:29:40 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 3so2140179wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ev967dxFte9OFk/FlLebu9t70Z0aPWOKCMJc2joTu6I=;
        b=kjNQy3nhmsYJ29GqJOawmFYupvRUeFLOeuZSOa4HBhulZKUXaMFFdWuF0wyMzJV15f
         2Z5HjHwbyBhHuzyAY39tyqwI/K6UratOcGjB/u4twbdYIHmLNbEajnrl4kZ4qNevonkm
         Y1eYGNEjDd+sRAehSNyrDqnOWuoKr60StKwnVJj+YobYpddujSvOGaFq2e/m39coczwj
         juQTPh+2v1zHBE1YECdWhFFqfOH9mehdcAhIW1epDggez9CsWLQmlpFAk7A2gzpLt1Jy
         +oWMCO2Vn6/PJ/mVeG5US+B0oAcU39mbDzsDL62IIWpTGOq8j4zOeeyFDnh5jwtC1VlA
         btCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ev967dxFte9OFk/FlLebu9t70Z0aPWOKCMJc2joTu6I=;
        b=WLT0jT9Id4O4iEVZnFvScLKIH1HZ6YNrpAPJ/fJlBCPMu7o8s7RCj4mdte9p154QSP
         AHy2yLgZ6i11y2zfmUGdCJXKcvl0ZHcFjqHxKaugC2l88lNOMOmLz/TkG2DARt3vnATB
         f6nTF/J765+y3/xV9dEW3rYq5EYF7dWZDV3Pc1Nb7fSLezhkPoACTT0Dee3TbmGIwHsF
         kXChiON1Y3nq9Z98rwkUa5G9ZIebG89edzb+F+HewdTGS8eW6smEaaf0rkUiVRHb89Ry
         6sELuiwx3ueCrD8PPZEzyYwSCyVfcdM9QzmKJnRJA8oJ3K2EM4YewROi4iILyKv2wmlk
         OFnw==
X-Gm-Message-State: AOAM530RXmFseRSVP4OQ4qHs0FUNSzLj/89qgZWH9dIOPIL6wevHaGSZ
        Ay7thVKN+ELoyUJGgoi6WvdHyw==
X-Google-Smtp-Source: ABdhPJxKFlW9DFzkz1ig5ZJMa0hLQOUNltALJm8SRZsGKnNIuq0oatMB/aLoZxjolx5LW69kKIHLsQ==
X-Received: by 2002:a1c:de85:: with SMTP id v127mr852773wmg.178.1606469379121;
        Fri, 27 Nov 2020 01:29:39 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id p19sm14377838wrg.18.2020.11.27.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:29:38 -0800 (PST)
Date:   Fri, 27 Nov 2020 09:29:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v3 1/8] mfd: mt6358: refine interrupt code
Message-ID: <20201127092936.GO2455276@dell>
References: <1606103290-15034-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1606103290-15034-2-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1606103290-15034-2-git-send-email-hsin-hsiung.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020, Hsin-Hsiung Wang wrote:

> This patch refines the interrupt related code to support new chips.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/mt6358-irq.c        | 65 +++++++++++++++++++--------------
>  include/linux/mfd/mt6358/core.h |  8 ++--
>  2 files changed, 41 insertions(+), 32 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
