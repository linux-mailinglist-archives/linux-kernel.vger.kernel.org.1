Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FD3280E32
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgJBHlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBHlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:41:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A9C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 00:41:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kOFh5-0005Rh-6T; Fri, 02 Oct 2020 09:41:31 +0200
Subject: Re: [PATCH v2 08/12] ARM: dts: imx6dl-pico: fix board compatibles
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-9-krzk@kernel.org>
 <0a0afea6-8cbb-3e89-5a4f-89660c942ca3@pengutronix.de>
 <20201001073208.GA5208@kozik-lap>
 <027fd826-6822-9e92-0c6c-2ebed63f4a07@pengutronix.de>
 <20201001103704.GA26287@kozik-lap>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <7fcea21d-4651-9ba7-5331-86530296a847@pengutronix.de>
Date:   Fri, 2 Oct 2020 09:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001103704.GA26287@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10/1/20 12:37 PM, Krzysztof Kozlowski wrote:
>> The existing binding doesn't cover these boards then and needs to be
>> extended, no? How about following patch?
> 
> What do you mean it doesn't cover? It was added exactly to handle them:
> +              - technexion,imx6q-pico-dwarf   # TechNexion i.MX6Q Pico-Dwarf
> +              - technexion,imx6q-pico-hobbit  # TechNexion i.MX6Q Pico-Hobbit
> +              - technexion,imx6q-pico-nymph   # TechNexion i.MX6Q Pico-Nymph
> +              - technexion,imx6q-pico-pi      # TechNexion i.MX6Q Pico-Pi
> 

Still they are unused. So I'd think these boards should be handled like boards
that predated bindings: a binding is written that doesn't break existing users.

>> [I guess we need to keep the two-compatible list they were originally
>>  in for compatibility even if it's unused among upstream device trees?]
> 
> You want to change both the binding (thus breaking the ABI) and update
> the DTS to reflect new ABI. Then why having a binding at all?

If we leave the old two-compatible enumeration intact, there is no ABI broken.

> I would assume that either binding is correct or DTS. You propose that
> both are wrong and both need changes... in such case this is clearly
> broken.

IMO the DTS is the correct one. If you want to honor the author's intention
that each base board has a different compatible, it should be an extra
compatible and not replace the existing one that may be already in use.

Cheers
Ahmad


> 
> Best regards,
> Krzysztof
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
