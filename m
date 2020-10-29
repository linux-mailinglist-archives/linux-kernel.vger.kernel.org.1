Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D52A29EDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgJ2Nzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:55:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44396 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgJ2Nzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:55:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09T4jWMt107694;
        Wed, 28 Oct 2020 23:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603946732;
        bh=k90ElPyffvW0MrNwFrUL11wCz1vV2AcGkf9Sc5wDWRk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WHkCEeDcWpcXtiUh0hAInZvMhfWPBC3pAkkXYIpjbGri9QWWjbWgKcR022t4ILO1C
         c94/bGBwwWbx4FzMLz4OEwKxiqiYc8gunYD/QNSvW9WPbu9QJgvguYRtYIcketyCIU
         PHoFLrAm/+D8LDlfW9Nqx6S8YDWWdvcaC6w8Fzko=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09T4jWxX093357
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 23:45:32 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 23:45:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 23:45:32 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09T4jTX0006901;
        Wed, 28 Oct 2020 23:45:29 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Alexander A Sverdlin <alexander.sverdlin@nokia.com>,
        <linux-mtd@lists.infradead.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Don't copy self-pointing struct around
Date:   Thu, 29 Oct 2020 10:15:08 +0530
Message-ID: <160390597173.12290.18229990126806445717.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201005084803.23460-1-alexander.sverdlin@nokia.com>
References: <20201005084803.23460-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 10:48:03 +0200, Alexander A Sverdlin wrote:
> spi_nor_parse_sfdp() modifies the passed structure so that it points to
> itself (params.erase_map.regions to params.erase_map.uniform_region). This
> makes it impossible to copy the local struct anywhere else.
> 
> Therefore only use memcpy() in backup-restore scenario. The bug may show up
> like below:
> 
> [...]

Updated Fixes tag as suggested by Tudor.
Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks!
[1/1] mtd: spi-nor: Don't copy self-pointing struct around
      https://git.kernel.org/mtd/c/69a8eed58c

--
Regards
Vignesh

