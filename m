Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375B91CE58A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbgEKU3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:29:30 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:59927 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKU32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:29:28 -0400
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0E9B7200009;
        Mon, 11 May 2020 20:29:25 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, boris.brezillon@collabora.com
Cc:     marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 01/10] mtd: rawnand: stm32_fmc2: manage all errors cases at probe time
Date:   Mon, 11 May 2020 22:29:25 +0200
Message-Id: <20200511202925.15250-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1588756279-17289-2-git-send-email-christophe.kerello@st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 71d1f1d5958fe15c1f12f0ecc5aa18ebe2073e31
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-06 at 09:11:10 UTC, Christophe Kerello wrote:
> This patch defers its probe when the expected reset control is not
> yet ready. This patch also handles properly all errors cases at probe
> time.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
