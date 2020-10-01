Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE07127FD84
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbgJAKhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:37:10 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42590 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbgJAKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:37:10 -0400
Received: by mail-ej1-f67.google.com with SMTP id q13so7268419ejo.9;
        Thu, 01 Oct 2020 03:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XeATPLtiujNPtbWy8eOfYkG34Rmci3Rho1NFx2mqnxY=;
        b=HkMiNzaoqHVA27xblu9Ooe6Z+pjjPl1sq0Dt56f1ohLkDvR+kZ+hpyfv94LLcqVoW3
         jy/vRnmaYyMYbhpPPS+C94+Z8u6NffZFNma1tY4NPFuJw8uGtosrNc3w7csl25rRUxsL
         6hr5fnlKe/RXn6xZNXHX3PX14kEFH1QU+1BKE+p8MHdKiiHaJ0HkQ97vBwtBY1ZainYb
         VNOdUy6avQpacdHOBWGp4rbWgq9NFtJFSRYbV7pl6RvGQa9VSgU9mYA3rrk08hzEnc0A
         zspRYBIGHQ+ylLGzo1CoAuSv6q7wXxQhX/O8VIgrSQcNfM+EGCHUFTTEqaIy0kzKghEH
         zmtw==
X-Gm-Message-State: AOAM532aI54vSv47EyqBhAkG/bOIPZ1u7HJ7ktE7w44QM9IWZYO1ZvT4
        oSW+WSCWvtZtRULwfaPiNnw=
X-Google-Smtp-Source: ABdhPJxL9pxjDS00Vg2RUHbokVDD46x2SLH6Tdd8HfjwLtwogfEvXijc454ys1aaalQGGOItX9p+hA==
X-Received: by 2002:a17:906:b790:: with SMTP id dt16mr7064587ejb.33.1601548628154;
        Thu, 01 Oct 2020 03:37:08 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id q1sm3985967ejy.37.2020.10.01.03.37.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 03:37:07 -0700 (PDT)
Date:   Thu, 1 Oct 2020 12:37:04 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/12] ARM: dts: imx6dl-pico: fix board compatibles
Message-ID: <20201001103704.GA26287@kozik-lap>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-9-krzk@kernel.org>
 <0a0afea6-8cbb-3e89-5a4f-89660c942ca3@pengutronix.de>
 <20201001073208.GA5208@kozik-lap>
 <027fd826-6822-9e92-0c6c-2ebed63f4a07@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <027fd826-6822-9e92-0c6c-2ebed63f4a07@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 12:19:08PM +0200, Ahmad Fatoum wrote:
> Hi,
> 
> On 10/1/20 9:32 AM, Krzysztof Kozlowski wrote:
> > On Thu, Oct 01, 2020 at 09:22:03AM +0200, Ahmad Fatoum wrote:
> >>> diff --git a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts b/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
> >>> index d7403c5c4337..08fedcbcc91b 100644
> >>> --- a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
> >>> +++ b/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
> >>> @@ -13,5 +13,5 @@
> >>>  
> >>>  / {
> >>>  	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Hobbit baseboard";
> >>> -	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
> >>> +	compatible = "technexion,imx6dl-pico-hobbit", "fsl,imx6dl";
> >>>  };
> > 
> > The bindings, added in commit 53b61224ca40 ("dt-bindings: arm: fsl: Add
> > TechNexion boards"), describe that these are the only valid compatibles.
> > "technexion,imx6dl-pico" is not valid and would require changing the
> > bindings, thus breaking compatibility which you want to avoid.> 
> > The bindings, not what is present in DTS, is considered ABI.
> 
> The existing binding doesn't cover these boards then and needs to be
> extended, no? How about following patch?

What do you mean it doesn't cover? It was added exactly to handle them:
+              - technexion,imx6q-pico-dwarf   # TechNexion i.MX6Q Pico-Dwarf
+              - technexion,imx6q-pico-hobbit  # TechNexion i.MX6Q Pico-Hobbit
+              - technexion,imx6q-pico-nymph   # TechNexion i.MX6Q Pico-Nymph
+              - technexion,imx6q-pico-pi      # TechNexion i.MX6Q Pico-Pi

> 
> [I guess we need to keep the two-compatible list they were originally
>  in for compatibility even if it's unused among upstream device trees?]

You want to change both the binding (thus breaking the ABI) and update
the DTS to reflect new ABI. Then why having a binding at all?

I would assume that either binding is correct or DTS. You propose that
both are wrong and both need changes... in such case this is clearly
broken.

Best regards,
Krzysztof
