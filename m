Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBC82810A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 12:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbgJBKgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 06:36:22 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36136 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBKgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 06:36:20 -0400
Received: by mail-ej1-f68.google.com with SMTP id qp15so1279510ejb.3;
        Fri, 02 Oct 2020 03:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dDy3qtZ35E/i8OLAIFoon1SpiK0GJwYbZILAywJ7tHg=;
        b=Z4Lv3nIFkRvbKWD0AKXLJua5U8/HC9PWxCRgaZbT7OAMOjnajj9YtvwCWQ30A6blGg
         IG+1yLDv7U8iwqzO9IwWLbm/Mc/pPhdZwsndXxM8HLUkMcmdSVTK6y1dU8Y+FZetuvoD
         WTGWDP9m5RtxiiALqNXOXCE9UM+nLhza2DznJY2Gj3JgAeexLwdbq5U5asAFuq6YePj7
         7GX21O9061bd1IvMtN/ddg+94K5/TQx0oPPJmBZXcxnAcO5XFX4hbwJkpxBe4JZ2z+10
         BFoQBnVw+2SurGOy4LliiJs7eeatutovmNROXrAfIr3u/x7qOb9i407mxZ0x1h+F0oVY
         FRkA==
X-Gm-Message-State: AOAM533TfxnPD7WY7tWKA5gGsATymNXeXkLIz/CdTl0F2HoWa4MrizjD
        AyzfzoilzzZxgrBs89isOLs=
X-Google-Smtp-Source: ABdhPJynUB3EUlaUojOp94UErSVj4RC3gp7IQD83k4BxVOVgrM8ah9xebaojRtUnTHKkKotrmKs3cg==
X-Received: by 2002:a17:906:2cc1:: with SMTP id r1mr1488416ejr.305.1601634977959;
        Fri, 02 Oct 2020 03:36:17 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id q13sm874130edr.27.2020.10.02.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 03:36:16 -0700 (PDT)
Date:   Fri, 2 Oct 2020 12:36:14 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, devicetree@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/12] ARM: dts: imx6dl-pico: fix board compatibles
Message-ID: <20201002103614.GA6799@pi3>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-9-krzk@kernel.org>
 <0a0afea6-8cbb-3e89-5a4f-89660c942ca3@pengutronix.de>
 <20201001073208.GA5208@kozik-lap>
 <027fd826-6822-9e92-0c6c-2ebed63f4a07@pengutronix.de>
 <20201001103704.GA26287@kozik-lap>
 <7fcea21d-4651-9ba7-5331-86530296a847@pengutronix.de>
 <20201002082012.GA6605@pi3>
 <20201002084119.buc6z7hpesoahmg2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002084119.buc6z7hpesoahmg2@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 10:41:19AM +0200, Marco Felsch wrote:
> Hi,
> 
> sorry for jumping in.
> 
> On 20-10-02 10:20, Krzysztof Kozlowski wrote:
> > On Fri, Oct 02, 2020 at 09:41:28AM +0200, Ahmad Fatoum wrote:
> > > Hello,
> > > 
> > > On 10/1/20 12:37 PM, Krzysztof Kozlowski wrote:
> > > >> The existing binding doesn't cover these boards then and needs to be
> > > >> extended, no? How about following patch?
> > > > 
> > > > What do you mean it doesn't cover? It was added exactly to handle them:
> > > > +              - technexion,imx6q-pico-dwarf   # TechNexion i.MX6Q Pico-Dwarf
> > > > +              - technexion,imx6q-pico-hobbit  # TechNexion i.MX6Q Pico-Hobbit
> > > > +              - technexion,imx6q-pico-nymph   # TechNexion i.MX6Q Pico-Nymph
> > > > +              - technexion,imx6q-pico-pi      # TechNexion i.MX6Q Pico-Pi
> > > > 
> > > 
> > > Still they are unused. So I'd think these boards should be handled like boards
> > > that predated bindings: a binding is written that doesn't break existing users.
> > 
> > OK, let's assume the binding is not correct and DTSes are good.
> > 
> > > 
> > > >> [I guess we need to keep the two-compatible list they were originally
> > > >>  in for compatibility even if it's unused among upstream device trees?]
> > > > 
> > > > You want to change both the binding (thus breaking the ABI) and update
> > > > the DTS to reflect new ABI. Then why having a binding at all?
> > > 
> > > If we leave the old two-compatible enumeration intact, there is no ABI broken.
> > 
> > Just to clarify, because I don't get here the "no ABI broken" part:
> > ABI is the binding, not the DTS. We can change intree DTS as we like,
> > replace compatibles, add nodes, remove nodes. There is no stability
> > requirement for DTS contents.
> > 
> > If we leave two-compatible binding intact, it is a broken binding since
> > beginning. Removing non-working, fake ABI is not breaking it because it
> > could never work.
> 
> The problem here is that it wasn't covered by the review and now we have
> the mess. I see the DTB and the Bootloader as Firmware. Now imagine if
> the bootloader for these boards had some dt-fixup logic which won't
> apply anymore or if the bootloader board init won't get called anymore
> since the bootloader folks used the compatible found in the DTS. This
> can cause a regression if the old Bootloader tries to boot the new
> Kernel+DTS.

Good points. It's nice to have a binding documented but it is more
likely that bootloader guys were depending on actual contents of DTS.

> 
> > > > I would assume that either binding is correct or DTS. You propose that
> > > > both are wrong and both need changes... in such case this is clearly
> > > > broken.
> > > 
> > > IMO the DTS is the correct one. If you want to honor the author's intention
> > > that each base board has a different compatible, it should be an extra
> > > compatible and not replace the existing one that may be already in use.
> 
> Question is what was the author's intention? @Fabio do you have any
> comments here?
> 
> > OK, we can go with DTS approach. I fixed few of such cases as well,
> > assuming that DTS was intended and binding was incorrect. In such case
> > all boards will be documented under one compatible technexion,imx6q-pico
> > and DTS will not be changed.
> 
> Or keep the exisiting bindings and adding the new one. Therefore the
> yaml needs to handle two cases for each imx6[qdl]:
>   compatible = "technexion,imx6dl-pico-dwarf", "technexion,imx6dl-pico", "fsl,imx6dl";
> and
>   compatible = "technexion,imx6dl-pico", "fsl,imx6dl";

This is the combination I wanted to avoid because it kind of proofs that
both (binding and DTS) were incorrect or insufficient. If both are
incorrect, then there might be no point to keep it stable.

Few other i.MX boards use one compatible for multiple DTS. Usually it is
a module's compatible and boards just do not add their own.

Best regards,
Krzysztof

