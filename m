Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACCA27FDAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgJAKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:50:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33622 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbgJAKu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:50:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091AoEXG096966;
        Thu, 1 Oct 2020 05:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601549414;
        bh=zjVe+1hVGG9fRo6kpJTm9iQgf/nkwnz8d97EAW7jcHQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Gs51p7O1KF0ErqsOLXksH1++lJMAbEXKWq8FGE6JSfFd7leOjRdITaOGgicIo+gxG
         njCVWCPyg6suoqIctHNkEgqdc/aONWyvIQmRYl7eae4yW7BtHSyA5QXRFuOdqQGBYt
         gdEpG2JnLk3QoF7u4x9907aRBGjcAhbLwlUu3as4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091AoDCP020945;
        Thu, 1 Oct 2020 05:50:13 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 05:50:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 05:50:13 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091Ao9bt067843;
        Thu, 1 Oct 2020 05:50:11 -0500
Subject: Re: [PATCH v14 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of
 ENOTSUPP
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     <Tudor.Ambarus@microchip.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-2-p.yadav@ti.com>
 <5340adf5-1bb2-1eff-3812-6976b3b76faf@microchip.com>
 <20201001073425.txsfdngrsugsy6uf@ti.com> <20201001095012.5c331bf8@xps13>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b252d015-18d0-0651-87ec-5c4bbfab8411@ti.com>
Date:   Thu, 1 Oct 2020 16:20:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001095012.5c331bf8@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/1/20 1:20 PM, Miquel Raynal wrote:
> Hello,
> 
> Pratyush Yadav <p.yadav@ti.com> wrote on Thu, 1 Oct 2020 13:04:27 +0530:
> 
>> On 01/10/20 07:19AM, Tudor.Ambarus@microchip.com wrote:
>>> On 9/30/20 9:57 PM, Pratyush Yadav wrote:  
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> It seems that your mailer/server introduced that line automatically,
> can you do something to avoid it?
> 
>>>>
>>>> ENOTSUPP is not a SUSV4 error code. Using EOPNOTSUPP is preferred
>>>> in its stead.
> 
> I ran into this checkpatch.pl error recently, I count 80+ iterations in
> drivers/mtd/ so perhaps having a subsystem wide replacement will be
> nice. I'm fine with this patch though as it is addressing all SPI-NOR
> cases already.
> 

Yeah, since this is SPI NOR wide I will go ahead and apply.
Also, this would avoid confusion for ppl adding new code on whether to
address the checkpatch warning or follow the existing convention.

Regards
Vignesh

> Cheers,
> Miquèl
> 

[...]
