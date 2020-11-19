Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC682B9CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgKSVJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:09:08 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58415 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKSVJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:09:06 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 499F660003;
        Thu, 19 Nov 2020 21:09:04 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/23] mtd: ubi: wl: Fix a couple of kernel-doc issues
Date:   Thu, 19 Nov 2020 22:09:03 +0100
Message-Id: <20201119210903.26049-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-13-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 46bf8c58b0c67cf7bc5b318894b6fbe51c396b49
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:21:55 UTC, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/ubi/wl.c:584: warning: Function parameter or member 'nested' not described in 'schedule_erase'
>  drivers/mtd/ubi/wl.c:1075: warning: Excess function parameter 'shutdown' description in '__erase_worker'
> 
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
