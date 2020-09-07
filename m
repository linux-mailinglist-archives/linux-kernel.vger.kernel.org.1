Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FDA25F3CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgIGHWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 03:22:05 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34657 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgIGHWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:22:02 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7026C60004;
        Mon,  7 Sep 2020 07:21:57 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Evgeny Novikov <novikov@ispras.ru>, Stefan Agner <stefan@agner.ch>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        ldv-project@linuxtesting.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH] mtd: rawnand: vf610: disable clk on error handling path in probe
Date:   Mon,  7 Sep 2020 09:21:55 +0200
Message-Id: <20200907072155.3436-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200806072634.23528-1-novikov@ispras.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 3d53274a44dcaaff2e7ba00a668435e4a0195e6b
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-06 at 07:26:34 UTC, Evgeny Novikov wrote:
> vf610_nfc_probe() does not invoke clk_disable_unprepare() on one error
> handling path. The patch fixes that.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Fixes: 6f0ce4dfc5a3 ("mtd: rawnand: vf610: Avoid a potential NULL pointer dereference")
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
