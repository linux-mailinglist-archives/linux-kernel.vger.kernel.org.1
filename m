Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A192D0EB3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgLGLKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:10:36 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:10525 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLGLKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:10:35 -0500
X-Originating-IP: 109.220.208.103
Received: from localhost.localdomain (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AD863240019;
        Mon,  7 Dec 2020 11:09:51 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        tudor.ambarus@microchip.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, robh+dt@kernel.org
Cc:     cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        richard@nod.at, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, qi-ming.wu@intel.com
Subject: Re: [PATCH v17 1/2] dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC
Date:   Mon,  7 Dec 2020 12:09:50 +0100
Message-Id: <20201207110950.8142-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To:  <20201110012333.18647-2-vadivel.muruganx.ramuthevar@linux.intel.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: e5ec4db9992be75dd4e18c408e0ea2f6646ae112
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-10 at 01:23:32 UTC, "Ramuthevar, Vadivel MuruganX" wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add YAML file for dt-bindings to support NAND Flash Controller
> on Intel's Lightning Mountain SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
