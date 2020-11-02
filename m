Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC52A2D78
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKBOzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:55:53 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54194 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgKBOzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:55:53 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kZbFK-0006vx-R7; Mon, 02 Nov 2020 15:55:46 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Aditya Prayoga <aditya@kobol.io>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] arm64: Add basic support for Kobol's Helios64
Date:   Mon,  2 Nov 2020 15:55:45 +0100
Message-Id: <160432890189.1244997.12717967728600775929.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014200030.845759-1-uwe@kleine-koenig.org>
References: <20201014200030.845759-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 22:00:28 +0200, Uwe Kleine-König wrote:
> in v3 Johan still found some inconsistencies in how I sorted (or didn't
> sort) the device tree properties. The rules I applied now are:
> 
> 	at the beginning of a node: compatible, reg and interrupt stuff
> 	status and #* at the end
> 	i2c-scl-rising-time-ns before i2c-scl-falling-time-ns
> 	regulator-name first among regulator-*
> 	regulator-min-microvolt before regulator-max-microvolt
> 	pinctrl-names before pinctrl-0
> 	tx_delay grouped with (and after) rx_delay
> 	vcc12* after vcc5*
> 	otherwise alphabetically
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: vendor-prefixes: Add kobol prefix
      commit: fa67f2817ff2c9bb07472d30e58d904922f1a538
[2/2] arm64: dts: rockchip: Add basic support for Kobol's Helios64
      commit: 09e006cfb43e8ec38afe28278b210dab72e6cac8

Fixed spaces with tabs in the deleted opp area and
inserted a blank between the two cluster blocks.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
