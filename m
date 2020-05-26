Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960AE1CE584
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgEKU3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:29:16 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:54645 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKU3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:29:15 -0400
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7E434240008;
        Mon, 11 May 2020 20:29:10 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, boris.brezillon@collabora.com
Cc:     marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 03/10] mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS for timeouts
Date:   Mon, 11 May 2020 22:29:08 +0200
Message-Id: <20200511202908.15112-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1588756279-17289-4-git-send-email-christophe.kerello@st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 0185d50c5220e772aa90a21c515b0c87660ec4d7
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-06 at 09:11:12 UTC, Christophe Kerello wrote:
> This patch removes the constant FMC2_TIMEOUT_US.
> FMC2_TIMEOUT_MS will be used each time that we need to wait (except
> when the timeout value is set by the framework).
> 
> It was seen, during stress tests with the sequencer in an overloaded
> system, that we could be close to 1 second, even if we never met this
> value. To be safe, FMC2_TIMEOUT_MS is set to 5 seconds.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
