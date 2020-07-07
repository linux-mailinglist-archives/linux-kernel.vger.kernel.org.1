Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9CC217767
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 21:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgGGTAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 15:00:13 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53923 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGTAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:00:13 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1FE721C0003;
        Tue,  7 Jul 2020 19:00:08 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@linaro.org,
        alexandre.torgue@st.com
Cc:     marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 1/6] mtd: rawnand: stm32_fmc2: do not display errors if the driver is deferred
Date:   Tue,  7 Jul 2020 21:00:08 +0200
Message-Id: <20200707190008.25296-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1591975362-22009-2-git-send-email-christophe.kerello@st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 5eeb7fe919ff4f683d96cf8c74a9de7e54722040
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-12 at 15:22:37 UTC, Christophe Kerello wrote:
> A MDMA issue has been solved on Kernel 5.7. The effect of this fix is
> that the MDMA driver is now deferred and the FMC2 NFC driver is also
> deferred. All is working fine but there is a FMC2 log in the console:
> stm32_fmc2_nfc 58002000.nand-controller: failed to request tx DMA
> channel: -517
> 
> This patch removes the display of this log in the console in case of
> this error is -EPROBE_DEFER.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
