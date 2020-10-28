Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A929EC85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgJ2NLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:11:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58140 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2NLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:11:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09SCnNwE082440;
        Wed, 28 Oct 2020 07:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603889363;
        bh=cVYMUJFuKCZV0NDQtaS9JCEpzTQEwMkt4PYY9fuDFRo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fWtuOUuqdOANXVb4TvpriU3jMR8ufU8Ym/e54voTOee91+91+pBzuMV6AykJI1xLA
         iMu+bg46UVxaYzP5QHlTp0430fm+KWEg5Kc2ZaPA9KJgHGNBhZjXc3RhrAzZ6Hlmdl
         ajwCoYqSkTLRFBNWFit4RiDiu3nnUHOoeM010mGY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09SCnNx4064380
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 07:49:23 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 07:49:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 07:49:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09SCnMpu034022;
        Wed, 28 Oct 2020 07:49:23 -0500
Date:   Wed, 28 Oct 2020 18:19:22 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v16 00/15] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20201028124920.pot77v4phkqiswhr@ti.com>
References: <20201005153138.6437-1-p.yadav@ti.com>
 <d0d702c1-761b-1480-c74d-135193b33c26@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d0d702c1-761b-1480-c74d-135193b33c26@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 28/10/20 07:53AM, Tudor.Ambarus@microchip.com wrote:
> Hi, Pratyush,
> 
> On 10/5/20 6:31 PM, Pratyush Yadav wrote:
> > Tested on Micron MT35X and S28HS flashes for Octal DTR. 
> 
> Do these flashes define the "Command Sequences to Change to
> Octal DDR (8D-8D-8D) mode" table? Can't we use that table
> instead of defining our own octal dtr enable functions?

The Micron flash does not have this table. The Cypress flash does. The 
problem is that one of the samples of the Cypress flash I tested on had 
incorrect data in that table which meant the sequence would fail. The 
newer samples of the flash have the correct data.

I don't know how many of those faulty flashes are out there in the wild. 
IMO, to be on the safe side spi_nor_cypress_octal_dtr_enable() needs to 
be implemented. So from the point of view of this series there is no 
need to parse the Octal DDR enable table.
 
> I see that Mason used this table for a macronix flash:
> https://patchwork.ozlabs.org/project/linux-mtd/patch/1590737775-4798-4-git-send-email-masonccyang@mxic.com.tw/
> https://patchwork.ozlabs.org/project/linux-mtd/patch/1590737775-4798-8-git-send-email-masonccyang@mxic.com.tw/
> 
> Cheers,
> ta

-- 
Regards,
Pratyush Yadav
Texas Instruments India
