Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B8327A7EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgI1Gvp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 02:51:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42482 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1Gvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:51:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id b12so9789612lfp.9;
        Sun, 27 Sep 2020 23:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NSd7kmJ0XPqlHiWdJOBvLiYopxwgxQJXndbLZWccj+w=;
        b=IZ9mbs5Ja7bieq9BrNecWGedrnUttnGRZDsaM42zgwmpboctgA73TEi+Dz0se0Pd2/
         rKotYx8HbAiakCwnHpSXtKn9VT7WXlj2i3f6wFsMM9l9NCsYcKt1Lrf2EXdOHaPF3olX
         uIZ/sJLE80kHVIaxLd4/hOGuajWn13RoeN1AQtDrydFkxBGjLvaC3saccpRbe9YGHCRf
         9d7lwOf/smQ+ivbzZhoQz2qpkM/+uEYUbhJ5omnB19smKUNsqA5hpOxf4MuhJ78OnYaX
         1R2vFApRmTx3k2uavpsizUMohilR/e5RFXbmm5nt4ggTdYPUP9H6+9zhPnx8g+3NMSP1
         A0gg==
X-Gm-Message-State: AOAM532A7KLqkQtPdiNz+r8UxuXSX28tMbyiknqmx2DW7c2VsPl6Wxwa
        4cG3Wz1mw+73IJNLyQVwJKwqwkP0/7jaMA==
X-Google-Smtp-Source: ABdhPJx/eH00ilQbLp+Osu9qx9GBJ+3vcWR/H6760Irr4qmzKqPfIY2484s8wh5KbCDJKph39IfzfQ==
X-Received: by 2002:a05:6512:214c:: with SMTP id s12mr3791338lfr.18.1601275902620;
        Sun, 27 Sep 2020 23:51:42 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id p9sm8275ljj.52.2020.09.27.23.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 23:51:41 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id m5so9810466lfp.7;
        Sun, 27 Sep 2020 23:51:41 -0700 (PDT)
X-Received: by 2002:a19:4281:: with SMTP id p123mr3134583lfa.398.1601275901690;
 Sun, 27 Sep 2020 23:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-7-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-7-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 14:51:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ExC9idS3ZW_EPsTNjmVb05op04CdeWfx2O3sN2Fp2gA@mail.gmail.com>
Message-ID: <CAGb2v64ExC9idS3ZW_EPsTNjmVb05op04CdeWfx2O3sN2Fp2gA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 06/20] ASoc: sun4i-i2s: Add 20 and 24 bit support
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 3:29 AM Clément Péron <peron.clem@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> Extend the functionality of the driver to include support of 20 and
> 24 bits per sample.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
