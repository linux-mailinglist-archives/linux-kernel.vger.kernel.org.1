Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBAE2A0E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgJ3TFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgJ3TFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:05:43 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA1DC0613CF;
        Fri, 30 Oct 2020 12:05:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u62so8603929iod.8;
        Fri, 30 Oct 2020 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MkMpoKN9mdvQXcoB6tpKOQXDO/dEFfJA9sA6E97EIyQ=;
        b=BSbb+fEKOyH6Ks1ytY2GHgAipM8Lkzch8WZk8wpi6JKMLaKuY75rFl8MbLibtoLUZx
         T3CdErtcjaNSunZvVT8fr6pJd/SCf+nQpRmh4RHAsqPbk2TQ9nQ8DhM+mpLf9A5BQw9l
         fGWAY6gOlKTpxaE4awrtiZqEkI7Xnq0UP+1XWsQTYlWEfXmfn7v+Ptu7kAlRFq9xzhRB
         gfEjv8JxlMNYFMQi8k1a6sQexZ2V36redS71gc/KW/cKW/X2Qp3XSRcIRwsbaSmCzVY+
         42tL/9V1TC3JbQgPOuHQO7fCnoTGa88nV9V+1uEPE3SiaJYkrsCqRm3lXk5vaKmg0bwu
         oHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MkMpoKN9mdvQXcoB6tpKOQXDO/dEFfJA9sA6E97EIyQ=;
        b=sfj64IbeJSw/JgiIC3RUM6kaeV+cPqGp8YjRIVS59QMDUXCGGi5ou0hX1cdYZIBsnY
         +DAi3JKlbkiPkMKPuipu7DVfZVJ5Jw0bmCiFFXwzFYUyk1eQ9AXZFJ/mdPLWk8cf/1NQ
         vOJI8UUT4SXfubNEJQRywyu2bQ9G80jjD5QK7N9hgOArj+yn+50+Gn7IMKkOKfdCDuCv
         cxBRxQzTgFi2SI20ol4dRDx/eWKF3kDpfuohlE0lFZJ3ash23b6lNve1G551T9VLrf9K
         a83TG9qHw4AFNfGeHT6ZgZhpXMc3RUEQsEvov+uMNZFYl6Vx7/1ROfvCai6lW70YKzmo
         NgCg==
X-Gm-Message-State: AOAM530Cz7POEijO+zAxyn08sjDTOiUmtPlSXHKtMyANOnMqegUiMbPd
        fxWe6At84FbMQGXGeAY4i3YBVbpFlxGb7H6kBLA=
X-Google-Smtp-Source: ABdhPJyEfQkAnfPA6e0+TIbGRTnMyNJm3rfqNIl1YH+JrAaGDGxybAIO2Br/u3z9ad0E571PBtZ9I5kYiAbeR5iZb34=
X-Received: by 2002:a6b:7907:: with SMTP id i7mr2883566iop.178.1604084742911;
 Fri, 30 Oct 2020 12:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201030144648.397824-1-peron.clem@gmail.com> <20201030144648.397824-15-peron.clem@gmail.com>
 <20201030181935.GJ4405@sirena.org.uk>
In-Reply-To: <20201030181935.GJ4405@sirena.org.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 30 Oct 2020 20:05:31 +0100
Message-ID: <CAJiuCccAjEHX4BmL9A81EwM_xnHTPVyHu3BOPGKKUQ=1HNaZGw@mail.gmail.com>
Subject: Re: [PATCH v10 14/15] dt-bindings: sound: sun4i-i2s: Document H3 with
 missing RX channel possibility
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, 30 Oct 2020 at 19:19, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 30, 2020 at 03:46:47PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Like A83T the Allwinner H3 doesn't have the DMA reception available for
> > some audio interfaces.
>
> Please if you're going to mix dts updates in with subsystem changes like
> this keep the bits for different subsystems grouped, this makes it much
> easier to handle things.
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Sorry i have based the commit log on this file regarding the previous
commit and it was these:
5c7404bb30bc ("dt-bindings: Change maintainer address")
eb5b12843b06 ("dt-bindings: sound: sun4i-i2s: Document that the RX
channel can be missing")
0a0ca8e94ca3 ("dt-bindings: sound: Convert Allwinner I2S binding to YAML")

But basically for the next dt-bindings change you will prefer somethings li=
ke:
"ASoC: dt-bindings: sun4i-i2s: Document H3 with missing RX channel possibil=
ity"

Regards,
Clement
