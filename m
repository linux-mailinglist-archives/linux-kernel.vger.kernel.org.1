Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDFE23411F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 10:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbgGaIVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 04:21:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35048 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731510AbgGaIVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:21:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 83900546A0BE68C9AED0;
        Fri, 31 Jul 2020 16:21:16 +0800 (CST)
Received: from [127.0.0.1] (10.74.173.29) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 31 Jul 2020
 16:21:08 +0800
Subject: Re: [PATCH 03/10] crypto: hisilicon/zip - modify debugfs interface
 parameters
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1595648683-50590-1-git-send-email-shenyang39@huawei.com>
 <1595648683-50590-4-git-send-email-shenyang39@huawei.com>
 <20200731081227.GA20741@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
From:   "shenyang (M)" <shenyang39@huawei.com>
Message-ID: <41618b33-abd5-d265-4395-5bf4ece5a0cc@huawei.com>
Date:   Fri, 31 Jul 2020 16:21:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200731081227.GA20741@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.173.29]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/31 16:12, Herbert Xu wrote:
> On Sat, Jul 25, 2020 at 11:44:36AM +0800, Yang Shen wrote:
>> From: Shukun Tan <tanshukun1@huawei.com>
>>
>> Update debugfs interface parameters
>>
>> Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
>> Signed-off-by: Yang Shen <shenyang39@huawei.com>
>> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>  drivers/crypto/hisilicon/zip/zip_main.c | 55 ++++++++++++++-------------------
>>  1 file changed, 24 insertions(+), 31 deletions(-)
>
> This patch doesn't apply against cryptodev.
>
> Plesae stop sending patch series that depend on others.
>
> Thanks,
>

Sorry, this patchset depends on
https://patchwork.kernel.org/cover/11680181/
which cover letter is '[PATCH v3 00/10] crypto: hisilicon/qm - misc fixes'

I'm really sorry for the trouble.

Thanks,

