Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1D526798C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 12:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgILKbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 06:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgILKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 06:31:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33726C061757
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 03:31:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so14517238ljg.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 03:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nqLEtIwvK/EbczcZ3jk1qcSGestWoV05xtB32zvNzic=;
        b=hCvfuXiPp8HJBbZG0l/3Jbipu9f8xKI61/bEfj7yNj5hB1Nu3Tq17Ijlr5JLDa32fi
         hxlkr3xT+mHH0IXTY1tB0m6X9NhbgR4Tp4iz5BP2onDKFPX3tri/xS9r7I0rxWyR/bnA
         iW6fMan6lb+helDhG/rTUPi09xFpP3hXH6GZepGTa3anwyfvM1VMN2/S0IlIT8uksNf1
         1NEgYJW96LQ0TeMrP6jZxsV9oLUaufDVKF+rEnsSrI48UlPQ643aenGFe+wLXjnmaP1g
         kfqeeGU0JV26qoagi/rvGi/FrZeZ4JBX59txoHs7vH0YiBA7NNVwGIXcYKG4iDsjsoH1
         S+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nqLEtIwvK/EbczcZ3jk1qcSGestWoV05xtB32zvNzic=;
        b=PvKmWG+3mSm8DIsWN0iFCeaTeS408tiaBY8Jie7YK+vLFGnhsYMfgSopDj05OpbGQQ
         jtRE9LLPjULfPsuRYJYu0LE2YfzsDbRuuFkePCjWe8MfLZA5hdB6k4mTgI3GStWmoVK/
         CRGLHprKqKmw3klOGDW7SxBETDufqGT6CJ6E3hrxn6LVU9NXXa/EAyj6V/mH2fQPZ7c2
         qFeVnHe+wC1Vyfunz4w1yCIlQy7xdhvgNASV9jRAj4BBcSJ26EqfS/MJI1oNNJOEir1i
         VBChjorvlZVuwJ5FR+vomwR+0277zmbr1bbP7A901HfpGqOdwhLZBx72cK8lsj2Vxsks
         Tuvw==
X-Gm-Message-State: AOAM5322wusvNxcWWMkZ3dEm8+sH799B0v0jukfKgsbIjMsr82AYUCaK
        wVxz7LYzFfBoZ2t66HDaCmtToitlumWfTSLowM2SgD3BkvA=
X-Google-Smtp-Source: ABdhPJwxQQ4So4+24yv1p3RplMFD3YddPUuixU5O4ZxYauh3Wj3TWIT3t0UuKTe6tw+yv9jAjEVPe1GQ7Uk9PW3+yT8=
X-Received: by 2002:a2e:9988:: with SMTP id w8mr2333823lji.286.1599906672401;
 Sat, 12 Sep 2020 03:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200912060425.30423-1-zhouyanjie@wanyeetech.com>
In-Reply-To: <20200912060425.30423-1-zhouyanjie@wanyeetech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 12:31:01 +0200
Message-ID: <CACRpkdYGg_w2wzw7T0PHjEomkqFn8Jw4bTzfovi5qT0qdScMvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] pinctrl: Ingenic: Add support for SSI and I2S pins.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 8:05 AM =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)
<zhouyanjie@wanyeetech.com> wrote:

> 1.Add SSI pins support for JZ4770 and JZ4780.
> 2.Correct the pullup and pulldown parameters of JZ4780.
> 3.Add I2S pins support for JZ4780, X1000, X1500, and X1830.
>
> v2->v3:
> 1.Add Paul Cercueil's Reviewed-by.
> 2.Fix bug about PE15's pull-up parameter.

This looks good to me, I'm just waiting for Paul to look at patches 2&3
before applying.

Yours,
Linus Walleij
