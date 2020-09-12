Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D5267B5D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 18:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgILQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgILQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 12:16:52 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F9C061757
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 09:16:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z17so8947102lfi.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9U094qqCq9d4miMet+MZEOYG8XbE21uClAnLKejltBc=;
        b=YAeVSe5Osg2SXWG44jaIOAY1b/3jhgKvB4Bu+/p517wil9XaoCFMb/SFfZKuBdlQ7k
         RxmGRUXxd0VLFX0exm5WSxx7aKflLcpDtUlppZUkuz3aQ79UR4TjIQeO2AhqqjR7Wkul
         mPaZmim0Li8U5WFu7vfqRf2mzIJm1R42Q2A+54i1j67bF30hTGLcmmQHBWuxl6NHLoyX
         9nclgltPHcYGCNxwmsSMBXQEPKS17dPFYi9GKRhFP6xMiA/ycvTq1fnOxpc8q4PTXTo2
         WrgWGvA3hM+6bda7WPisZUToo8MRKj4q88tefqK96HQxdKjF1OAPwKyck15Ses0a+tb4
         jlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9U094qqCq9d4miMet+MZEOYG8XbE21uClAnLKejltBc=;
        b=GARpyVhA8j5wUQaFRyiZJU9e3ZJE0JsRYNKi/TysNzRryWb8KjlzQYQ+0YE6qsGSh1
         7uYNLfIHWye6DEVcvFl0j87pJyhf5kZrle8ToNdS8AahgT3LKjoNqNesTGl2sHozku4+
         uPTjl+L8ehoofrjIfbshikybR08C2AnX9nq5fPOcMyMyuNGVGKGY4+q1czTM5icLfRqe
         RjaWQIZr0e5q3QC6xKbNq7bWzeHouBzAxj7qPqxNWkJ+0Bl9r+QV1xuVaBX/nK+1FmIO
         kGTn2uiJKSx6yk0KxO4+q99cnYD0CxNMs5un7b3gUt3C5hUsjBavEsHuC1ktGYCpm6QB
         Znug==
X-Gm-Message-State: AOAM531+kPk1bB5srPdmLj25kQCG1Ys0+Gai+3r9YNZmdEZaxO4Odyrn
        w81kDj7lO+t3J4fiJwhyVgNGYiwKTTqCV2V+pzZc+Q==
X-Google-Smtp-Source: ABdhPJyxyrQtW5hXYVHMhi10Oq4pHIB0NH2ATk3u2qZ+1xXJqbLNuSz38EwTMJ4U5Lfc1EZ+TVMsa1cmiQDormQOmwY=
X-Received: by 2002:a19:6c2:: with SMTP id 185mr1785569lfg.441.1599927409676;
 Sat, 12 Sep 2020 09:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200907211712.9697-1-chris.packham@alliedtelesis.co.nz> <20200907211712.9697-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200907211712.9697-4-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 18:16:39 +0200
Message-ID: <CACRpkdZ13B==RROumpfB1sjO_uPG0Jx-LRwjm-w_6wr_wb1v8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: Add i2c0 pinctrl information for 98dx3236
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 11:17 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> Add pinctrl information for the 98dx3236 (and variants). There is only
> one choice for i2c0 MPP14 and MPP15.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this through the ARM SoC maintenance path.

Yours,
Linus Walleij
