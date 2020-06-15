Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A560D1F9263
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgFOI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 04:59:50 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60859 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgFOI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:59:50 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 1B37720008;
        Mon, 15 Jun 2020 08:59:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        peter.ujfalusi@ti.com, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/2] mtd: rawnand: qcom: set BAM mode only if not set already
Date:   Mon, 15 Jun 2020 10:59:46 +0200
Message-Id: <20200615085946.22390-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1591948696-16015-3-git-send-email-sivaprak@codeaurora.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 7c9765940d6f1835a39bba2e77d80d26d64f5dd2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-12 at 07:58:16 UTC, Sivaprakash Murugesan wrote:
> BAM is DMA controller on QCOM ipq platforms, BAM mode on NAND driver
> is set by writing BAM_MODE_EN bit on NAND_CTRL register.
> 
> NAND_CTRL is an operational register and in BAM mode operational
> registers are read only.
> 
> So, before enabling BAM mode by writing the NAND_CTRL register, check
> if BAM mode was already enabled by the bootloader, and enable BAM mode
> only if it is not enabled already.
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
