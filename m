Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82832B7031
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgKQUfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgKQUfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:35:30 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA984C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:35:29 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 74so31979272lfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CUqG2S3O5iVKKIdkeqzaWrGNBNP8isqkl4rsycIm70U=;
        b=oWhwGjqYt6rOLIpCStPQBXV8QWtZnwUn/hQGu52cU3RUIPT5wxF/peJnuiQHp87yzn
         q1KV/E/rxa6f2f3yZOqY0DAEe+DMtfwyiGPz8ajXUwPF5KpNzzEjLuUcOOsMpfFBnRlk
         cJROJM55gDbZHFVVLUmOc0MjHJKTec80sVQOWzihCtp9FIDskjS0Eo/TIrpzJpNhlgaS
         XnSUsK2555TuXhrzI5tYV6En9AkpSonFJSuGXk1n8kJJXUOVYR4pAFn5oQqEbSAqCWqW
         E1ER1hg6dzTIv1qln8i5nHRQYA05BHveho1X0IOLmu735CVMH6OzBxtn/zeHBY4JwQkX
         9nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CUqG2S3O5iVKKIdkeqzaWrGNBNP8isqkl4rsycIm70U=;
        b=QnmzDc/sfbcJBhGfJBZyCk3bmoV9C/QBWj25UgbYP7wz/0d3+iSXRFuhvv+aWspIwV
         LII6sm97h1cqYo/pVng95gcG2zOWmT9COe72RaLHxQWHXWTqeN40ZT+Y2brZL3k3BIKL
         sfUzY1SRcuOGe20JSpSdbm/cIW4leoTR/MW5mYXO4VOa8oruHIG5UWrbGhpj44Q4NIzo
         fvGeGjZlfn7+CqnI1WpEbks0b9KXR8a0Rlpvo65d4OHjndM3X2BYmVF8NLr7y+CVoGBc
         TORLLeF9D8uX28lrgIQPABiok2zWObqJ/wOuT5cHp+nhX0WQr0HOEFFFT/NJatCtcCAv
         bQ0g==
X-Gm-Message-State: AOAM533WiuQBrtf5j1qnFz6ltxyoQusr7w48bdhkIfb9FDtE9nxWPWLq
        1C75XWxXHPtc/2z37Nu6QqhSNEn0hMEOpZCzLhjRTg==
X-Google-Smtp-Source: ABdhPJwCDvm4/w79+gK5F8PMQmv1tpX3mMErfW/IFt4EzZL/b27lJfAggTSLrQyOPxfCwI6a1O+grGFL5Rq39GYdYr8=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr2565896lfc.260.1605645328269;
 Tue, 17 Nov 2020 12:35:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605635248.git.agx@sigxcpu.org> <85b58da3eb68b81c1bdf7fc2f4a38b1f9ad8c90a.1605635248.git.agx@sigxcpu.org>
In-Reply-To: <85b58da3eb68b81c1bdf7fc2f4a38b1f9ad8c90a.1605635248.git.agx@sigxcpu.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Nov 2020 21:35:17 +0100
Message-ID: <CACRpkdZ982o2pNbg0Zcfma80HmemRWyLBmsgeqpQTUdknD1=UQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] drm/panel: st7703: Use dev_err_probe
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 6:49 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> Less code and easier probe deferral debugging.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
