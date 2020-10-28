Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE8729E052
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgJ1WFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbgJ1WCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:02:23 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C166624802
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603909476;
        bh=M1whgnZOJadzH3ZqD/41ILHdWSiXvpcDWZEAb4SE7+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZsVc/sMcFdoTr2EbAio4ExRQYe6ZkSHBFnZCxMP68LWN9WYrH+2VyT2tSKR2Ojf/A
         9oe34hjYGRJXOQk6CJtOwIaR3LHZJJex29m5yEmePDcpnV/3bP1aoTGP84XxdCboTc
         0cYjviCsnee5IKV6nD3qG7D6Emrx9hwprSG2tkXE=
Received: by mail-oi1-f171.google.com with SMTP id j7so508103oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 11:24:36 -0700 (PDT)
X-Gm-Message-State: AOAM533Cc5RQOiP1JJo6K93+CCQO6JRAbcz40WgyUJt0a9DKw8+CZrLq
        SKA2vyJz04G6W2xkXfWCkDo7H+5Ob4OakGeCNQ==
X-Google-Smtp-Source: ABdhPJyXpqjoGHD1yMAHx6mddJw4rJxGdzINyVXxqgHhTZozTbPMuEIK/CXamZ0Se8Ri+6CmN549wosnDEPFnTMsC9k=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr221994oib.106.1603909475904;
 Wed, 28 Oct 2020 11:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
 <20201026170947.10567-2-srinivas.kandagatla@linaro.org> <20201028150135.GA4009047@bogus>
 <31981724-b260-e94d-ebc6-ccea21763531@linaro.org>
In-Reply-To: <31981724-b260-e94d-ebc6-ccea21763531@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Oct 2020 13:24:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLUYCrqbgxJPc_CTH9MtQo=h4JBqcmpgwJgWncyLN2gtQ@mail.gmail.com>
Message-ID: <CAL_JsqLUYCrqbgxJPc_CTH9MtQo=h4JBqcmpgwJgWncyLN2gtQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ASoC: qcom: dt-bindings: Add SM8250 sound card bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Patrick Lai <plai@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:19 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 28/10/2020 15:01, Rob Herring wrote:
> > On Mon, Oct 26, 2020 at 05:09:46PM +0000, Srinivas Kandagatla wrote:
> >> This patch adds bindings required for SM8250 based soundcards
> >> for example Qualcomm Robotics RB5 Development Kit which makes
> >> use of ADSP and Internal LPASS codec.
> >
> > You didn't send to DT list...
>
> Ah.. my bad.. I did not realize that I missed it!
>
> >
> >>
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>   .../bindings/sound/qcom,sm8250.yaml           | 161 ++++++++++++++++=
++
> >>   1 file changed, 161 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,sm82=
50.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml =
b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >> new file mode 100644
> >> index 000000000000..b8f97fe6e92c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >> @@ -0,0 +1,161 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Qualcomm Technologies Inc. SM8250 ASoC sound card driver
> >> +
> >> +maintainers:
> >> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> +
> >> +description:
> >> +  This bindings describes SC8250 SoC based sound cards
> >> +  which uses LPASS internal codec for audio.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    oneOf:
> >> +      - const: qcom,qrb5165-rb5
> >> +      - items:
> >> +        - const: qcom,sm8250
> >
> > This collides with the top level SoC compatible resulting in:
> >
>
> I did run dt_binding_check before sending out this patch, I might have
> missed it somehow because the make dt_binding_check did not
> end/termnitate in any errors, however if I had scrolled 15-20 Page ups
> it does have this error log!

make -sk

:)

> > /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/=
sound/qcom,sm8250.example.dt.yaml: sound: $nodename:0: '/' was expected
> >       From schema: /builds/robherring/linux-dt-bindings/Documentation/d=
evicetree/bindings/arm/qcom.yaml
> > /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/=
sound/qcom,sm8250.example.dt.yaml: sound: compatible: ['qcom,qrb5165-rb5'] =
is not valid under any of the given schemas (Possible causes of the failure=
):
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible: ['qcom,qrb5165-=
rb5'] is too short
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,apq8016-sbc']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,apq8064-cm-qs600', 'qcom,apq8064-ifc6410']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,apq8074-dragonboard']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,apq8060-dragonboard', 'qcom,msm8660-surf']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,apq8084-mtp', 'qcom,apq8084-sbc']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,msm8960-cdp']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['fairphone,fp2', 'lge,hammerhead', 'sony,xperia-amami'=
, 'sony,xperia-castor', 'sony,xperia-honami']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,msm8916=
-mtp/1' was expected
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['longcheer,l8150', 'samsung,a3u-eur', 'samsung,a5u-eur=
']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,msm8996=
-mtp' was expected
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,ipq4019-ap-dk04.1-c3', 'qcom,ipq4019-ap-dk07.1-c=
1', 'qcom,ipq4019-ap-dk07.1-c2', 'qcom,ipq4019-dk04.1-c1']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,ipq8064-ap148']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,ipq8074-hk01', 'qcom,ipq8074-hk10-c1', 'qcom,ipq=
8074-hk10-c2']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,sc7180-idp']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['xiaomi,lavender']
> >       /builds/robherring/linux-dt-bindings/Documentation/devicetree/bin=
dings/sound/qcom,sm8250.example.dt.yaml: sound: compatible:0: 'qcom,qrb5165=
-rb5' is not one of ['qcom,ipq6018-cp01-c1']
> >
> >       From schema: /builds/robherring/linux-dt-bindings/Documentation/d=
evicetree/bindings/arm/qcom.yaml
> >
> Documentation/devicetree/bindings/arm/qcom.yaml does have
> qcom,qrb5165-rb5 entry under [qcom,sm8250]
>
> Can you help me understand why is this not a valid compatible?

Those compatibles are used at the top level for the SoC. You can't use
the same compatible to mean 2 different things.

Rob
