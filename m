Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43CE27A7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgI1Gtz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 02:49:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43582 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgI1Gtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:49:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id y2so9781374lfy.10;
        Sun, 27 Sep 2020 23:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0sGL25OAFSU0NyKSRPgNVNAwmqv5+p5DkVqXN1iipGQ=;
        b=gx9pt8PIqOctv0xrkT0a3bsf2hIF7LeZcAdGExSU0l+EHQddMdM4Lu3PaW5bUD+AFh
         IDGTRbpB8MFVzgXceMq3HxgEVOGW1cD4MD7c0AEuIDRVedT6alwrcDP/XHvPi+W2ZPGi
         O+OOqZhLkafaJ0PI5nkLsHTH4kCKExrzzmyLaZ1Z/zbzkCaqFEPjnmpEOpIJTl15E3C+
         LeOtJZuMgjMGGPxUhx+NwPOUGYOFDjVHq6vK0WqZIwq/QC9S0VWMAvSHqsb3BxM8g/tx
         yLVfRXR4ZUPZ1zJsHnK8mTJN+e6Zxbu41DfLCf8IGm/kCkNMkyHIKxT7NMqxVE73dHBw
         hgpg==
X-Gm-Message-State: AOAM532bjOvJjRhwdoQmGFoXn8DRGscFU3jfxm7J8Qby3v4Qac8EPPbj
        uvggfRyd6U92WN6BVdq13E4KTKLcefna6Q==
X-Google-Smtp-Source: ABdhPJxr2KdcevdyBWBZg5qfoPKpPLappMl8Gt5cnBjrpGRpo9h80VCTMYV70kbWMLFb2I6E7jQXvg==
X-Received: by 2002:a19:ac49:: with SMTP id r9mr3081451lfc.582.1601275792800;
        Sun, 27 Sep 2020 23:49:52 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id r15sm2710211lfn.259.2020.09.27.23.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 23:49:52 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id u21so104178ljl.6;
        Sun, 27 Sep 2020 23:49:52 -0700 (PDT)
X-Received: by 2002:a2e:a550:: with SMTP id e16mr4737780ljn.125.1601275792241;
 Sun, 27 Sep 2020 23:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-8-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-8-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 14:49:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v65FOois4RXZWZBu1x1TGy4Kb6Orw_FyHBu=yz_dXJ7HWw@mail.gmail.com>
Message-ID: <CAGb2v65FOois4RXZWZBu1x1TGy4Kb6Orw_FyHBu=yz_dXJ7HWw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 07/20] ASoC: sun4i-i2s: Fix sun8i
 volatile regs
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
> The FIFO TX reg is volatile and sun8i i2s register
> mapping is different from sun4i.
>
> Even if in this case it's doesn't create an issue,
> Avoid setting some regs that are undefined in sun8i.
>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
