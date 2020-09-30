Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6A27E3DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgI3IfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:35:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44354 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3IfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:35:13 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U8Z3Rx052743;
        Wed, 30 Sep 2020 03:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601454903;
        bh=z7DTfVdRp6TQ9HpNMgRK+uU9T+07dBPntD5IK2iAKxs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XwXLIQPNz4AgcOXkmw/p3sqEjIUc9vM39rxzeegbrPnDUqTn7CuldoVgE+/K+K4he
         F91MDszHryB+Wz23C7HGKwF9Ii7IwbOorfDoNYMqTj3eCvWFs5ezV9oG6JE2VWDktp
         qnFqWuXYyBj7Ijj6vxqQlo/609rkNpqSRKaGOkqY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U8Z32c059092;
        Wed, 30 Sep 2020 03:35:03 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 03:35:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 03:35:03 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U8Yo8m098804;
        Wed, 30 Sep 2020 03:35:00 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Robert Marko <robert.marko@sartura.hr>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <tudor.ambarus@microchip.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH] mtd: spi-nor: macronix: Add SECT_4K to mx25l12805d
Date:   Wed, 30 Sep 2020 14:04:45 +0530
Message-ID: <160145480408.16293.13001875273291191478.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915100623.708736-1-robert.marko@sartura.hr>
References: <20200915100623.708736-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 12:06:23 +0200, Robert Marko wrote:
> According to the mx25l12805d datasheet it supports using 4K or 64K sectors.
> So lets add the SECT_4K to enable 4K sector usage.
> 
> Datasheet: https://www.mxic.com.tw/Lists/Datasheet/Attachments/7321/MX25L12805D,%203V,%20128Mb,%20v1.2.pdf

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/1] mtd: spi-nor: macronix: Add SECT_4K to mx25l12805d
      https://git.kernel.org/mtd/c/02892d4053

--
Regards
Vignesh

