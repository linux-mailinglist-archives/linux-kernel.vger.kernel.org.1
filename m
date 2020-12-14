Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9592D94C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439632AbgLNJOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439612AbgLNJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:13:36 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954E7C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:12:38 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id x20so8752297lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTDh2buLaKgi2yPQinQGtaYvv2xqGHa+Au5l4AlQoj0=;
        b=hXesH1qK635+28r8wsbTwtUeSi4Ffe4e8z1VoKsA+lH2bLRjzka7u4AjfoAuOpY4Tq
         Gr0FAOygaZXlN35fz2z6jUSxsnKgBG53oPMfZTo/3gBbelxRKax5B2vcfWHDz7Ve0jhx
         7TEGr13379CuQ5JE6spcgMppkny1M4KzwkkBlH4ud53p89TNIpZpfB/tm/N1wiw/KjMt
         HmFSZyrSocmS14krLw7DzvctsTzopdnO+pWj9HjLEqHP5Kc2yR3LQw/dRTJ5YIpuyeYs
         F2WwG19hjajTg60ucAwG1l3DxNP3PX29ED3hB0yfm8qxx9+8JToYeyq80+1IZUJPUkuQ
         kp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTDh2buLaKgi2yPQinQGtaYvv2xqGHa+Au5l4AlQoj0=;
        b=V5+nXcYXtXxYHnUDvLoUOSd7UFsoJ83wDK83erzbLJHak1TlivEkjse0NP5fbyzjPw
         SU0afoD8rBDNn51nkhTfGc9erwOxP5ZFAhVSNAc843E8SxURxaHDFwm8SIHACQJVzCXf
         96T7o5OnWl3eV29nTTBSnySMCfqlhiIKrxwvsO2YdFi3dShMQ6kqzBnCT6f1CYaJZgX5
         y9q3b7y/dmBxFdjaLZbquPwXsgRg+Xvbxc4qBk1zHm7RH4gkcwoJ2CSN2Aasmz8m2QMg
         xRTtqaFSY/6YHIHkF6F5Hqv+6DLiSlvzfbi7V6Xvqm4yrdrcrfQc7yZ3vdm2FfHOrDre
         557Q==
X-Gm-Message-State: AOAM530Pl4Q7m1eZU+c0AqYz3iZl8iri6Dkp122/HdVX170TIiaihEAe
        lzLr876vkuDg0bubg4NhIJIzYaDV8w3g4mMHJbDpcQ==
X-Google-Smtp-Source: ABdhPJx+wdjqd0B+LtuOADpGbMDCd//6cNgHU1JpvzZWHjNCVpOZQdZPvl4xqBtadQZAEMsHtgrH6EP/SYkrKLG0CbI=
X-Received: by 2002:a05:6512:3f3:: with SMTP id n19mr1259183lfq.586.1607937157073;
 Mon, 14 Dec 2020 01:12:37 -0800 (PST)
MIME-Version: 1.0
References: <1607934255-52544-1-git-send-email-luojiaxing@huawei.com> <1607934255-52544-4-git-send-email-luojiaxing@huawei.com>
In-Reply-To: <1607934255-52544-4-git-send-email-luojiaxing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Dec 2020 10:12:26 +0100
Message-ID: <CACRpkdb6uk9UWYxL-n1z3hRLAn2-fbQ_zBg9dZp0VL0oJiLd4g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: defconfig: enable GPIO_HISI
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 9:24 AM Luo Jiaxing <luojiaxing@huawei.com> wrote:

> Enable GPIO controller for HiSilicon's ARM SoC.
>
> GPIO is common driver for HiSilicon's ARM SoC and it provide support for
> some function of I2C and SPI.
>
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>

Looks good, take this through the SoC tree with other platform support.

Yours,
Linus Walleij
