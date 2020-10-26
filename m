Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962192990CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783539AbgJZPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:16:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44938 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783532AbgJZPQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:16:08 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kX4E9-003cyJ-SC; Mon, 26 Oct 2020 16:16:05 +0100
Date:   Mon, 26 Oct 2020 16:16:05 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Vid <vladimir.vid@sartura.hr>
Cc:     devicetree@vger.kernel.org, pali@kernel.org, a.heider@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tmn505@gmail.com, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, jason@lakedaemon.net,
        robh+dt@kernel.org
Subject: Re: [PATCH v4] arm64: dts: marvell: add DT for ESPRESSObin-Ultra
Message-ID: <20201026151605.GM752111@lunn.ch>
References: <20201026124131.84086-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026124131.84086-1-vladimir.vid@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +&mdio {
> +	extphy: ethernet-phy@0 {
> +		reg = <1>;

If reg = 1, then this should be ethernet-phy@1

   Andrew
