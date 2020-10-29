Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF0A29ED6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgJ2Nr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:47:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42646 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgJ2Nr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:47:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09T4kP4H108091;
        Wed, 28 Oct 2020 23:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603946785;
        bh=ZHzDgXy5n/TKfBP+owyaj3kVbyqfBFp5+LAX2bZzh6o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zInayPCxMbBtlmPL9Xjmm0gP626sZOqh+wwGHW4mu+pp/q/FIV4M4eAycN77CkImM
         CsuzgdqmKNhkk8eXyJ8ZiSK3SEPVVufqjuNdHxp7Mtg9c65x6Lt5dr6QURooHKTQ3e
         Lm+o63YMTM9yWKPNVsi2Hl8aD1QBLw7bV7pywGvg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09T4kPLS107855
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 23:46:25 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 23:46:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 23:46:25 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09T4kMH0095353;
        Wed, 28 Oct 2020 23:46:23 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <miquel.raynal@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <tudor.ambarus@microchip.com>, Bert Vermeulen <bert@biot.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [RESEND PATCH v2] mtd: spi-nor: Fix address width on flash chips > 16MB
Date:   Thu, 29 Oct 2020 10:16:02 +0530
Message-ID: <160390597173.12290.7971814843989994724.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201006132346.12652-1-bert@biot.com>
References: <20201006132346.12652-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 15:23:46 +0200, Bert Vermeulen wrote:
> If a flash chip has more than 16MB capacity but its BFPT reports
> BFPT_DWORD1_ADDRESS_BYTES_3_OR_4, the spi-nor framework defaults to 3.
> 
> The check in spi_nor_set_addr_width() doesn't catch it because addr_width
> did get set. This fixes that check.

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks!
[1/1] mtd: spi-nor: Fix address width on flash chips > 16MB
      https://git.kernel.org/mtd/c/324f78dfb4

--
Regards
Vignesh

