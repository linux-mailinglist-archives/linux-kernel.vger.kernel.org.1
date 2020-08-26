Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070EF252995
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 10:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHZI4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 04:56:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbgHZI4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:56:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A7F9DE2FCF4426178BA4;
        Wed, 26 Aug 2020 16:56:50 +0800 (CST)
Received: from [127.0.0.1] (10.74.173.29) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 26 Aug 2020
 16:56:40 +0800
Subject: Re: [PATCH RESEND 04/10] crypto: hisilicon/zip - replace 'sprintf'
 with 'scnprintf'
To:     David Laight <David.Laight@ACULAB.COM>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <1598238709-58699-1-git-send-email-shenyang39@huawei.com>
 <1598238709-58699-5-git-send-email-shenyang39@huawei.com>
 <d1102aca2bdc4df4acc31d8b082cacce@AcuMS.aculab.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>
From:   "shenyang (M)" <shenyang39@huawei.com>
Message-ID: <abc0c78e-3232-9081-c330-3d5b8db9e683@huawei.com>
Date:   Wed, 26 Aug 2020 16:56:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <d1102aca2bdc4df4acc31d8b082cacce@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.173.29]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/24 16:29, David Laight wrote:
> From: Yang Shen
>> Sent: 24 August 2020 04:12
>>
>> Replace 'sprintf' with 'scnprintf' to avoid overrun.
>>
>> Signed-off-by: Yang Shen <shenyang39@huawei.com>
>> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>  drivers/crypto/hisilicon/zip/zip_main.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
>> index df1a16f..1883d1b 100644
>> --- a/drivers/crypto/hisilicon/zip/zip_main.c
>> +++ b/drivers/crypto/hisilicon/zip/zip_main.c
>> @@ -428,7 +428,7 @@ static ssize_t hisi_zip_ctrl_debug_read(struct file *filp, char __user *buf,
>>  		return -EINVAL;
>>  	}
>>  	spin_unlock_irq(&file->lock);
>> -	ret = sprintf(tbuf, "%u\n", val);
>> +	ret = scnprintf(tbuf, HZIP_BUF_SIZE, "%u\n", val);
>
> Should that be sizeof (tbuf).
>
>>  	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
>>  }
>>
>> @@ -514,13 +514,16 @@ static int hisi_zip_core_debug_init(struct hisi_qm *qm)
>>  	struct debugfs_regset32 *regset;
>>  	struct dentry *tmp_d;
>>  	char buf[HZIP_BUF_SIZE];
>> -	int i;
>> +	int i, ret;
>>
>>  	for (i = 0; i < HZIP_CORE_NUM; i++) {
>>  		if (i < HZIP_COMP_CORE_NUM)
>> -			sprintf(buf, "comp_core%d", i);
>> +			ret = scnprintf(buf, HZIP_BUF_SIZE, "comp_core%d", i);
>>  		else
>> -			sprintf(buf, "decomp_core%d", i - HZIP_COMP_CORE_NUM);
>> +			ret = scnprintf(buf, HZIP_BUF_SIZE, "decomp_core%d",
>> +					i - HZIP_COMP_CORE_NUM);
>> +		if (!ret)
>> +			return -ENOMEM;
>
> and that is just so wrong - did you even try to test
> the 'buffer too small' code path?
>
> 	David
>

Do you means the check is unnecessary?

Yang
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
>
> .
>

