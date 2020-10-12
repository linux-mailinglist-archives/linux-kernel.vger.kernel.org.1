Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB1B28C1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgJLUD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:03:29 -0400
Received: from vps.xff.cz ([195.181.215.36]:33626 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbgJLUD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1602533005; bh=ctOVVTXA/4Clqll9UdKKkDYlRZ4WS+UhYyf1vMRNVA4=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=cETaPUYqtaL370/kf8lUz/SpbvroD/bT9ZWlyL4ac2ciOtkw6/WBkPYhwqMvgq9Is
         B3xCOgSC54xfkKFNeemVbdS0Or/U8lUoOAKWXi2VxiMvQWSVvwaBA22Lq/KAXGJay8
         G6gbtFurSr3XlOTT7lDcbiKof3IGxMKJBbVkhwiU=
Date:   Mon, 12 Oct 2020 22:03:24 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Bastian Germann <bage@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: sunxi: Fix Orange Pi Zero bindings
Message-ID: <20201012200324.yua77qwqbgfh42z7@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Bastian Germann <bage@linutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <59f7b5c566825838bbb62b778e05c514fe355e74.1602182270.git.msuchanek@suse.de>
 <e657976d8bb1bb627c983321fe9c61de5bc003b7.1602182270.git.msuchanek@suse.de>
 <20201012144753.mdxdacp7ctxxhhl2@gilmour.lan>
 <20201012180402.GT29778@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201012180402.GT29778@kitsune.suse.cz>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,

On Mon, Oct 12, 2020 at 08:04:02PM +0200, Michal Suchánek wrote:
> On Mon, Oct 12, 2020 at 04:47:53PM +0200, Maxime Ripard wrote:
> > On Thu, Oct 08, 2020 at 08:40:06PM +0200, Michal Suchanek wrote:
> > > There are two models of Orange Pi zero which are confusingly marketed
> > > under the same name. Old model comes without a flash memory and current
> > > model does have a flash memory. Add bindings for each model.
> > > 
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > 
> > Unfortunately, changing a compatible or a DT filename is not an option
> 
> So how do you handle the situation when you find out that there are two
> different devices marketed under the same name?
> 
> Surely the device tree is labaled by the device name but now you need
> two device trees that describe the two devices.

You can for example make the new DT name *-flash.dts, instead
of changing the name of existing DT to *-noflash.dts. Or if there's
a version number on the PCB that differs from the older variant,
use that version to differentiate the newer board DT.

regards,
	o.

> Thanks
> 
> Michal
