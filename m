Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A04D2A8DB8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgKFDsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:48:50 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA59C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 19:48:49 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l2so5463054lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 19:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppVeo0b190qF2Ptj5wRZlt8bVEFE8U+FRbqIrPfzfO0=;
        b=Y0OvGdC7Ay1jBPx9c95rwCWL5YO1NKIyLtH3RBjJqksuu5AmwVeqJA3yAVePeFJpD+
         FNnIveyBAgJypsaK51ANwnqRY7vR4BDOlrKMA1BLxssBAe6rezmriag1QbajUoT/ZYrN
         ia/BNKgIUF2Dh8y1MMAUsf9DpJByCV5DJS2VJkfHelErXdtSUlMof+LOnHR2w5t7Lgp8
         qXDVuCE4fh3v7LRCzvKaV2W42Pcpn+WomjbzeSw0L8WQ5PBPJfLgYXwY7wEsOObmFR7E
         MQuyqNeRdqW4WggiOLj3w/oToWlhsUSpLUpGXRyZ/xcdo2KG7q7xYzh1w+ag4jRU6Hmu
         2PVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppVeo0b190qF2Ptj5wRZlt8bVEFE8U+FRbqIrPfzfO0=;
        b=hJPN++VWaMz4N/aJbk5mZFil1JpEbk7Sh4BymXsOviouQMqIJYVXSMwkuCE8QE76KK
         RfNtX+c3U3RwozwteIV+PJwUGb184ttScGWMRfXO0N6W8Yc5whqGFruN8UNmn0vRP/0c
         FPZpKasY72OrkcHZVdqRM1R0Se2WE8utCH7k65vp7NS8iQleIBILhgq5/7+ktudWAXS5
         DXQbGqBtYvzVEL+9ja/UDIkifISpoQ8nQjtQgIgQh0UGkFupGcNbzkx+haL9wRYAFToL
         vdYGpZVMTwiqhi26ZMDOBdO9gQTtP5FzEoSmVUUXtfIJbJJaFywUu7l03+KhMjcerMHI
         LV+g==
X-Gm-Message-State: AOAM532vMWHQWzr0F0cdu+7VLvQ6f6i/Lr5rnECRtRAyOyFCMLHg2zWR
        1TKoNU57ghmG37W809Ics4L3yF1RCdWhTpHIwx0fTw==
X-Google-Smtp-Source: ABdhPJxbdRyNk08Ob4JHGuI4T01MyHskgm3c1DqN+BTCMCllgLD793w6HxN7Xw1dUaB0tfhybEYmpnLfDVXd/P4HXms=
X-Received: by 2002:a19:4204:: with SMTP id p4mr39766lfa.536.1604634528395;
 Thu, 05 Nov 2020 19:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20201103103051.34553-1-ajye_huang@compal.corp-partner.google.com>
 <20201103103051.34553-2-ajye_huang@compal.corp-partner.google.com> <20201105184350.GA1611477@bogus>
In-Reply-To: <20201105184350.GA1611477@bogus>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Fri, 6 Nov 2020 11:48:37 +0800
Message-ID: <CALprXBYUddwE-+Bnt2qh4ETwZJ2LnwmB1mQNT88vcqxB8kPW4Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ASoC: google: dt-bindings: modify machine bindings
 for two MICs case
To:     Rob Herring <robh@kernel.org>
Cc:     Ajye Huang <ajye.huang@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
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

HI, Rob,

Thank you for the comments.


On Fri, Nov 6, 2020 at 2:43 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 03, 2020 at 06:30:50PM +0800, Ajye Huang wrote:
> > Add a property "dmic-gpios" for switching between two MICs.
> >
> > Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> > ---
> >  .../bindings/sound/google,sc7180-trogdor.yaml | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> > index efc34689d6b5..9e0505467e57 100644
> > --- a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> > +++ b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> > @@ -34,6 +34,9 @@ properties:
> >    "#size-cells":
> >      const: 0
> >
> > +  dmic-gpios:
> > +    description: GPIO for switching between DMICs
>
> Need to define how many (maxItems: 1).

Yes, I will add in the v6 version.

>
> > +
> >  patternProperties:
> >    "^dai-link(@[0-9])?$":
> >      description:
> > @@ -81,6 +84,7 @@ additionalProperties: false
> >  examples:
> >
> >    - |
> > +    //Example 1
> >      sound {
> >          compatible = "google,sc7180-trogdor";
> >          model = "sc7180-rt5682-max98357a-1mic";
> > @@ -128,3 +132,57 @@ examples:
> >              };
> >          };
> >      };
> > +
> > +  - |
> > +    //Example 2 (2mic case)
> > +    sound {
> > +        compatible = "google,sc7180-trogdor";
> > +        model = "sc7180-rt5682-max98357a-2mic";
> > +
> > +        audio-routing =
> > +                    "Headphone Jack", "HPOL",
> > +                    "Headphone Jack", "HPOR";
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        dmic-gpios = <&tlmm 86 0>;
>
> Do we really need another example for this? Can't you just add it to the
> existing example?

I think just keep One example. I will remove the example2 and put
dmic-gpios = <&tlmm 86 0>; in the first example and
modify the model from "sc7180-rt5682-max98357a-1mic" to
"sc7180-rt5682-max98357a-2mic". It looks clear.

>
> > +
> > +        dai-link@0 {
> > +            link-name = "MultiMedia0";
> > +            reg = <0>;
> > +            cpu {
> > +                sound-dai = <&lpass_cpu 0>;
> > +            };
> > +
> > +            codec {
> > +                sound-dai = <&alc5682 0>;
> > +            };
> > +        };
> > +
> > +        dai-link@1 {
> > +            link-name = "MultiMedia1";
> > +            reg = <1>;
> > +            cpu {
> > +                sound-dai = <&lpass_cpu 1>;
> > +            };
> > +
> > +            codec {
> > +                sound-dai = <&max98357a>;
> > +            };
> > +        };
> > +
> > +        dai-link@2 {
> > +            link-name = "MultiMedia2";
> > +            reg = <2>;
> > +            cpu {
> > +                sound-dai = <&lpass_hdmi 0>;
> > +            };
> > +
> > +            codec {
> > +                sound-dai = <&msm_dp>;
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > --
> > 2.25.1
> >
