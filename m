Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9922D2F2E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgLHQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:10:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40758 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbgLHQKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:10:30 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B8G9Rij019515;
        Tue, 8 Dec 2020 10:09:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607443767;
        bh=jMCEtiq2Ao4YQ3i7cSDVzFtia9wKjw7cZl1fnWcBEHQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Dngqj84XT6QThr0Ggwg3zm68AkooCN9hL71wjz7A4Wb3Sj19dltDVGJOzR+Pv/gJ4
         /lglzN57j3/TClcwiyuh/YJjmiAH66nLvCc2D7axBw6W+e7iOWN4/j38A0Jo5Gaskk
         +gyBj2VPzsS18gA+AsrO+lZ7zydBznVVPx1NJZDw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B8G9P0M085701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 10:09:25 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 10:09:22 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 10:09:22 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B8G9JcR113149;
        Tue, 8 Dec 2020 10:09:19 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        <linux-mtd@lists.infradead.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Fix multiple typos
Date:   Tue, 8 Dec 2020 21:39:13 +0530
Message-ID: <160744362728.26394.7229666527748628666.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130152416.1283972-1-j.neuschaefer@gmx.net>
References: <20201130152416.1283972-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 16:24:15 +0100, Jonathan Neuschäfer wrote:
> There are a few typos in comments in the SPI NOR framework; fix them.

Addressed Tudor's comments locally.

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/1] mtd: spi-nor: Fix multiple typos
      https://git.kernel.org/mtd/c/c69942bda5

--
Regards
Vignesh

