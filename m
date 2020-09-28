Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8927A7EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1GwU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 02:52:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36905 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgI1GwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:52:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id z19so9818788lfr.4;
        Sun, 27 Sep 2020 23:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XphzwiB62aADzo7H5xKbNzFDZU+uUK4UzX7X79ljoMQ=;
        b=ub1PN8/m+Ey565ibWNqP+DTA8/HX+lxnFpZZlqeUl8si+lcCXpKFYf6TFzMq3gX2A5
         WHRwvKoQjuSfSFrZRIVTG4lbkhkt/Mp+u00RvXVMmR/LQRE8O0YxOmOnwx84c2b4oUR3
         Y1F/05Rha2aJQytzXqQWSwby03RAkuli9eg8g7L66ZzwHt4wKuWTIeDOa48JtpsxnQ79
         ubKiWPe63pnQhl9je907HfbYz/k7zqpvggC7JwKXty7KRUjRSRf0tcwXY7dgj87oCY/s
         bCHZSsVYPD/A1msQ6q6ONepuA16hr1dwi2Om7kB9IGkST4Iym314Yt0rYAco90WEBiw8
         Vcbw==
X-Gm-Message-State: AOAM5317Sfvdin4xTwkE6sQF2wBJUX5WASkJlf/glkVs6woMsY003I6H
        P+fjP3EJ2lQPrX8eOi2AMmznVlrmmW1Z0g==
X-Google-Smtp-Source: ABdhPJyoAWKQ0MyQwqDvwIE/iHVfG5O5uQYJCU61bwI1bAN7orRzaGsBe1/JY2ZD7lLSEMk3bqxS7Q==
X-Received: by 2002:a05:6512:3191:: with SMTP id i17mr3163323lfe.409.1601275938032;
        Sun, 27 Sep 2020 23:52:18 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id r77sm2711611lff.115.2020.09.27.23.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 23:52:17 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id a15so120447ljk.2;
        Sun, 27 Sep 2020 23:52:17 -0700 (PDT)
X-Received: by 2002:a2e:760e:: with SMTP id r14mr4132627ljc.331.1601275937498;
 Sun, 27 Sep 2020 23:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-6-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-6-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 14:52:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v66vJpCUc3xAHt7sHXKguc7ma+0kSjX=5Wp5VTdHeYQa5Q@mail.gmail.com>
Message-ID: <CAGb2v66vJpCUc3xAHt7sHXKguc7ma+0kSjX=5Wp5VTdHeYQa5Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 05/20] ASoC: sun4i-i2s: Set sign extend sample
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
> On the newer SoCs such as the H3 and A64 this is set by default
> to transfer a 0 after each sample in each slot. However the A10
> and A20 SoCs that this driver was developed on had a default
> setting where it padded the audio gain with zeros.
>
> This isn't a problem while we have only support for 16bit audio
> but with larger sample resolution rates in the pipeline then SEXT
> bits should be cleared so that they also pad at the LSB. Without
> this the audio gets distorted.
>
> Set sign extend sample for all the sunxi generations even if they
> are not affected. This will keep consistency and avoid relying on
> default.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
