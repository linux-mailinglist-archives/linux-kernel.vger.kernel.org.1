Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400642AD71A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgKJNHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:07:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51728 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgKJNHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:07:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AAD7a9s052202;
        Tue, 10 Nov 2020 07:07:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605013656;
        bh=F1DK+Hwo07M+h8X6tN7vDgweqrmchcY/gSM3jtcCmtg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GWoy4PQVhXk0ko/Wrjcg4iLXq0Yo23UrokUY8WrQKichppS/XOU1eJLSfoNcFbtpb
         vXnJob1rnbKILa0BJNNHQqx3G4JSQZKUV9qU2jrzEvtMvFqUjkY2p5XEUM4ILutwKE
         9IldPziqSyI8gip+RgOYgyufjlg2CHrJxJ95dJy8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AAD7ab9075247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 07:07:36 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 10
 Nov 2020 07:07:36 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 10 Nov 2020 07:07:36 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AAD7Xmp029378;
        Tue, 10 Nov 2020 07:07:34 -0600
Subject: Re: [PATCH v5 0/3] mtd: spi-nor: keep lock bits if they are
 non-volatile
To:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20201003153235.29762-1-michael@walle.cc>
 <babd96f5018d6081746aa9063ce21756@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <7e5d8d73-51b2-6c7b-9ff5-a0f08b8c01c8@ti.com>
Date:   Tue, 10 Nov 2020 18:37:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <babd96f5018d6081746aa9063ce21756@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/20 3:56 AM, Michael Walle wrote:
> Am 2020-10-03 17:32, schrieb Michael Walle:
>> I bundled this as a series, because otherwise there will be conflicts
>> because the "remove global protection flag" patches modify the same lines
>> as the main patch.
>>
>> See invdividual patches for the version history.
> 
> any news here?
> 

LGTM, thanks!... Will wait for Tudor's Ack before applying.

Regards
Vignesh


