Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622002CAAB0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgLASX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:23:26 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60384 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgLASXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:23:25 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kkAIJ-009jTn-Ji; Tue, 01 Dec 2020 19:22:31 +0100
Date:   Tue, 1 Dec 2020 19:22:31 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: dts: mvebu: Add device tree for ATL-x530 Board
Message-ID: <20201201182231.GL2073444@lunn.ch>
References: <20201130223507.23571-1-aryan.srivastava@alliedtelesis.co.nz>
 <20201130230359.GH2073444@lunn.ch>
 <3570cb6d-44e0-3ab5-b464-a013ba1007b1@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3570cb6d-44e0-3ab5-b464-a013ba1007b1@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is what we've done in our kernel fork. But for upstreaming we 
> wanted to start slow and maybe move things into one or more common .dtsi 
> files if/when needed (in particular there are some models in development 
> now that use different i2c mux and hwmon chips).

O.K. It is not particularly disruptive to refactor later, so lets
start with this.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
