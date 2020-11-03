Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927E72A4338
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgKCKhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgKCKhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:37:09 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D0FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 02:37:08 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id i2so18497443ljg.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 02:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GcucvkpK8kMef8JRK6neh/95+aedCMWaWFyvdBMuJI=;
        b=Wh6WFkgoQOQ9/AmfIvmZQkTLiyCit9lXw7J1L5B4rsN7eV0Kg8S23izD3b6C2YQl8f
         4e9CV7RRVNFtXBsy1vVjg1BxjHyYHxLcELHss6N39DRVia9juSjh3foXvWNYiJmja2Gp
         PpEncTfwxF50qMGaUGpvlcRb6M6JB5gOjAYrTFMI/b4ZJw4hcxILn4/foUDQN2diDJXa
         YV3LkJFsLdJJ+Srww0D2FH6CQ8F6Lk0tm62rKAY1y2gcCnmHs3bA2qF2F65n5tQrPa70
         8pkX0SQDLQElFJm8PeAgpSYGx5l2AssKb98QeW/13zat1T8m2b6hpYLI3zCed8XSebe3
         1Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GcucvkpK8kMef8JRK6neh/95+aedCMWaWFyvdBMuJI=;
        b=PopinfFqpsryXgTfolfZ2R+5/jwHaQEmXMUJexu0cEs3YDLTTbHk+RDzZG3W5UjP+t
         u6VJ6IPhJSvlJx6yrmXi98lGCvFB5qw9eb00LReOHe4SlWRQZl0o37AQ7nPWk4zu8Fu7
         r2GBWQUDfKsguX0LMGHNR1sIcXtXTRuAX5tSKcAs6ANqgAoyM97WWIHUoW9rrk8m3JlG
         5npwgLhHIJ3UpGhLlf8pDDSrl+DYKHuCBmYt8CxvZKa5uDC1yz6dIjiwUNMnQWbGFSai
         fhhppPd8u25lDbJfSOxxXvrlbcbW3KfTzj8BLpVbS7HvRRuTul4Tc3WhqDi3qD+LWMms
         dQsw==
X-Gm-Message-State: AOAM533ajQmg/i3Cu7xpR/zRH3aeWUaorEpBPqHM2xCGWjf9kHVRe/hb
        lojiU53gTDahwpuvpb37X+bxT1jvz54pattLUa6Pfw==
X-Google-Smtp-Source: ABdhPJyLCXn6n7JwwyyVsJICHg0f8BJ4slro0/8J9XFTybUf/uwbNFZooKlvdhdc49pQBXt8XGZ3L8/0zj1tZuHmsEY=
X-Received: by 2002:a05:651c:291:: with SMTP id b17mr7952875ljo.34.1604399826815;
 Tue, 03 Nov 2020 02:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20201103103051.34553-1-ajye_huang@compal.corp-partner.google.com> <20201103103051.34553-2-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20201103103051.34553-2-ajye_huang@compal.corp-partner.google.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Tue, 3 Nov 2020 18:36:55 +0800
Message-ID: <CALprXBboAS7Dkn-K5fpKB+XNWShX-1xbgrL4Gzi04uyCwY6ABA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ASoC: google: dt-bindings: modify machine bindings
 for two MICs case
To:     Ajye Huang <ajye.huang@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Cheng-yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Could you please kindly review this patch ?

 I had got your "reviewed-by" on v1 patch, the v1 depends on this patch series
(https://patchwork.kernel.org/patch/11773221) at that time.

Now, that patch what I depended (11773221) had made modification and
it was Applied to
   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
commit e158d2d83cab ("ASoC: google: dt-bindings: Add sc7180-trogdor
machine bindings")

I noted what I did on cover letter
v2:
- Documentation: Modify the dimc-gpios property description and examples.

That is why I bother you again to review it. Please let me know if
this looks good to you.
Thanks!

On Tue, Nov 3, 2020 at 6:31 PM Ajye Huang <ajye.huang@gmail.com> wrote:
>
> Add a property "dmic-gpios" for switching between two MICs.
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  .../bindings/sound/google,sc7180-trogdor.yaml | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> index efc34689d6b5..9e0505467e57 100644
> --- a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> +++ b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> @@ -34,6 +34,9 @@ properties:
>    "#size-cells":
>      const: 0
>
> +  dmic-gpios:
> +    description: GPIO for switching between DMICs
> +
>  patternProperties:
>    "^dai-link(@[0-9])?$":
>      description:
> @@ -81,6 +84,7 @@ additionalProperties: false
>  examples:
>
>    - |
> +    //Example 1
>      sound {
>          compatible = "google,sc7180-trogdor";
>          model = "sc7180-rt5682-max98357a-1mic";
> @@ -128,3 +132,57 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    //Example 2 (2mic case)
> +    sound {
> +        compatible = "google,sc7180-trogdor";
> +        model = "sc7180-rt5682-max98357a-2mic";
> +
> +        audio-routing =
> +                    "Headphone Jack", "HPOL",
> +                    "Headphone Jack", "HPOR";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dmic-gpios = <&tlmm 86 0>;
> +
> +        dai-link@0 {
> +            link-name = "MultiMedia0";
> +            reg = <0>;
> +            cpu {
> +                sound-dai = <&lpass_cpu 0>;
> +            };
> +
> +            codec {
> +                sound-dai = <&alc5682 0>;
> +            };
> +        };
> +
> +        dai-link@1 {
> +            link-name = "MultiMedia1";
> +            reg = <1>;
> +            cpu {
> +                sound-dai = <&lpass_cpu 1>;
> +            };
> +
> +            codec {
> +                sound-dai = <&max98357a>;
> +            };
> +        };
> +
> +        dai-link@2 {
> +            link-name = "MultiMedia2";
> +            reg = <2>;
> +            cpu {
> +                sound-dai = <&lpass_hdmi 0>;
> +            };
> +
> +            codec {
> +                sound-dai = <&msm_dp>;
> +            };
> +        };
> +    };
> +
> +...
> --
> 2.25.1
>
