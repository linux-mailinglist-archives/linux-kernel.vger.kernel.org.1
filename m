Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33FA27E3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgI3IfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:35:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54566 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3IfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:35:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U8YsLi019708;
        Wed, 30 Sep 2020 03:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601454894;
        bh=xiEfXyyoVBEQy077KvyFGTW8nUeUU8zW4KN2Ea5Ce9g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ps0/WBIO6AaukMPswHnjM9KxVNi85lcOg/2C7cbsSGOTZXnQzl7jvaPmTTqQ7gdxT
         EEmqXdy2ieteVjfxIDLOFbSev2zkG9UM9OUnCYGXRCCahtZQcI69idXFweP4jiw+bF
         KvbRLMdd/dyvzkwl4GqSPq6pQgfi0BqJQsx9Z9LE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U8YsVm058661;
        Wed, 30 Sep 2020 03:34:54 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 03:34:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 03:34:53 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U8Yo8j098804;
        Wed, 30 Sep 2020 03:34:51 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Prefer asynchronous probe
Date:   Wed, 30 Sep 2020 14:04:42 +0530
Message-ID: <160145480408.16293.4165746233350450081.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902160002.1.I658d1c0db9adfeb9a59bc55e96a19e192c959e55@changeid>
References: <20200902160002.1.I658d1c0db9adfeb9a59bc55e96a19e192c959e55@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 16:00:40 -0700, Douglas Anderson wrote:
> On my system the spi_nor_probe() took ~6 ms at bootup.  That's not a
> lot, but every little bit adds up to a slow bootup.  While we can get
> this out of the boot path by making it a module, there are times where
> it is convenient (or even required) for this to be builtin the kernel.
> Let's set that we prefer async probe so that we don't block other
> drivers from probing while we are probing.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/1] mtd: spi-nor: Prefer asynchronous probe
      https://git.kernel.org/mtd/c/03edda0e1e

--
Regards
Vignesh

