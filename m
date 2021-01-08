Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1402EF74B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbhAHS0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:26:03 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57638 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbhAHS0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:26:03 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kxwRp-00GwrN-3T; Fri, 08 Jan 2021 19:25:17 +0100
Date:   Fri, 8 Jan 2021 19:25:17 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     DENG Qingfang <dqfext@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rosen Penev <rosenp@gmail.com>
Subject: Re: [PATCH] staging: mt7621-dts: remove obsolete switch node
Message-ID: <X/ijjWpq4eLQEDot@lunn.ch>
References: <20210108025155.31556-1-dqfext@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108025155.31556-1-dqfext@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 10:51:55AM +0800, DENG Qingfang wrote:
> This was for OpenWrt's swconfig driver, which never made it upstream,
> and was also superseded by MT7530 DSA driver.

What about
Documentation/devicetree/bindings/net/mediatek,mt7620-gsw.txt ?
Should that also be removed?

       Andrew
