Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED342FC153
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbhASUl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:41:28 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:3935 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388994AbhASUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:40:22 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 12767240002;
        Tue, 19 Jan 2021 20:39:38 +0000 (UTC)
Date:   Tue, 19 Jan 2021 21:39:38 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] reset: mchp: sparx5: add switch reset driver
Message-ID: <20210119203938.GQ3666@piout.net>
References: <20210114162432.3039657-1-steen.hegelund@microchip.com>
 <20210114162432.3039657-3-steen.hegelund@microchip.com>
 <20210119203710.GP3666@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119203710.GP3666@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2021 21:37:16+0100, Alexandre Belloni wrote:
> On 14/01/2021 17:24:31+0100, Steen Hegelund wrote:
> > +static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
> > +			       unsigned long id)
> > +{
> > +	struct mchp_reset_context *ctx =
> > +		container_of(rcdev, struct mchp_reset_context, rcdev);
> > +	u32 val;
> > +
> 
> I would ensure the reset only happens once here else I'm not sure how
> you could do it from the individual drivers.
> 

Ok, the core is taking care of that, nice.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
