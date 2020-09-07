Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93349260258
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgIGRXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:23:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47980 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbgIGRXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:23:13 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kFKr9-00Defl-Bt; Mon, 07 Sep 2020 19:23:03 +0200
Date:   Mon, 7 Sep 2020 19:23:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andre Heider <a.heider@gmail.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
Message-ID: <20200907172303.GA3254313@lunn.ch>
References: <20200907112718.5994-1-pali@kernel.org>
 <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> My dts-foo is a little rusty, but now that you labeled the ports in the
> .dtsi, can this whole "switch0" block reduced to something like:
> 
> &switch0port1 {
> 	label = "lan1";
> };
> 
> &switch0port3 {
> 	label = "wan";
> };

Probably yes.

But that is definitely too much for stable.

    Andrew
