Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E72D0B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgLGHrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:47:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8709 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLGHrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:47:14 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CqFjY3kFfzklR8;
        Mon,  7 Dec 2020 15:45:53 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 15:46:28 +0800
Subject: Re: [PATCH 2/5] crypto: hisilicon/sec - add new type of sqe for
 Kunpeng930
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1606357086-9785-1-git-send-email-liulongfang@huawei.com>
 <1606357086-9785-3-git-send-email-liulongfang@huawei.com>
 <20201204070359.GA26438@gondor.apana.org.au>
 <dd219ba4-b96d-7434-34d5-5b046f24775f@huawei.com>
 <20201207034511.GA10526@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <baacaad6-f741-1894-52a8-5f5047e76969@huawei.com>
Date:   Mon, 7 Dec 2020 15:46:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201207034511.GA10526@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/7 11:45, Herbert Xu Wrote:
> On Mon, Dec 07, 2020 at 11:43:38AM +0800, liulongfang wrote:
>>
>> Can I use __attribute__((aligned(n))) instead of #pragma pack(n)?
> 
> We normally just use __aligned(n) in the kernel.
> 
> Cheers,
> 
I need to use "__packed __aligned(n)" to make sure the structure length is normal.
Is it possible to use "__packed __aligned(n)" in the kernel?
Thanks.
Longfang.
