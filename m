Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2BC2D08CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 02:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgLGBUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 20:20:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9121 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgLGBUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 20:20:52 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cq57s0yrGz15YNj;
        Mon,  7 Dec 2020 09:19:37 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 09:20:06 +0800
Subject: Re: [PATCH 0/5] crypto: hisilicon - add some new algorithms
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1606357086-9785-1-git-send-email-liulongfang@huawei.com>
 <20201204070525.GA26479@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <c74d3ea8-4286-b34f-36ef-8e0425b2dd19@huawei.com>
Date:   Mon, 7 Dec 2020 09:20:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201204070525.GA26479@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/4 15:05, Herbert Xu wrote:
> On Thu, Nov 26, 2020 at 10:18:01AM +0800, Longfang Liu wrote:
>> As the new Kunpeng930 supports some new algorithms,
>> the driver needs to be updated
>>
>> Longfang Liu (4):
>>   crypto: hisilicon/sec - add new type of sqe for Kunpeng930
>>   crypto: hisilicon/sec - add new skcipher mode for SEC
>>   crypto: hisilicon/sec - add new AEAD mode for SEC
>>   crypto: hisilicon/sec - fixes some coding style
>>
>> Meng Yu (1):
>>   crypto: hisilicon/hpre - add version adapt to new algorithms
> 
> Please include details on whether this has been tested with the
> self-tests, including the extra fuzz tests.
> 
> Thanks,
> 
All of these new algorithms have been fully tested by the project team,
Did any test case tests fail?
Thanks.
Longfang
