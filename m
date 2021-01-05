Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC12EAE1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbhAEPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbhAEPQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:16:32 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A4C061796
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 07:15:51 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s26so73293792lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nipFXfidN4RGtXoyeMnYQAg6eHYZV+kT94xqPBVgEN0=;
        b=xnp2n1s9/EDnCP8h2gyp1OrnOFCclXF0pAG1maHJOGB6nzlHfeTpHZsXK089hu3l4M
         EZol3yzmQHMVReOEgUTIhZ+3JyLlb76itZdYkk91nDSApI4NJ7Nn6eRzuLtPH7TKWW/p
         hOC4h4/wnNMqX2tLlvwXi4yG4NOToANEP5DsWsUH7hX4gqIAUjnD2hFCzpCsO3Mz22Wl
         Uj10V2bqKTc+oIxz5dchsA0RDbl4oKzQ21Kj5sfIFMKwsN+xGGAZEWD0ugwOy8JEHd0y
         onNCNeDSluZ21Lr2U/7SdMZM0iHjllTDV72nnzTf5+ecUyUAb2mogxULSY3219ATL8uu
         N6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nipFXfidN4RGtXoyeMnYQAg6eHYZV+kT94xqPBVgEN0=;
        b=cj95bidR8cw5ZEXsTUvfI9eDbm9Rg+t9Tg1SRGfIX9P30seLi5b8us1Lkl8U5+I9Ep
         UA1d267Kj1MKFPlACzfkm+P1sdAgmQI9C/4Zt5aEd+ztLnMx+7/bVxTEQ2Iki5pbjr0A
         xbdyy8O9TC5lDR2s97C/2BKNqTcditPdZTauh/csVhPzj4QM55gtjV2++vuE8zN7RZXL
         RfkNDDdgJev/mPX1CWH3bjEBmo3Q2LLoEKKiR7TAt77mNLMzsB2Db3upqdDwEcd39PUI
         OckvmoQTAnLj2lAVgm1yiS1qEzrvTYnOThkDu1cVOeevEgn3IEmJgjGfNlSF/C/dGSaN
         zNeQ==
X-Gm-Message-State: AOAM533ah518N+P/5s4cEe0e3mrdptfJHj145ZRQzLyDyTdjnBLOGW30
        BT/t+gXxVnUi94+EtN/h+cD89xpXMEgwo3JWCJbmbw==
X-Google-Smtp-Source: ABdhPJy2ZGq9W2iVSjZbDZLyFO5NfyYMbkL3r9nIDYZhr3gaACstIDbNeGqw3SNzTuSJ6iuv37ViXqi/KfvpLZq23Uw=
X-Received: by 2002:a2e:3503:: with SMTP id z3mr63883ljz.74.1609859750250;
 Tue, 05 Jan 2021 07:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20201229204710.1129033-1-natechancellor@gmail.com>
In-Reply-To: <20201229204710.1129033-1-natechancellor@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Jan 2021 16:15:39 +0100
Message-ID: <CACRpkdbYC5Q7NfVLVBjW79AJPaWx0iQ2_XeU2A7ur73qqpZXsw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: Remove unused variable in nmk_gpio_dbg_show_one
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 9:47 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused
> variable 'wake' [-Wunused-variable]
>                 bool wake;
>                      ^
> 1 warning generated.
>
> There were two wake declarations added to nmk_gpio_dbg_show_one when
> converting it to use irq_has_action but only one is used within its
> scope. Remove the unused one so there is no more warning.
>
> Fixes: f3925032d7fd ("pinctrl: nomadik: Use irq_has_action()")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Patch applied.

Yours,
Linus Walleij
