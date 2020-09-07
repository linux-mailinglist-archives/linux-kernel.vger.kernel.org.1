Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E004B25F3D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 09:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgIGHWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 03:22:14 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57461 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgIGHWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:22:08 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C8B4EFF804;
        Mon,  7 Sep 2020 07:22:04 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pavel Machek <pavel@ucw.cz>, trivial@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        narmstrong@baylibre.com, nishkadg.linux@gmail.com,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: oxnas: cleanup/simplify code
Date:   Mon,  7 Sep 2020 09:22:03 +0200
Message-Id: <20200907072203.3503-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724083825.GA31437@amd>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 2cc5c9965bcaae81e6b25960a134a380eb029436
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-24 at 08:38:25 UTC, Pavel Machek wrote:
> Simplify oxnas_nand_probe.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
