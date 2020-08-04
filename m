Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D323C19F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgHDVj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 17:39:58 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39460 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHDVj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:39:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 074Ldrf1122069;
        Tue, 4 Aug 2020 16:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596577193;
        bh=LImguDWeGSZHfnoAy6ty67PNB7Bs0ypFqLfjErMZBRM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NrU7I/SnO9Fyi5+7cqDG8h57eUeH1ACOYuQpUMDaxCOfOkUsayqFCsEYo3fBMIAhb
         A/t7YwQQdQ+Xtyspmtk7Sw5RNp3RIL6MBR9pOcs2fDplDKaxQ3zXWdfW+B5oZwoPlH
         i5Fus9yVY4k061pvLeWYqqhPkdnvO4n2ZbQZnSIo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 074LdrRM071410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Aug 2020 16:39:53 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 4 Aug
 2020 16:39:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 4 Aug 2020 16:39:52 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 074LdmCj100746;
        Tue, 4 Aug 2020 16:39:49 -0500
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add entry for J7200
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>, <t-kristo@ti.com>
CC:     <nsekhar@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>
References: <20200803105359.16744-1-peter.ujfalusi@ti.com>
 <f13b8e17-308f-fdf2-885e-318710d4d836@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <a3ea4e4f-1c7e-b7b1-798e-4fda0ce73cba@ti.com>
Date:   Wed, 5 Aug 2020 00:39:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f13b8e17-308f-fdf2-885e-318710d4d836@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On 03/08/2020 17:41, Lokesh Vutla wrote:
> 
> 
> On 03/08/20 4:23 pm, Peter Ujfalusi wrote:
>> Update K3 chipinfo driver to support new TI J7200 SoC.
>> It's JTAG PARTNO is 0xBB6D.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>



-- 
Best regards,
grygorii
