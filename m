Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DDB2DE3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgLRORq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:17:46 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36450 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgLRORq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:17:46 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BIEFpSF091620;
        Fri, 18 Dec 2020 08:15:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608300951;
        bh=DwkWsrszvMiOb0nL+AJTXiIMeG3qwYFNPypoohDjmBM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VzidrxPLx6gfI/Qmz3CYdCjimJ+1lzhleusL0O2SrwEQ7Hl7IYPi9Ib2sbyP9r5XD
         l8DvOfP7CfnqYiY3wVDJBxWXkkJbqsz1izeDt+Mmb9RHUqtVA0TTIHuxphye1A8V2j
         ofvAICBbrvQUasQ4DbpGv3Lg+Pnj+6355q+b5xb0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BIEFp2E002848
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 08:15:51 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Dec 2020 08:15:51 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Dec 2020 08:15:51 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BIEFoHU092617;
        Fri, 18 Dec 2020 08:15:51 -0600
Date:   Fri, 18 Dec 2020 19:45:50 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: sfdp: Fix SMPT parsing when 4BAIT table is
 before SMPT
Message-ID: <20201218141550.f2ik6lw65ly4lca5@ti.com>
References: <20201212115817.5122-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201212115817.5122-1-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 12/12/20 05:28PM, Vignesh Raghavendra wrote:
> If 4BAIT table appears before SMPT then, nor->addr_width is set to 4 before
> SMPT table is parsed. This causes SMPT parser code to use addr_width of 4
> for reading current sector map configuration in spi_nor_get_map_in_use()
> if SMPT_CMD_ADDRESS_LEN reads SMPT_CMD_ADDRESS_LEN_USE_CURRENT (see
> spi_nor_smpt_addr_width()). Instead code should be using the value
> presented by BFPT_DWORD1_ADDRESS_BYTES field. On S28HS family of devices
> this bug leads to selection of invalid sector mapping thus causing erase
> and write failures.
> 
> Fix this by parsing 4BAIT address table at the very end after all other
> parameter tables are parsed.

I'm not convinced this is the best way to go about this. What if we have 
another table tomorrow that introduces some other side effect? Will we 
special-case all those as well? IMO a better way of going about this 
would be to make these parsers not affect the current state of the 
flash, but instead store that information as a possible future state of 
the flash. Then we can use that to finally decide what we want to do in 
spi_nor_set_addr_width(). In fact, that information is already stored 
via SNOR_F_HAS_4BAIT (though I'm not too opposed to adding a 
nor->params->addr_width).

I see this as a cleaner alternative to your approach. We do need to be 
careful about any obscure bugs here like with [0] though.

[0] https://lore.kernel.org/linux-mtd/20201006132346.12652-1-bert@biot.com/

-- 
Regards,
Pratyush Yadav
Texas Instruments India
