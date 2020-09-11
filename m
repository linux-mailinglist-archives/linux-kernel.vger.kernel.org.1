Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D68D266535
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIKQzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:55:41 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:3313 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgIKQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:55:25 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 68FAF240005;
        Fri, 11 Sep 2020 16:55:23 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>, stefan@agner.ch,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mtd: rawnand: vf610_nfc: Remove unused function vf610_nfc_transfer_size()
Date:   Fri, 11 Sep 2020 18:55:22 +0200
Message-Id: <20200911165522.28454-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909134318.36340-1-yuehaibing@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 6534d0b57d71759e1f5e93735e1595be649c160a
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-09 at 13:43:18 UTC, YueHaibing wrote:
> commit ecc40b8df59a ("mtd: rawnand: vf610_nfc: remove old hooks")
> left behind this, remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
