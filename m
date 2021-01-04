Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6712E932C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhADKTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:19:06 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:51467 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbhADKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:19:06 -0500
Received: from localhost.localdomain (lfbn-tou-1-1535-bdcst.w90-89.abo.wanadoo.fr [90.89.98.255])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7F051240003;
        Mon,  4 Jan 2021 10:18:22 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin King <colin.king@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: remove redundant assignment to pointer eb
Date:   Mon,  4 Jan 2021 11:18:20 +0100
Message-Id: <20210104101821.2969-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911102321.22515-1-colin.king@canonical.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 341e4faf9cad1a3299cf06417fd4ed6b31ba35ec
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-11 at 10:23:21 UTC, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer eb is being assigned a value that is never read, the assignment
> is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
