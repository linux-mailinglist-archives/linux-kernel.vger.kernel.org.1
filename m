Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C28F27E5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgI3Juv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgI3Juv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:50:51 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1928C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:50:50 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y11so1364919lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kDE8wrBm+qziaG4g1g/VJGmcusF/BRkFisBqvCmFDc=;
        b=iB9qiHLogQUzM7o9zQ0HZSYyL+GiBm7AI8MvcXqzE0jGilJA0KZYljsZ8m9uKTTCQc
         R1njFwaJF0vK63FD5OBjwsuSnFdkTGxq798Au1eMT7JiYmwoqa0pwiHjvkaiSwV0ikqN
         RtmufQ+1PQox26UJ7CET8s54aSa4d1keVad5xLbcKEAKG+6H33cNjCWBYqwgxnLbyBq8
         XABwbLDKig7zrWK55uisXFhtb6jUAbChmHI6iQKy/MB+qAvXuIePzXWoGh9+DC1FGvFJ
         3S8LXpJdpL9q5RR+PEkKs4oeML1VVrza/35HZGGZwS5SnkZkSoNFX8lJJhpDxwnnuDQa
         QY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kDE8wrBm+qziaG4g1g/VJGmcusF/BRkFisBqvCmFDc=;
        b=tRhqedhIIJ7qXCZclNjgFAch/1zCc1F+FnKhSzqfVvsYYYYdCKadjq5Xn2lKRIhCwU
         T5YtiHsMYw+sYUHkIdUKATqwGmEiFB1QjVPXmte0LIJboLeuXOCo/ELROAJcgSewdq21
         cleo58QGMGuMCmPgVk2GkRieIFnnUWrT0cGnlJmvEwhag9+6SqicBHENPH7a/8xT+xFZ
         XYUX1XcGoJN0X7E0+ByNdFNPNfP/gm8DBKaNxhLOZD2o48LeZeg2489lGodCm8C8BioT
         a6CucR2BCB6fcRCg2MWcKTfeoziuhohKNsDqZ9WEhXmq3R+lz90wdrMAy/8CPnmZBQab
         9iZw==
X-Gm-Message-State: AOAM532II7beP7+WtuZWYTXDmAn1gpgosWax7bY44pWZxReoYoBGHmIi
        Mp2NSmqI8prElMwEjE/oPUSPkP/eFiy3t4QBA6zYS0fTGrDjlw==
X-Google-Smtp-Source: ABdhPJxm7dZ5605/6k4XUptX9QM1RtmPezAq+DEnqYIEsde95WBlbJgEIx/rubuQiw8SILz7iUX4fADZC23QYKW2izE=
X-Received: by 2002:ac2:4c11:: with SMTP id t17mr641852lfq.260.1601459449318;
 Wed, 30 Sep 2020 02:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200930092053.2114-1-mike.looijmans@topic.nl>
In-Reply-To: <20200930092053.2114-1-mike.looijmans@topic.nl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Sep 2020 11:50:38 +0200
Message-ID: <CACRpkdbsYcmv9m2EiQNgPDZ0MdjPnWTxXvnqATVPvWpB=8Oqkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: pca953x: Add support for the
 NXP PCAL9554B/C
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:21 AM Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The NXP PCAL9554B is a variant of the PCA953x GPIO expander,
> with 8 GPIOs, latched interrupts and some advanced configuration
> options. The "C" version only differs in I2C address.
>
> This adds the entry to the devicetree bindings.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Split devicetree and code into separate patches

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This patch 1/2 does not apply to my tree, I suppose Rob has
to apply it?

I will try to apply 2/2.

Yours,
Linus Walleij
