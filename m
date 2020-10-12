Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2111128BF53
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbgJLSEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:04:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:56462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389885AbgJLSEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:04:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A2D3AC83;
        Mon, 12 Oct 2020 18:04:04 +0000 (UTC)
Date:   Mon, 12 Oct 2020 20:04:02 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Bastian Germann <bage@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: sunxi: Fix Orange Pi Zero bindings
Message-ID: <20201012180402.GT29778@kitsune.suse.cz>
References: <59f7b5c566825838bbb62b778e05c514fe355e74.1602182270.git.msuchanek@suse.de>
 <e657976d8bb1bb627c983321fe9c61de5bc003b7.1602182270.git.msuchanek@suse.de>
 <20201012144753.mdxdacp7ctxxhhl2@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012144753.mdxdacp7ctxxhhl2@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 04:47:53PM +0200, Maxime Ripard wrote:
> On Thu, Oct 08, 2020 at 08:40:06PM +0200, Michal Suchanek wrote:
> > There are two models of Orange Pi zero which are confusingly marketed
> > under the same name. Old model comes without a flash memory and current
> > model does have a flash memory. Add bindings for each model.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> 
> Unfortunately, changing a compatible or a DT filename is not an option

So how do you handle the situation when you find out that there are two
different devices marketed under the same name?

Surely the device tree is labaled by the device name but now you need
two device trees that describe the two devices.

Thanks

Michal
