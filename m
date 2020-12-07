Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633AC2D08B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 02:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgLGBLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 20:11:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9019 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLGBLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 20:11:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cq4x0351qzhn7d;
        Mon,  7 Dec 2020 09:10:12 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 09:10:37 +0800
Subject: Re: [PATCH 2/5] crypto: hisilicon/sec - add new type of sqe for
 Kunpeng930
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1606357086-9785-1-git-send-email-liulongfang@huawei.com>
 <1606357086-9785-3-git-send-email-liulongfang@huawei.com>
 <20201204070359.GA26438@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <26023bba-78cf-4d91-3510-b6d69fa4768e@huawei.com>
Date:   Mon, 7 Dec 2020 09:10:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201204070359.GA26438@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/4 15:03, Herbert Xu Wrote:
> On Thu, Nov 26, 2020 at 10:18:03AM +0800, Longfang Liu wrote:
>>
>> diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
>> index 0e933e7..712176b 100644
>> --- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
>> +++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
>> @@ -211,6 +219,167 @@ struct sec_sqe {
>>  	struct sec_sqe_type2 type2;
>>  };
>>  
>> +#pragma pack(4)
> 
> Please don't use pragma pack.  Instead add the attributes as
> needed to each struct or member.
> 
> Cheers,
> 
OK, I will modify it in next patchset
thanks.
Longfang
