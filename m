Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3720251C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 18:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgFTQO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 12:14:29 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50262 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgFTQO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:14:29 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jmg8Q-001Peb-2X; Sat, 20 Jun 2020 18:14:26 +0200
Date:   Sat, 20 Jun 2020 18:14:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: amlogic: Add the Ethernet
 "timing-adjustment" clock
Message-ID: <20200620161426.GR304147@lunn.ch>
References: <20200620160136.21584-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620160136.21584-1-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 06:01:36PM +0200, Martin Blumenstingl wrote:
> Add the "timing-adjusment" clock now that we now that this is connected
> to the PRG_ETHERNET registers. It is used internally to generate the
> RGMII RX delay no the MAC side (if needed).

s/no/on

Sort of typ0 i make :-)

     Andrew
