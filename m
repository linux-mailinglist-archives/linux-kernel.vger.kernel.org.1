Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C291A280F23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgJBIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:41:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A0EC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 01:41:22 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kOGcx-0003Lp-Rq; Fri, 02 Oct 2020 10:41:19 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1kOGcx-0004x9-21; Fri, 02 Oct 2020 10:41:19 +0200
Date:   Fri, 2 Oct 2020 10:41:19 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
Message-ID: <20201002084119.buc6z7hpesoahmg2@pengutronix.de>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-9-krzk@kernel.org>
 <0a0afea6-8cbb-3e89-5a4f-89660c942ca3@pengutronix.de>
 <20201001073208.GA5208@kozik-lap>
 <027fd826-6822-9e92-0c6c-2ebed63f4a07@pengutronix.de>
 <20201001103704.GA26287@kozik-lap>
 <7fcea21d-4651-9ba7-5331-86530296a847@pengutronix.de>
 <20201002082012.GA6605@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002082012.GA6605@pi3>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:28:08 up 321 days, 23:46, 363 users,  load average: 0.21, 0.18,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for jumping in.

On 20-10-02 10:20, Krzysztof Kozlowski wrote:
> On Fri, Oct 02, 2020 at 09:41:28AM +0200, Ahmad Fatoum wrote:
> > Hello,
> > 
> > On 10/1/20 12:37 PM, Krzysztof Kozlowski wrote:
> > >> The existing binding doesn't cover these boards then and needs to be
> > >> extended, no? How about following patch?
> > > 
> > > What do you mean it doesn't cover? It was added exactly to handle them:
> > > +              - technexion,imx6q-pico-dwarf   # TechNexion i.MX6Q Pico-Dwarf
> > > +              - technexion,imx6q-pico-hobbit  # TechNexion i.MX6Q Pico-Hobbit
> > > +              - technexion,imx6q-pico-nymph   # TechNexion i.MX6Q Pico-Nymph
> > > +              - technexion,imx6q-pico-pi      # TechNexion i.MX6Q Pico-Pi
> > > 
> > 
> > Still they are unused. So I'd think these boards should be handled like boards
> > that predated bindings: a binding is written that doesn't break existing users.
> 
> OK, let's assume the binding is not correct and DTSes are good.
> 
> > 
> > >> [I guess we need to keep the two-compatible list they were originally
> > >>  in for compatibility even if it's unused among upstream device trees?]
> > > 
> > > You want to change both the binding (thus breaking the ABI) and update
> > > the DTS to reflect new ABI. Then why having a binding at all?
> > 
> > If we leave the old two-compatible enumeration intact, there is no ABI broken.
> 
> Just to clarify, because I don't get here the "no ABI broken" part:
> ABI is the binding, not the DTS. We can change intree DTS as we like,
> replace compatibles, add nodes, remove nodes. There is no stability
> requirement for DTS contents.
> 
> If we leave two-compatible binding intact, it is a broken binding since
> beginning. Removing non-working, fake ABI is not breaking it because it
> could never work.

The problem here is that it wasn't covered by the review and now we have
the mess. I see the DTB and the Bootloader as Firmware. Now imagine if
the bootloader for these boards had some dt-fixup logic which won't
apply anymore or if the bootloader board init won't get called anymore
since the bootloader folks used the compatible found in the DTS. This
can cause a regression if the old Bootloader tries to boot the new
Kernel+DTS.

> > > I would assume that either binding is correct or DTS. You propose that
> > > both are wrong and both need changes... in such case this is clearly
> > > broken.
> > 
> > IMO the DTS is the correct one. If you want to honor the author's intention
> > that each base board has a different compatible, it should be an extra
> > compatible and not replace the existing one that may be already in use.

Question is what was the author's intention? @Fabio do you have any
comments here?

> OK, we can go with DTS approach. I fixed few of such cases as well,
> assuming that DTS was intended and binding was incorrect. In such case
> all boards will be documented under one compatible technexion,imx6q-pico
> and DTS will not be changed.

Or keep the exisiting bindings and adding the new one. Therefore the
yaml needs to handle two cases for each imx6[qdl]:
  compatible = "technexion,imx6dl-pico-dwarf", "technexion,imx6dl-pico", "fsl,imx6dl";
and
  compatible = "technexion,imx6dl-pico", "fsl,imx6dl";

Regards,
  Marco
