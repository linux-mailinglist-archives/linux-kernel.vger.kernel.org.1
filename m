Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF22CEA0E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgLDIok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgLDIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:44:39 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94093C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:43:58 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v14so6609791lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KET1E+zuak3FlCY4zF7z/1ILHVvC2UNzSxg2qMKY1c0=;
        b=HxSx5uVAmmhLrfNvxVpDEfIm79FjWwE+/pIOwU9OCK4itu6RvC3I29vkt6XN+XnlQO
         35qbSosF0096esxtPaOnQPzrtaaFB7ldlWwSM8k6l7VOnau3V36cTZM947r6Yy5jxp6j
         V/UltUuV1NUcCDh14YfCLi2AQKk8jemX3ddOis+X+igZvQK39fa643oOfJrBRyI7Cdbb
         paw/zZAVesnY5ei4at4uYjHLTYCaHAvyWaqAf0sGcjOPfNlnYoyO7Pn8kbXazuKA3Z28
         OYVHXUhRguDKlf0ec/j9CbVkRgRlnWXbPEL1PlzphOt8/IImroG9s1ne8Axif63KivuQ
         WtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KET1E+zuak3FlCY4zF7z/1ILHVvC2UNzSxg2qMKY1c0=;
        b=krRe7MVCKGGv1l2jpgNwH99sQsVM2YXHaHVXujT4x/xIYIlNTEpuU1M+gPZJkTgowM
         wlXg0GpGUWS5WXcDkejmzE/ASB2LQxXLEybSkEIyCqZN0+SuGI6Owun+wNfNPmxf99gB
         27PSs89+frwPeI5Mc9p3RMR2M9JsqlbyTEtHjhJd0vW9G3TY9h6BLlIQJX6T3ZQTaiXb
         PSeuefcvGZ0d0luptssErgw6uSBx/jqnYT0zXO2JAntVN0hAtZLYU3u/5tVuvZmXfIkG
         kwXKZ6cTaYZHSK5ir1nzIbHt7YBvUem4f/MNm3ZT2XhVoSr3GYuWGdMSWc1SaOd2cvcf
         K+VA==
X-Gm-Message-State: AOAM530byj6PU7ZeY4kuLGdgvmuPA1kpQwO27BcRBTVxIpxd/B/Qxe6Y
        wAsf9F+ifq7g76rbJsNBvtiSUZZnX85a45716dPZ7Q==
X-Google-Smtp-Source: ABdhPJxSmtAp/6oFP6JQUcOPafIUSq25E/Xy3Sy4VeE2x4VQ+ZmXA8JyQPwmPHVM/WpFq9Ryq05QtDCFXaeHkuFJhTs=
X-Received: by 2002:ac2:4308:: with SMTP id l8mr2768677lfh.260.1607071437123;
 Fri, 04 Dec 2020 00:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20201120093058.7248-1-zhiyong.tao@mediatek.com> <20201120093058.7248-2-zhiyong.tao@mediatek.com>
In-Reply-To: <20201120093058.7248-2-zhiyong.tao@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 09:43:46 +0100
Message-ID: <CACRpkdYbVbgUEvGk4t2YHieUaFvMMg1EOR8opuCqm-w4wCYCOg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: fix low level output voltage issue
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, srv_heupstream@mediatek.com,
        hui.liu@mediatek.com, huang eddie <eddie.huang@mediatek.com>,
        jg_poxu@mediatek.com, Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, seiya.wang@mediatek.com,
        sj.huang@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:31 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This patch is used to fix low level output voltage issue.
> A pin is changed from input pull-up to output high.
> The Dout value of the pin is default as 0.
> If we change the direction of the pin before the dout value of the pin,
> It maybe produce a low level output voltage between "input pull-up" and
> "output high".
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

Patch applied!

Yours,
Linus Walleij
