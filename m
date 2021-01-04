Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDABF2E97E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbhADO7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbhADO7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:59:39 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52FC061794
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:58:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m12so64957678lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVbg/9337K0Ip60GD15691uF6SSutbUGQce683Uj4qw=;
        b=Iut0KXok5ey0haBtjfeAjjLqNi3G9W1vkeD13A0Ik5vUCWpJ+HDpRm2h1fki5PiFhi
         qKjgYtDkbRXM+C+zRIuFuGHVe7gLvqnkrtJ4xG3Nk682pyE9+YCQ5sEMR1nur8K7hM/t
         yi9/QPy5Kff8O+XucXbToVK0QFvhmc+12oI0LYYrmodZGPm0feYJZiVHFY3y597ctvNl
         rX6yQdJt/dmjoHMHAfzhUKtiDQQNyoS+s2B2SeCuNvY+axOVki4MAJ9EzrLgZKSeWEhv
         RzhNzoNXTd/elglaA7G5kZxiEKtOxkzgHr7C3X/T2v/7U+bjuHLqN2aJPBa26MasquZd
         XIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVbg/9337K0Ip60GD15691uF6SSutbUGQce683Uj4qw=;
        b=Y4qVHd1L2wKBzGyuWgZKrBGGgmJLFtZd9CtMvWSZddZEIGxwQFj6p6vMG8E3fjccBq
         Zd8UH5/su8IzKPGoetll/HLNxaxF2az5Ma2rkYuB2JswjdkCQ1Atau4fagidLFq/waRS
         2j4lEkmtwpNKIILJtZJ3lsWcYOqPuj9+kJlUmWoVe6C2aGxboFhM1qr7zQaNgQX4oMRJ
         T7SOMi5hDQJL/FWMK9ZkN90ANDYoTKl4WqMKVY23bv/kRXyWn8HTtOETERXUIUdGpby/
         8s5DIDdzBAjoC5aFFZ4Dp3PYA7UyjLEY83+qAv7uT1b+CnIPv+LRYmurmCEMBcNDsY/G
         LX/Q==
X-Gm-Message-State: AOAM530ojGkuuwLisxhtwMt4C85G/Bt6AOYK+J72CyLFAv7z/u7aTDAy
        hJ2wljj8VDiCpw0l3LU5yMF4Rp5YM1rFmlKmRTxGaQ==
X-Google-Smtp-Source: ABdhPJxCNu35Ylb75XyJViFXGvclq2TO1RTTIwq5yDpbN8VP7zLiKQ8YN0rs9fDqAwYAX6aRjaqTRYp2pEGJDeXHBXw=
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr34000037ljj.438.1609772338002;
 Mon, 04 Jan 2021 06:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20201217144338.3129140-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20201217144338.3129140-3-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20201217144338.3129140-3-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Jan 2021 15:58:47 +0100
Message-ID: <CACRpkdZeqqH_tev3USrC5BzX_w1rsjFQA=uGDZLPXZDG6jooKg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] gpio: visconti: Add Toshiba Visconti GPIO support
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

> Add the GPIO driver for Toshiba Visconti ARM SoCs.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

This version is perfect!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Bartosz: this hits pinctrl but it's fine to merge to the GPIO tree, should
not cause any problems.

Yours,
Linus Walleij
