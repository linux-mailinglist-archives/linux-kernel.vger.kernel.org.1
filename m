Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8FD2A4584
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgKCMrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:47:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37968 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgKCMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:47:13 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A3Cl5BB084289;
        Tue, 3 Nov 2020 06:47:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604407625;
        bh=7nU52jDNskuCFoByT3d/IVtGXinvA+e6Q9ImtTKXrqQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kUrtmRA0ut7UInOUh0yEAfREvbkPL9LcL9ghEVEZVE+ftKEKf77G+XZR+b3jyjZX5
         klTIjiuCLxfJfAOaAUqkRI75K3Zh8nK0V9UmyzliUDiuGKAHMZVa1SdplMz6wJH6y7
         rT+7V+tkdRRfi8KcpW1QFIyxkAybCB0hmNuNIwAM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A3Cl5JL061364
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 06:47:05 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 06:47:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 06:47:04 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A3Cl4xG040830;
        Tue, 3 Nov 2020 06:47:04 -0600
Date:   Tue, 3 Nov 2020 18:17:03 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] UBI: Do not zero out EC and VID when multi-pass
 writes are not supported
Message-ID: <20201103124701.xgjomxzemhnczqhw@ti.com>
References: <20201012180404.6476-1-p.yadav@ti.com>
 <20201012180404.6476-3-p.yadav@ti.com>
 <f013d7af-6e1d-5b8f-4a23-7f6c150f896a@ti.com>
 <782317824.260495.1604404771008.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <782317824.260495.1604404771008.JavaMail.zimbra@nod.at>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/20 12:59PM, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Vignesh Raghavendra" <vigneshr@ti.com>
> >
> > You may want to get rid of assertion for mtd->writesize != 1 in case of
> > MTD_NORFLASH.
> 
> Agreed. I hope nothing else breaks if NOR has suddenly a writesize >= 1.

Please see my response on the cover letter which explains why I think 
setting mtd->writesize = nor->page_size is wrong.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
