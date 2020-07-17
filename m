Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F9D223046
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 03:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGQBTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 21:19:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbgGQBTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:19:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B3E8B31C2C2E32A9A8F3;
        Fri, 17 Jul 2020 09:19:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.91) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 09:19:47 +0800
Subject: Re: [PATCH -next] s390/mm: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Heiko Carstens <hca@linux.ibm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20200716090703.14315-1-miaoqinglang@huawei.com>
 <20200716112630.GB8484@osiris>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <8c16907a-e933-123e-880a-cdb76f4e56fc@huawei.com>
Date:   Fri, 17 Jul 2020 09:19:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200716112630.GB8484@osiris>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2020/7/16 19:26, Heiko Carstens Ð´µÀ:
> On Thu, Jul 16, 2020 at 05:07:03PM +0800, Qinglang Miao wrote:
>> From: Chen Huang <chenhuang5@huawei.com>
>>
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Chen Huang <chenhuang5@huawei.com>
>> ---
>>   arch/s390/mm/dump_pagetables.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
> Thanks for the patch, however we are going to convert the s390 page
> table dumper to generic code, so I'm not going to apply any cleanup
> patches for this code anymore.
Thanks for your replay, I'm glad to know that.

