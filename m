Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CBF21775A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 20:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgGGS7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 14:59:46 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54341 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgGGS7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:59:46 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9AF5520003;
        Tue,  7 Jul 2020 18:59:40 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@linaro.org,
        alexandre.torgue@st.com
Cc:     marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 5/6] mtd: rawnand: stm32_fmc2: use regmap APIs
Date:   Tue,  7 Jul 2020 20:59:39 +0200
Message-Id: <20200707185939.25039-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1591975362-22009-6-git-send-email-christophe.kerello@st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 51c88a8d3b02cfd4d9209c282b815336c5952619
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-12 at 15:22:41 UTC, Christophe Kerello wrote:
> This patch uses regmap APIs to access all FMC2 registers.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
