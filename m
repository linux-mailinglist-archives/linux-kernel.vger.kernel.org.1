Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6885E2960EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368158AbgJVO3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:29:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40106 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444386AbgJVO3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:29:09 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kVbaO-002yy5-AP; Thu, 22 Oct 2020 16:29:00 +0200
Date:   Thu, 22 Oct 2020 16:29:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andre Heider <a.heider@gmail.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Reducing number of Espressobin DTS files
Message-ID: <20201022142900.GX139700@lunn.ch>
References: <20201022140007.hppmeyt34lubotbc@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022140007.hppmeyt34lubotbc@pali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For example, Turris MOX board which is also A3720 based has optional
> SDIO module which can be plugged / unplugged, standard variant is sold
> without it and in DTS file is this node always enabled:

I think the Turris has quite a sophisticated bootloader which
manipulates the DT to fit the hardware. I've no idea if eMMC is part
of this...

   Andrew
