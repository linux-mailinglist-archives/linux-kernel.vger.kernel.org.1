Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8376B27A7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1GvP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 02:51:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37773 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgI1GvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:51:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id z19so9815514lfr.4;
        Sun, 27 Sep 2020 23:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTACXA1Hxtvq1CFGlNEl/z/KQP4lC3PCO/x6XgxWWX8=;
        b=V7eQwb6LblE8h1JrNXH8/t4NfFGI0br9OrvzsCdmyezqu0rNZBCnmgqDHu/bgpuc6F
         Q603R+lKWcBkHYtZX54Gh9nJ0ZfSZyRTmZ8XWIGuJkeEuBW4NN2H89J0xqpltdV9y8No
         D+VPcJcUmYaXYrYWih94236LwU2qwLxO++YC3KTNlO/LDRpZeSblsjbyLWsjix3y7jhu
         HIwWWedPmpprwO7JwasnOvFd/iWC4SYQZudLxIcavE7HwpsGSG36QlXdRowl7IrrkP4u
         umTFtranFfBBWgomSKf00AaN1+5HAxQIZLPdPdb1cqIm2VdN0FFTLpEfLX+AgOIUeLZ7
         ak0Q==
X-Gm-Message-State: AOAM533omfntJZO1XjrcOfBkUVMAu5zfUohzDX2aZFjNwzdTyw3ZgNIS
        lhSdUyIbkR7gFVdSDUk8RGni+2NAph9o0g==
X-Google-Smtp-Source: ABdhPJzCUcu5YTnYniVU96z8QbzGl4WthNgNpeaZrYsMxv+avWQedwtb3ixZmsHLELz7cUnTUDGutg==
X-Received: by 2002:a19:c7c1:: with SMTP id x184mr2954960lff.77.1601275872990;
        Sun, 27 Sep 2020 23:51:12 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id f9sm7650ljc.129.2020.09.27.23.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 23:51:12 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id b12so9788086lfp.9;
        Sun, 27 Sep 2020 23:51:12 -0700 (PDT)
X-Received: by 2002:ac2:5f63:: with SMTP id c3mr3139536lfc.283.1601275872275;
 Sun, 27 Sep 2020 23:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-9-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-9-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 14:51:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v64AZ2UO42fWU49m33-mx-CzEc1wLvRprb==FSf2XmcPWw@mail.gmail.com>
Message-ID: <CAGb2v64AZ2UO42fWU49m33-mx-CzEc1wLvRprb==FSf2XmcPWw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 08/20] ASoC: sun4i-i2s: Fix setting of
 FIFO modes
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
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 3:29 AM Clément Péron <peron.clem@gmail.com> wrote:
>
> From: Samuel Holland <samuel@sholland.org>
>
> Because SUN4I_I2S_FIFO_CTRL_REG is volatile, writes done while the
> regmap is cache-only are ignored. To work around this, move the
> configuration to a callback that runs while the ASoC core has a
> runtime PM reference to the device.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
