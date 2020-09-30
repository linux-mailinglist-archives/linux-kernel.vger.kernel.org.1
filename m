Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865C527E432
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgI3Ixx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgI3Ixx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:53:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820EEC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:53:51 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m5so1176401lfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3z2xOif8bgrl4CXIfjrJIpR+vLzOyA+RktpULqT3bh0=;
        b=qrofEe4M1Xd/el20IewAIFLEt4T8hUHh/n3Q1WXwOuKu3e2R4xpOQBO2TBhln5msHM
         FGsckaPK88lI2NhWKga5UDDsfC0pUTzx2a/f+Prnt/aaNJuZhYtsdIaGQtqHrWZLbDve
         +SXI2jRCFzFnFEgXOxElCgSfXePsUiP/9DJxdTyLdYPqRXZ/DzM6CeqifPWCDfe+1nfV
         3zZEYx2dgqahuhN6vaOgy9YU/cMWLAiMuTerlD6//ZqEUnP/pbg7Wwym+nxkYDjtDWlj
         RF+j/fCbtpvYLw5HK6i9V2IrpXiOlnQkmTKFRQfGNylSRab3xzsPqiypuduF8wvSsb7G
         L44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3z2xOif8bgrl4CXIfjrJIpR+vLzOyA+RktpULqT3bh0=;
        b=eEEm/DXpHotaPEJ2Z5SkVjZx0u5acS7Hi9UeeAYac0D2kPpmMO+s4SMdhIJ98qDA+S
         c1NNyGVokCqzrPgfVQR3vIwrJbQcikEujumli8hTN46B/RBz60prx5ql8sKSYAYkOLHK
         hAiRidOtt4WLwznVLh+HWFhZIzhnCZLB3qvjBwihlK5cQIRF3v28SV8bfBDLK/papK5K
         6EU454l0114z96GQoY/tLpPFEmW0ZvolBF2ayCbFx+nll6HU5mdjP6ikt0qs7xnXDiou
         BLdnGjgSS9X8SRTB5HwjN88Q7uKZBmQSsgO0M3dRRG90ZyZEpyPYqfeLlcaREABVywWC
         tbVA==
X-Gm-Message-State: AOAM5331Ix+tIvMC+D7OaSAn4EKRV32cU7LprS5sa7+3L5HniUWhWVWK
        5i9Fon/ZJfCqBBpAAyHch8+OIxjquGsDrTN2s70zhA==
X-Google-Smtp-Source: ABdhPJzi4flBuB3wmmmt9LtKMpa6PA1KfwRmboYTD0A5gCDHKZ3c33ZbcjL3MiGZbitzxdQhZsN3HZRaN/nxffefeQo=
X-Received: by 2002:a19:1c8:: with SMTP id 191mr484379lfb.585.1601456029840;
 Wed, 30 Sep 2020 01:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200921131056.92848-1-miaoqinglang@huawei.com>
In-Reply-To: <20200921131056.92848-1-miaoqinglang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Sep 2020 10:53:39 +0200
Message-ID: <CACRpkdZxgw7zmmWyVpxQ5N60Yxzj+u_LPAkRGN0qS3A4DqKNgw@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: mediatek: simplify the return expression
 of mtk_pinconf_bias_disable_set_rev1()
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 3:10 PM Qinglang Miao <miaoqinglang@huawei.com> wrote:

> Simplify the return expression.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

This patch does not apply to the pinctrl "devel" branch, please
rebase and resend, include Sean's ACK.
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Yours,
Linus Walleij
