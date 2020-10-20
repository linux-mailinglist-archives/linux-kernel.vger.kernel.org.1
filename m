Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F422293D47
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407437AbgJTNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406741AbgJTNYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:24:53 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A137920BED;
        Tue, 20 Oct 2020 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603200292;
        bh=ZaKgderQG4KKZH6fH+HyuZTcQv1aic4HE94Cqcbe1RY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oMLMoBv80hIxboOAiLeXVWq+xzfjYExK0+aAYH/Glp3Pe78NPfGerVw9m4mjjYFrO
         M90N8EAaloVWWbe8yl6W/TqmoF1pgWGDlbLJgLWBW5P9lALjjJCnv/wjH64R8OG/aR
         A5AfKmrc+BaDOCNR8+8jSrmF0NgQBfbGZwiG/Z0o=
Received: by mail-ot1-f46.google.com with SMTP id e20so1654908otj.11;
        Tue, 20 Oct 2020 06:24:52 -0700 (PDT)
X-Gm-Message-State: AOAM533NUApPLFWs9U1he4YaaCutDk0dqBtomQ3vCF7Lh9GQuJy8W3gp
        tsYmn4ER/wa8RN+g4w/khRI3gPBwO9nhRW1aIw==
X-Google-Smtp-Source: ABdhPJydcSIKB2h68GX/LgNGhYJ62BnuNy3smEVojrJZ6JNICv7hKDMocPUZoKv8WcFtfUrf9fI4R28od7lNCSbidaw=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr1611217oti.107.1603200291871;
 Tue, 20 Oct 2020 06:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
 <1602859382-19505-12-git-send-email-spujar@nvidia.com> <20201019221612.GA3690258@bogus>
 <f6d098fa-cbc2-7563-a68c-5d00d71d128f@nvidia.com>
In-Reply-To: <f6d098fa-cbc2-7563-a68c-5d00d71d128f@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Oct 2020 08:24:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5mLqHBOhsjA6KnjFbyKymoyr9ubVG7ehWvE7GdTACrg@mail.gmail.com>
Message-ID: <CAL_Jsq+5mLqHBOhsjA6KnjFbyKymoyr9ubVG7ehWvE7GdTACrg@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] ASoC: dt-bindings: tegra: Add json-schema for
 Tegra audio graph card
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com,
        nwartikar@nvidia.com, Stephen Warren <swarren@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 1:16 AM Sameer Pujar <spujar@nvidia.com> wrote:
>
>
> >> Add YAML schema for Tegra audio graph sound card DT bindings. It uses the
> >> same DT bindings provided by generic audio graph driver. Along with this
> >> few standard clock DT bindings are added which are specifically required
> >> for Tegra audio.
> >>
> >> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> >> ---
> >>   .../sound/nvidia,tegra-audio-graph-card.yaml       | 158 +++++++++++++++++++++
> >>   1 file changed, 158 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
> >> new file mode 100644
> >> index 0000000..284d185
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
> >> @@ -0,0 +1,158 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-graph-card.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Audio Graph based Tegra sound card driver
> >> +
> >> +description: |
> >> +  This is based on generic audio graph card driver along with additional
> >> +  customizations for Tegra platforms. It uses the same bindings with
> >> +  additional standard clock DT bindings required for Tegra.
> >> +
> >> +  See{LINUX}/Documentation/devicetree/bindings/sound/audio-graph-card.yaml
> > You should be able to just $ref this at the top level.
>
> I am seeing one problem while using $ref like below.
> allOf:
>    - $ref: /schemas/sound/audio-graph-card.yaml
>
> I see below while running doc validator.
> "Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.example.dt.yaml:
> tegra_sound: compatible:0: 'audio-graph-card' was expected"
>
> Is there a way to avoid this?

Adjust the schemas so the constraints match. You can't say it must be
one thing in one place and something else here. Your choices are:

- Drop compatible from audio-graph-card.yaml. You can define a 2nd
schema that references audio-graph-card.yaml and defines the
compatible.
- Use 'contains' in audio-graph-card.yaml and then make
'audio-graph-card' a fallback here.

The best option depends on what existing users have.

> >> +maintainers:
> >> +  - Jon Hunter <jonathanh@nvidia.com>
> >> +  - Sameer Pujar <spujar@nvidia.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - enum:
> >> +          - nvidia,tegra210-audio-graph-card
> >> +          - nvidia,tegra186-audio-graph-card
> >> +
>
> >> +  dais:
> >> +    $ref: /schemas/sound/audio-graph-card.yaml#/properties/dais
> >> +
> >> +  label:
> >> +    $ref: /schemas/sound/simple-card.yaml#/properties/label
> >> +
> >> +  pa-gpios:
> >> +    $ref: /schemas/sound/audio-graph-card.yaml#/properties/pa-gpios
> >> +
> >> +  widgets:
> >> +    $ref: /schemas/sound/simple-card.yaml#/definitions/widgets
> >> +
> >> +  routing:
> >> +    $ref: /schemas/sound/simple-card.yaml#/definitions/routing
> >> +
> >> +  mclk-fs:
> >> +    $ref: /schemas/sound/simple-card.yaml#/definitions/mclk-fs
> >> +
> >> +  prefix:
> >> +    $ref: /schemas/sound/simple-card.yaml#/definitions/prefix
> > And drop all of these.
>
> Could not re-use because of above compatible problem. Also require some
> additional properties for Tegra.
>
> >> +
> >> +  clocks:
> >> +   minItems: 2
> >> +
> >> +  clock-names:
> >> +   minItems: 2
> > Don't need this.
>
> This is required for Tegra audio graph card to update clock rates at
> runtime.

I mean you can drop 'minItems: 2' as it is redundant. The 'items' list
size implies the size.

> >> +   items:
> >> +     - const: pll_a
> >> +     - const: plla_out0
> >> +
> >> +  assigned-clocks:
> >> +    minItems: 1
> >> +    maxItems: 3
> >> +
> >> +  assigned-clock-parents:
> >> +    minItems: 1
> >> +    maxItems: 3
> >> +
> >> +  assigned-clock-rates:
> >> +    minItems: 1
> >> +    maxItems: 3
> >> +
>
> It is required for initialisation of above clocks with specific rates.
>
> >> +  ports:
> >> +    $ref: /schemas/sound/audio-graph-card.yaml#/properties/ports
> >> +
> >> +patternProperties:
> >> +  "^port(@[0-9a-f]+)?$":
> >> +    $ref: /schemas/sound/audio-graph-card.yaml#/definitions/port
> > And these can be dropped. Unless what each port is is Tegra specific.
>
> May be I can drop this if I could just directly include
> audio-graph-card.yaml and extend required properties for Tegra.

There are numerous examples of doing that.

Rob
