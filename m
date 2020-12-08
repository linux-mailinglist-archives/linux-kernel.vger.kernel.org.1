Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0262F2D2F30
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgLHQMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:12:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56484 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgLHQMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:12:31 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B8GBPVY016701;
        Tue, 8 Dec 2020 10:11:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607443885;
        bh=RJdgsj5A5pt3bCnNMA5AT7RiqVyaXbqszWsx9anQLAU=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=aX1/ObrHy6iCXQ9tJCne3QBtCo7BX+3S43hHqKjnDKOIdqJUzx/UkS/nT3tQkxw6u
         eD1PY07qaH4qIrg30LTZs0ZJbLelJt4+fVTfggwlFFClmtmJke2Y1bn5adQYTAzs9d
         SWub9zaoMMOcKimyN58aUMkJrQVwXINQAID2HbyE=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B8GBOPJ040236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 10:11:24 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 10:11:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 10:11:24 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B8GBL1r040523;
        Tue, 8 Dec 2020 10:11:22 -0600
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: core: Allow flashes to specify MTD
 writesize
To:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20201201102711.8727-1-p.yadav@ti.com>
 <20201201102711.8727-3-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <336aece6-33a0-e528-1d54-17d0d3c38624@ti.com>
Date:   Tue, 8 Dec 2020 21:41:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201201102711.8727-3-p.yadav@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

On 12/1/20 3:57 PM, Pratyush Yadav wrote:
> Some flashes like the Cypress S28 family use ECC. Under this ECC scheme,
> multi-pass writes to an ECC block is not allowed. In other words, once
> data is programmed to an ECC block, it can't be programmed again without
> erasing it first.
> 
> Upper layers like file systems need to be given this information so they
> do not cause error conditions on the flash by attempting multi-pass
> programming. This can be done by setting 'writesize' in 'struct
> mtd_info'.
> 
> Set the default to 1 but allow flashes to modify it in fixup hooks. If
> more flashes show up with this constraint in the future it might be
> worth it to add it to 'struct flash_info', but for now increasing its
> size is not worth it.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> 

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
spi-nor/next, thanks!
[2/3] mtd: spi-nor: core: Allow flashes to specify MTD writesize
      https://git.kernel.org/mtd/c/afd473e858

Regards
Vignesh

