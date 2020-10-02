Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83BF280EA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgJBIUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:20:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35838 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbgJBIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:20:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id i1so791924edv.2;
        Fri, 02 Oct 2020 01:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bkh1SP/RxLZt/FHcHaOcXfHwmKZUTF99Sb6EVCBToAI=;
        b=CS85g0ZND0gmO0VZCaW0s9IxXZ/PZJ4mYMYi1U/mC2B81cYYKzk69+oT9Xk2Mlb2kY
         cACf9gK+TiTob/GHClgDBpTU1nwRr0H7KznKlUmSf39n98k30qAttHLtOQXOwym8N50T
         XPlsmiHBRvr39z3veAOGkYg82aY3ThTWBWDZ7qgBkWCfCuhfvzBnd+s2hxjsXxzfqfUU
         CkkJfbd4UrHBGV8OyuSCyCeJruyO0SN0miv3ETvReDq91B1Yc568imt8eZHCQLOXY7qg
         4TZNffrRoCg9D1KnpMW7QVphmf7lIWVw4KLd84OaqEqdmeAAxe7GYEXTgZIDvqEYjszG
         ROQA==
X-Gm-Message-State: AOAM531zYF5YKGoz2xHRRb2czxRLfP9MIOpyTuydzmk/3J22mDBINsid
        QZrBrIA1DAytCZKfpUEye6Q=
X-Google-Smtp-Source: ABdhPJxX55AwyVhonHu2pITZEj1/D9GVJtA481IouPj2agmtzYOF7zuZPrsa4fVc+noKKiqP5rLSgA==
X-Received: by 2002:aa7:d1d5:: with SMTP id g21mr1145493edp.348.1601626815502;
        Fri, 02 Oct 2020 01:20:15 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id y25sm633136edv.15.2020.10.02.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 01:20:14 -0700 (PDT)
Date:   Fri, 2 Oct 2020 10:20:12 +0200
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
Message-ID: <20201002082012.GA6605@pi3>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-9-krzk@kernel.org>
 <0a0afea6-8cbb-3e89-5a4f-89660c942ca3@pengutronix.de>
 <20201001073208.GA5208@kozik-lap>
 <027fd826-6822-9e92-0c6c-2ebed63f4a07@pengutronix.de>
 <20201001103704.GA26287@kozik-lap>
 <7fcea21d-4651-9ba7-5331-86530296a847@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7fcea21d-4651-9ba7-5331-86530296a847@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:41:28AM +0200, Ahmad Fatoum wrote:
> Hello,
> 
> On 10/1/20 12:37 PM, Krzysztof Kozlowski wrote:
> >> The existing binding doesn't cover these boards then and needs to be
> >> extended, no? How about following patch?
> > 
> > What do you mean it doesn't cover? It was added exactly to handle them:
> > +              - technexion,imx6q-pico-dwarf   # TechNexion i.MX6Q Pico-Dwarf
> > +              - technexion,imx6q-pico-hobbit  # TechNexion i.MX6Q Pico-Hobbit
> > +              - technexion,imx6q-pico-nymph   # TechNexion i.MX6Q Pico-Nymph
> > +              - technexion,imx6q-pico-pi      # TechNexion i.MX6Q Pico-Pi
> > 
> 
> Still they are unused. So I'd think these boards should be handled like boards
> that predated bindings: a binding is written that doesn't break existing users.

OK, let's assume the binding is not correct and DTSes are good.

> 
> >> [I guess we need to keep the two-compatible list they were originally
> >>  in for compatibility even if it's unused among upstream device trees?]
> > 
> > You want to change both the binding (thus breaking the ABI) and update
> > the DTS to reflect new ABI. Then why having a binding at all?
> 
> If we leave the old two-compatible enumeration intact, there is no ABI broken.

Just to clarify, because I don't get here the "no ABI broken" part:
ABI is the binding, not the DTS. We can change intree DTS as we like,
replace compatibles, add nodes, remove nodes. There is no stability
requirement for DTS contents.

If we leave two-compatible binding intact, it is a broken binding since
beginning. Removing non-working, fake ABI is not breaking it because it
could never work.

> 
> > I would assume that either binding is correct or DTS. You propose that
> > both are wrong and both need changes... in such case this is clearly
> > broken.
> 
> IMO the DTS is the correct one. If you want to honor the author's intention
> that each base board has a different compatible, it should be an extra
> compatible and not replace the existing one that may be already in use.

OK, we can go with DTS approach. I fixed few of such cases as well,
assuming that DTS was intended and binding was incorrect. In such case
all boards will be documented under one compatible technexion,imx6q-pico
and DTS will not be changed.

Best regards,
Krzysztof
