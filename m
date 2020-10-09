Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2862884E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbgJIIIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:08:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50324 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732445AbgJIII3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:08:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0998859I031012;
        Fri, 9 Oct 2020 03:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602230885;
        bh=NxfrSzsd/OUHD07jar1MH/oYoEHVZLHspWY/QpE7fts=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=d7vfYoIRZO7vkKELn5NnXtAs9wK+Os7zctl6haVNocaW7US4zM5vlSieAiKnEECmT
         p416DHwlEZor8PPCL19eI8FsAiLWwlVdVWNqQQXfBysq1Ebw1ohij9UWzUCLFIGKPg
         ycCo9gryKrZhQiBkQ1jZRVFZH3rhKXHZH3mtRdQs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099885vD123405
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 03:08:05 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 03:08:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 03:08:05 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0998832T048386;
        Fri, 9 Oct 2020 03:08:04 -0500
Subject: Re: [PATCH v2 00/11] firmware/soc: ti_sci, ringacc/inta: Preparation
 for AM64 DMA support
To:     <santosh.shilimkar@oracle.com>, <nm@ti.com>, <t-kristo@ti.com>,
        <ssantosh@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
References: <20201008115224.1591-1-peter.ujfalusi@ti.com>
 <c113a16a-b611-bca2-2a62-3199b71acd7f@oracle.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <79364f4a-04ea-94e5-29b4-da2bf657a21d@ti.com>
Date:   Fri, 9 Oct 2020 11:08:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <c113a16a-b611-bca2-2a62-3199b71acd7f@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2020 3.56, santosh.shilimkar@oracle.com wrote:
> On 10/8/20 4:52 AM, Peter Ujfalusi wrote:
>> Santosh: if you plan to take this series for 5.11, then can you create an
>> immutable branch which I can refer to Vinod for the DMA patches I'm
>> going to
>> send soon.
> 
> I will set it up right after the 5.10-rc1 is tagged.

Thank you!

> 
> regards,
> Santosh

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
