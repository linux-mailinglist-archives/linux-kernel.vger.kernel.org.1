Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F2926A028
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIOHt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:49:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41654 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgIOHs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:48:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08F7lVYV073494;
        Tue, 15 Sep 2020 02:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600156051;
        bh=F1VtgPYhfoDI8XLXkh3ytrJ6AvV5dM/S6p5vJyP8ges=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GVQTZFD+BngUoXYojAYu820J17/dT+ELcF3Bj0dk45hEKIePkQCuUdVeWFEWmaKuC
         P2zUpcLGJf9ZLfNbJ7vVy2ByHVVwnVbSdkLWUMb4JTYePnx2YppQiHQN9NZHrGde+/
         4M1KTriHvr7l5RwcjWIbHkaDavB1SZpgTNMFJVdk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08F7lV0H096544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 02:47:31 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 02:47:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 02:47:30 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08F7lTcF019578;
        Tue, 15 Sep 2020 02:47:30 -0500
Date:   Tue, 15 Sep 2020 13:17:29 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v12 00/14] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20200915074727.o4drgfgdabhozjb5@ti.com>
References: <20200903171313.18741-1-p.yadav@ti.com>
 <973eac67-fa01-309f-c4d1-7983f404d507@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <973eac67-fa01-309f-c4d1-7983f404d507@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/20 12:16PM, Vignesh Raghavendra wrote:
> 
> 
> On 9/3/20 10:42 PM, Pratyush Yadav wrote:
> > Hi,
> > 
> > This series adds support for Octal DTR flashes in the SPI NOR framework,
> > and then adds hooks for the Cypress Semper and Micron Xcella flashes to
> > allow running them in Octal DTR mode. This series assumes that the flash
> > is handed to the kernel in Legacy SPI mode.
> > 
> > Tested on TI J721E EVM with 1-bit ECC on the Cypress flash.
> > 
> [...]
> 
> Please fix checkpatch issues on patch 1, 3, 4 and 5

I ran checkpatch on my patches based on top of next-20200914 just now. I 
only see issues with patches 3 and 4. Patches 1 and 5 report no issues. 
What problems do you see on patches 1 and 5?

As for patches 3 and 4, the error I see is "ENOTSUPP is not a SUSV4 
error code, prefer EOPNOTSUPP". I left it in intentionally. There a 
couple other functions in SPI NOR that use ENOTSUPP instead of 
EOPNOTSUPP so I followed the local convention.

If you insist, I can add a preparatory patch that first changes those 
uses of ENOTSUPP to EOPNOTSUPP and then update patches 3 and 4 to do the 
same. Let me know.
 
> Otherwise patches look good to me...

Thanks.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
