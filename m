Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9157827B065
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgI1O7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:59:50 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43073 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1O7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:59:49 -0400
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 73E2624000A;
        Mon, 28 Sep 2020 14:59:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liu Shixin <liushixin2@huawei.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mtd: onenand_base: simplify the return expression of onenand_transfer_auto_oob
Date:   Mon, 28 Sep 2020 16:59:46 +0200
Message-Id: <20200928145946.9088-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200921082441.2591669-1-liushixin2@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: f831fb545b530ae86d2384cf0d2dc564929a0da3
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-21 at 08:24:41 UTC, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
