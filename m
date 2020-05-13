Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5E1D04D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 04:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgEMCWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 22:22:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48890 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgEMCWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:22:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04D2M2GV128834;
        Tue, 12 May 2020 21:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589336522;
        bh=PkD79KhQ6L8I25qd2ophTzYoQjxGMbERYNBealN9Tg8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EMESmRnrmvDtPJnv7F+d6anbts8qm7QEn2R0yzTqNIZZiugyEwhKrM02pyT10TWGK
         03bSQmfPFGIuvDXH17WoZksnzwcGCx77a6W4Rw/sSVDNlUOuPPq67aKl6GWW6on/jR
         c2dCVOF/NzxWdPnXuCCrL+mmXgL401kdUFpRboIs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04D2M2dA127541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 21:22:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 21:22:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 21:22:01 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04D2LwIV034536;
        Tue, 12 May 2020 21:21:59 -0500
Subject: Re: [PATCH] phy: cpcap-usb: Remove some useless code
To:     Tony Lindgren <tony@atomide.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <vkoul@kernel.org>, <pavel@ucw.cz>,
        <sebastian.reichel@collabora.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20200507203127.202197-1-christophe.jaillet@wanadoo.fr>
 <20200508152254.GZ37466@atomide.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c8a8bcf5-f7e1-115d-34f5-3b88bc1ef0d7@ti.com>
Date:   Wed, 13 May 2020 07:51:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508152254.GZ37466@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2020 8:52 PM, Tony Lindgren wrote:
> * Christophe JAILLET <christophe.jaillet@wanadoo.fr> [200507 20:32]:
>> Axe a clk that is unused in the driver.
> 
> Thanks for fixing it:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

merged, thanks!

-Kishon
