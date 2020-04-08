Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5BA1A299F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 21:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgDHTuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 15:50:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46294 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgDHTuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:50:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 038Jo14V094903;
        Wed, 8 Apr 2020 14:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586375401;
        bh=PiU2nyxYs+ZuZYpfplhJB684M68ejmcd39RGjgjoHo4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oO+ypjTJtQ1+nKZMGj2tJ4IxLqCrnM1YNk6BdZfmVNX4W4eYpITOoHsEOskvz0R6b
         Y5mAssHsmOUvD7H8I69rPtRnj4Vx/aZYHNJFKlDgS74V3/K3SZyH27aplCQ1QLfy+A
         A7nYQTlCzNAZnb5lTyURLc92mz85F6Uy2fVs0ynM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 038Jo1wS056126
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Apr 2020 14:50:01 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Apr
 2020 14:50:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Apr 2020 14:50:00 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038JnsLe093482;
        Wed, 8 Apr 2020 14:49:58 -0500
Subject: Re: [PATCH v2] dma-debug: fix displaying of dma allocation type
To:     Christoph Hellwig <hch@lst.de>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>
References: <20200408194300.21426-1-grygorii.strashko@ti.com>
 <20200408194527.GA13647@lst.de>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <b91b8918-85fd-5d01-7b08-62b510146036@ti.com>
Date:   Wed, 8 Apr 2020 22:49:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200408194527.GA13647@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/04/2020 22:45, Christoph Hellwig wrote:
> On Wed, Apr 08, 2020 at 10:43:00PM +0300, Grygorii Strashko wrote:
>> +static const char *type2name[5] = {
>> +	[dma_debug_single] = "single",
>> +	[dma_debug_sg] = "scather-gather",
>> +	[dma_debug_coherent] = "coherent",
>> +	[dma_debug_resource] = "resource",
>> +};
> 
> We actually only have 4, not 5 elements now (and don't really
> need the sizing anyway).  But I can fix that when applying, thanks!
  
Yeah. Sorry and thank you.

-- 
Best regards,
grygorii
