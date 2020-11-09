Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94D92AC22C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbgKIR0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:26:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50140 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbgKIR0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:26:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9HQ6oo010288;
        Mon, 9 Nov 2020 11:26:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604942767;
        bh=eKRlGEeVdSpzyOS3CbMbMx61s3L73kVGKe+o4x55G0s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vWdI2/oHkvCy16HluTWuU73GQuOjQ7R0Nk4GFVvy/SHM8v2ci12FVsb/EyEI9+RW2
         zctfwl8OnYwREa5EgzvVT8y1+BfFT5Pvd3vPp2dP3oCED1/zIe7ct+dOv7wtsXmtlW
         JcoXprmr20wqdNhRUv+Z0Q2San3HGAPw3lVC/iZU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9HQ6ug059918
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 11:26:06 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 11:26:06 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 11:26:06 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9HQ3UY046797;
        Mon, 9 Nov 2020 11:26:03 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-kernel@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v16 00/15] mtd: spi-nor: add xSPI Octal DTR support
Date:   Mon, 9 Nov 2020 22:55:49 +0530
Message-ID: <160494271262.25072.15509428200904851771.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201005153138.6437-1-p.yadav@ti.com>
References: <20201005153138.6437-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 21:01:23 +0530, Pratyush Yadav wrote:
> This series adds support for Octal DTR flashes in the SPI NOR framework,
> and then adds hooks for the Cypress Semper and Micron Xcella flashes to
> allow running them in Octal DTR mode. This series assumes that the flash
> is handed to the kernel in Legacy SPI mode.
> 
> Tested on Micron MT35X and S28HS flashes for Octal DTR. Tested on Micron
> MT25Q, and Cypress S25FL for regressions. All flashes were tested by
> running a read/write stress test on top of UBIFS. On the Cypress S28HS
> flash 1-bit ECC had to be used to allow UBIFS to work since partial page
> writes don't work with 2-bit ECC.
> 
> [...]

With comments on 14/15 addressed:

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of ENOTSUPP
        https://git.kernel.org/mtd/c/39bdfb789b
[02/15] mtd: spi-nor: add spi_nor_controller_ops_{read_reg, write_reg, erase}()
        https://git.kernel.org/mtd/c/6e1bf55d72
[03/15] mtd: spi-nor: add support for DTR protocol
        https://git.kernel.org/mtd/c/0e30f47232
[04/15] mtd: spi-nor: sfdp: get command opcode extension type from BFPT
        https://git.kernel.org/mtd/c/0e1b2fc4e5
[05/15] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
        https://git.kernel.org/mtd/c/fb27f19897
[06/15] mtd: spi-nor: core: use dummy cycle and address width info from SFDP
        https://git.kernel.org/mtd/c/6c6a2b2b8e
[07/15] mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
        https://git.kernel.org/mtd/c/354b412967
[08/15] mtd: spi-nor: Introduce SNOR_F_IO_MODE_EN_VOLATILE
        https://git.kernel.org/mtd/c/c6908077b1
[09/15] mtd: spi-nor: Parse SFDP SCCR Map
        https://git.kernel.org/mtd/c/981a8d60e0
[10/15] mtd: spi-nor: core: enable octal DTR mode when possible
        https://git.kernel.org/mtd/c/a33c89db4c
[11/15] mtd: spi-nor: sfdp: detect Soft Reset sequence support from BFPT
        https://git.kernel.org/mtd/c/1131324aa5
[12/15] mtd: spi-nor: core: perform a Soft Reset on shutdown
        https://git.kernel.org/mtd/c/d73ee7534c
[13/15] mtd: spi-nor: core: disable Octal DTR mode on suspend.
        https://git.kernel.org/mtd/c/1b65c43f70
[14/15] mtd: spi-nor: spansion: add support for Cypress Semper flash
        https://git.kernel.org/mtd/c/c3266af101
[15/15] mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode
        https://git.kernel.org/mtd/c/ad624dfd7b

--
Regards
Vignesh

