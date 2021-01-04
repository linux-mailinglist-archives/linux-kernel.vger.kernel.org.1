Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB42E9800
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbhADPBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbhADPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:01:41 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44426C061794
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:00:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b26so65003760lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 07:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tR4uUSuiT2yNCjy2l75xxGnO77PWcJQ+DtWty5i0rMc=;
        b=LJ/AsciYj2BKHcnJ73UgKyavCV9Qw6QPv4rj+dpkZQo3YhzjsIYgubutakzgyTilOD
         BP9w87saYt2mwvs7pZCpYcL045gJziDe+nWIOEIroRJOnA/6w6C3nho2eTCijDeSKdjt
         PBqhmEKevTBMFjsa0IcaooKAmbg3t91gOMxVs09uohr1nFJay1Z1SsD25Pw+7ggP08aJ
         5qjrV116BFU7LMFDr/xS64uW5vVHC3/z159BsSxs/JhDkCYSr0Lhd9QeDmh2c6lqrcBl
         BvcUQtSkdSewYsZD9JVB7IA4M8OtwXfkhg1fq/nM+bJu/vwBI0RnGutIae+G/ZtFnR4+
         UEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tR4uUSuiT2yNCjy2l75xxGnO77PWcJQ+DtWty5i0rMc=;
        b=msZ2euOWgbTmazfufxOmDVN7pSTK85AZjsZCvFz3cYs7CIlngBSX1sSRp0uRnGj2rr
         IdCtIsQrgZG1lzPa85jkf7TD1aYdji1hWBEtEHmPARXZyVlMsd4Hk6j11/BZ96wrT8DR
         1HGJunzb/WNxpvMOZ5dfgeGUbNPvRZZhTxJKUChIPiNNMUUwN5bvlwE2pI577WwqFIL8
         GGNcvaG9LFOWPMF8Rjs6q5vt4i9ni1ffVa+eAhxVGhwg845Yg+mxlfcpaHETy/jCa5M7
         s8Zkw+9QhlO+eHYVPKTa/K7KBJSuGSQDY5ON3jmKVZw/o9wxOcHLSN1rpn7zjmMFeXIt
         IroA==
X-Gm-Message-State: AOAM5324B9x7LxxcCxKutFxNoMFnJ47dw7XYaEDntSedkWsleudXCAf4
        sMT8XLRH5DqFxjnke/6aKrPei4GGUwcoeCr2i37pXg==
X-Google-Smtp-Source: ABdhPJw8BDy+1PA7BTXsFDKivU2qz6c7DgAaqRK4RmPbkQPgVpVra4mzO3RTstCIcQRAlI3tqm7JphEKl6JVoakBr3M=
X-Received: by 2002:a05:6512:74e:: with SMTP id c14mr34844158lfs.529.1609772422734;
 Mon, 04 Jan 2021 07:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20201217144338.3129140-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20201217144338.3129140-5-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20201217144338.3129140-5-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Jan 2021 16:00:11 +0100
Message-ID: <CACRpkdb--GSy-0vnAFS9Pik4TjrNRTrYeZr2RBZD6SFM8zotyQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] arm: dts: visconti: Add DT support for Toshiba
 Visconti5 GPIO driver
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 6:45 AM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:

> Add the GPIO node in Toshiba Visconti5 SoC-specific DT file.
> And enable the GPIO node in TMPV7708 RM main board's board-specific DT file.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this patch through the ARM SoC tree.

Yours,
Linus Walleij
