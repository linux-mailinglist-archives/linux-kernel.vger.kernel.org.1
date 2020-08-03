Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E0E23B0F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 01:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgHCXbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 19:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgHCXbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:31:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31556C061757
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:31:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c15so4057529lfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fV01at6U179YYTkypCe1mjYEuoEGSoyCBx3vei1jsL8=;
        b=kLZPFNzaiLoIf37Ocp6yoJdmJakN2FAOgin1yWPmvyiqcRGfvkDyLIJwgFnR7SibjW
         eDY6+V7iRkT7GmQRC7Mtk5KyBDTfuD4CL/PYuTQzAyQQrWqL/YynpbMpKEODLM1f/W4J
         tTGBCULVUmvrDKbcEgpiT565Jo4ros0QWA0bYpY6RJDKjOiSUgsq1W+8rhBSuZCNVWm5
         ZvesqRzD3GSrQDRSgUP2N6M9Y3PZtprj4rkT3HM4EbsoGyagbd2z8n5C7uB4Afu2c6nU
         sWyQBZzktZkb9o84466l36KfybPylh8PrYGMkgKxsqc6rvL/aU1nDW78+MUAsnA8ldTx
         tOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fV01at6U179YYTkypCe1mjYEuoEGSoyCBx3vei1jsL8=;
        b=HoZZ6stAnPvKA1eFTo7RAObN4bXibg5A+K8aY5VCBY+tDsg4LpS5G2d2D3Unygs4f+
         /8jUzVxytBK3WF62H3FdIu6TznkySqSjoW77wAL3/pJNguEiouthdFpbBlhO6H/yv5ti
         SDYhJjgP88HMZ4BfcD7Q2hiXwI0hHzokjcIEIba4+hv2LxIO2qhFGcSZ0lywi9B5xtgp
         b7FxRymY6yEeWiNFjV5+xWhdJqMhQJPeva4t9FKjBqy37CrEBkdqjCzpdlSxWWxwo34f
         /8L/HhWpl7Jkyo+06ccNRtr5vstkPYtxGsNPgeZBWXQuAjmO0CMjs/tHS6N0fbisXJwG
         XUJQ==
X-Gm-Message-State: AOAM5317xUZMtxiF/CNzbGsV70uRVFj0Vb17mb+I9B9U38j/T72lEgKA
        xiDLvXq/rJxCB6pLMOC6bzw2o3FT8hECnxGFe35Xhg==
X-Google-Smtp-Source: ABdhPJxWx+hfDk0lqptunggKbQMSvFYj4Ku0H41x8vXU6S8/mAV1QIwpU4LOkgKmpf8w7QdtsdTt1LUVSEoJbOHVisk=
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr9486395lfg.194.1596497479493;
 Mon, 03 Aug 2020 16:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <1596115816-11758-1-git-send-email-hanks.chen@mediatek.com> <1596115816-11758-2-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1596115816-11758-2-git-send-email-hanks.chen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Aug 2020 01:31:08 +0200
Message-ID: <CACRpkdYP1EGemHtqO_vrUf-wUyimAs=tXM5WNBD-NcL-h15ZhQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] dt-bindings: pinctrl: add bindings for MediaTek
 MT6779 SoC
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Andy Teng <andy.teng@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 3:30 PM Hanks Chen <hanks.chen@mediatek.com> wrote:

> From: Andy Teng <andy.teng@mediatek.com>
>
> Add devicetree bindings for MediaTek MT6779 pinctrl driver.
>
> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>

I pulled out the v9 version of this patch and applied v10 instead.

Yours,
Linus Walleij
