Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C80227A6B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1FDQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 01:03:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40844 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgI1FDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:03:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id m5so9557313lfp.7;
        Sun, 27 Sep 2020 22:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iH4BCtKHYZco8jOSQGiNPWj56rYDuIQ1wb3Pt3Sr0IY=;
        b=uDvaSqf8bfnboSEG3hwab3oZ6hCWJthvFPo3L1YL0lERt4UwfVo7BiouO+L/aJZzTS
         b77KGJ3YQ5B4pmsSgDgl/V3QoJGEjZM/78TAt4W1TyK3pjA21//7wTI/aJ/WI98SmqQW
         vrZm0pOvzNQBEEmQwhc6DlgB8lePgYbIg0We0Q8FD++4kjEM+SQHu0zW0Xm5Cw+2040g
         zVdDJ/L8tIeu/n3UTNy9j2JPNDF9ZFqlt8fuI3b8HlOWJghrA0GwVeW/HNhAoL6e/26V
         UTxboVJzm/BAiBWN6icB1KkPtCAUeOgWIgOfAYRvN5oYWLO5Em8HRfjCJUzu3ympi6Xu
         jmnw==
X-Gm-Message-State: AOAM532S/UmNxSnRyMZbMISslbEc+MVQNRIuG1GaZGTqizwCFsMFlvD4
        F/XkQK0ed/7lqZNghWsBYff9eWcKCRxgew==
X-Google-Smtp-Source: ABdhPJxnrUe8nnM0nR21ySm4qPGGXou4cRc2sKlYSFVtDH2dltvxZHhKmW3ACizel3bikGqty+kUsw==
X-Received: by 2002:a19:cc43:: with SMTP id c64mr3282963lfg.123.1601269392924;
        Sun, 27 Sep 2020 22:03:12 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id n18sm2732733lfe.7.2020.09.27.22.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 22:03:12 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id z19so9564224lfr.4;
        Sun, 27 Sep 2020 22:03:12 -0700 (PDT)
X-Received: by 2002:ac2:5f63:: with SMTP id c3mr3034221lfc.283.1601269392234;
 Sun, 27 Sep 2020 22:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-5-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-5-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 13:03:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v65noEYaHa=d4s1E+1+bcUFjtojvjK_DmEAyJkGU_T9cTw@mail.gmail.com>
Message-ID: <CAGb2v65noEYaHa=d4s1E+1+bcUFjtojvjK_DmEAyJkGU_T9cTw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 04/20] dt-bindings: ASoC: sun4i-i2s: Add
 H6 compatible
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
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 3:29 AM Clément Péron <peron.clem@gmail.com> wrote:
>
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>
> H6 I2S is very similar to H3, except that it supports up to 16 channels
> and thus few registers have fields on different position.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
