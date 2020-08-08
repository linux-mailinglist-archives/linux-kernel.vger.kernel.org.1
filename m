Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80BF23F8F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 23:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHHVNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Aug 2020 17:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 17:13:33 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A39C061756;
        Sat,  8 Aug 2020 14:13:33 -0700 (PDT)
Received: from localhost (50-47-102-2.evrt.wa.frontiernet.net [50.47.102.2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1A79C1272873A;
        Sat,  8 Aug 2020 13:56:46 -0700 (PDT)
Date:   Sat, 08 Aug 2020 14:13:30 -0700 (PDT)
Message-Id: <20200808.141330.786343612210808532.davem@davemloft.net>
To:     johan@kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: fix memory leak in device-create error
 path
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200806153753.12247-1-johan@kernel.org>
References: <20200806153753.12247-1-johan@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 08 Aug 2020 13:56:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>
Date: Thu,  6 Aug 2020 17:37:53 +0200

> A recent commit introduced a late error path in phy_device_create()
> which fails to release the device name allocated by dev_set_name().
> 
> Fixes: 13d0ab6750b2 ("net: phy: check return code when requesting PHY driver module")
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied and queued up for -stable, thank you.
