Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91527CF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgI2N2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgI2N2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:28:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19721C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:28:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n25so4024125ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMFcSFF9cTOWS1K+7BbYrvtV2Z+dL4/OOGad18uZwXY=;
        b=IXsBOy5RIAAn+M61rD2LUyZWAdu2fqQq563ccILvUTCOU2qTSQv9u9Cs9zSV23lIyD
         oUlvaHFh7+tfj2FHZzn7CvoxKuKzGeBtB8N4zYTdHFls0MP4Rh/bgodJ5UGB/s36TevF
         ZP/y/sM2uqRZgL16P+tej9QgKATo5I3fkIuNn2O+Ug2t6i5oQXUDRgCjrpgZONSUDQwR
         49K2mFfan3TDh9Bd2wSNYvlmWmOQXHUJCSP+cMLOfqqhmXxytQV35HF9rSCBVXolsQHL
         16L43uI5UFHKnYmdhQbdpTKCvFq+mlIOz1bf60tsI1IhTiRB39XS81+0/ilzrm5Qmg4P
         StZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMFcSFF9cTOWS1K+7BbYrvtV2Z+dL4/OOGad18uZwXY=;
        b=p3X3enAWjzLX2wgslGctlVzt8akdnzRvNHWJ3P2lC07fpdMRByNnXSiMScKa1dTlP5
         e1rlTmCH1TznI9kp2rAp6wBgjHfgcdEfkS/gZJLa/A6M+P/fHg6TT4teN5hxUJbzdnbo
         tmqFNzCxfGuESbwZrk/vWgCXG9cnnGQ6yLxju5CdlQPhPQkes7BkBay0Xm647fJk9ybr
         REmVu+nkRcweOGcBZGzYIqot0g7ki6ReyfY8abCsrnP0kJkrgVFA7/5D2MYtDleDekGa
         +6+l/iquoniJG6mEnQaf1AfSezKkau1+QxXSzyF3PunqQjFNlg5OuacEeoVr1RvxR8ek
         ESbA==
X-Gm-Message-State: AOAM531CYtCevciOjlkfNgkSmZIITCK+nJbzcUTdX4YpzPpvSso6yvPs
        oLYOWtEkdvKksIvMB9uOhduudErb33yFXY86FOnnJA==
X-Google-Smtp-Source: ABdhPJxeozH4n4En0aMUuCBCiTQAB5drzO20922BSsbJ0U7yzb99Rs0vcC6PWRTSNng3hq4FSm4UPdAQagf8ipEPmfY=
X-Received: by 2002:a2e:4e01:: with SMTP id c1mr1137898ljb.144.1601386115524;
 Tue, 29 Sep 2020 06:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200917131257.273882-1-eugen.hristev@microchip.com> <20200917131257.273882-2-eugen.hristev@microchip.com>
In-Reply-To: <20200917131257.273882-2-eugen.hristev@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 15:28:23 +0200
Message-ID: <CACRpkdZfNTRxJsBwNQt14MrvK6WK+VLFU2ot06hjGqy79gXKgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: at91-pio4: add support for sama7g5 SoC
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 3:13 PM Eugen Hristev
<eugen.hristev@microchip.com> wrote:

> Add support for sama7g5 pinctrl block, which has 5 PIO banks.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Patch applied.

Yours,
Linus Walleij
