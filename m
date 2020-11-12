Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8872B0B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKLRuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:50:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47308 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKLRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:50:17 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACHhxkE131016;
        Thu, 12 Nov 2020 17:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Z2reEuCkpstqaBBNhX/2PTpH6NqHIAapVSGlkSl0flQ=;
 b=nmkeP4O/EvGBhXJy+2JDWqIn5K4gj4EXveDX+8SmHiGVpNUO+L3z3m1Q49AOnt5ZAc4w
 HGESyNGIupvu3Jth/Vc9HKfM3wVaHXIxgiUXvSWHzx/Fn/+8PuXfdwsCGnnx/+XkNiav
 Zs22psb7bAca/IdZs5F2XC6CjtyS5ZIqaPR3iI5BnZ3cjYUw963r9K2Ysecdbhb3fn9w
 RgvDluQiBn6ny3TzpvNwiTzAevPYkaVkMSdlGs12OZCeYpSYaTa9q6LH9FFgP9ydw6rL
 qwW+Leef1+on4EGqWBEQxvTAKQwesV/OHASl3obeH3Wro28/W+/X5Rz3JBRg3C5HZNQY Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34nh3b6ya5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 17:50:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACHj0q2010693;
        Thu, 12 Nov 2020 17:50:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34p5g3dpcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 17:50:08 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ACHo6CE031040;
        Thu, 12 Nov 2020 17:50:06 GMT
Received: from [10.74.105.253] (/10.74.105.253)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 09:50:05 -0800
Subject: Re: [PATCH 06/25] soc: ti: knav_qmss_queue: Remove set but unchecked
 variable 'ret'
To:     Lee Jones <lee.jones@linaro.org>, Tero Kristo <t-kristo@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>, tomi.valkeinen@ti.com,
        kishon@ti.com, dmurphy@ti.com, s-anna@ti.com
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-7-lee.jones@linaro.org>
 <20201112103130.GD1997862@dell> <30ad256b-07f0-f01e-ec4f-c12cf9dbe426@ti.com>
 <20201112132145.GI1997862@dell>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <28b506c0-df0d-c100-8d92-f3051f61cd98@oracle.com>
Date:   Thu, 12 Nov 2020 09:50:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201112132145.GI1997862@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 5:21 AM, Lee Jones wrote:
> On Thu, 12 Nov 2020, Tero Kristo wrote:
> 
>> On 12/11/2020 12:31, Lee Jones wrote:
>>> Cc:ing a few people I know.
>>>
>>> On Tue, 03 Nov 2020, Lee Jones wrote:
>>>
>>>> Fixes the following W=1 kernel build warning(s):
>>>>
>>>>    drivers/soc/ti/knav_qmss_queue.c: In function ‘knav_setup_queue_pools’:
>>>>    drivers/soc/ti/knav_qmss_queue.c:1310:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>>>
>>>> Cc: Santosh Shilimkar <ssantosh@kernel.org>
>>>> Cc: Sandeep Nair <sandeep_n@ti.com>
>>>> Cc: Cyril Chemparathy <cyril@ti.com>
>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>>> ---
>>>>    drivers/soc/ti/knav_qmss_queue.c | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> Any idea who will take these TI patches?
>>>
>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-arm-kernel/20201111052540.GH173948@builder.lan/__;!!GqivPVa7Brio!KEeMCT-GwmLNnDFCOqxnunXXiCrCpj3ZFXpiMzj55VmlOJ-FVhKmom-O7sq-CkL8s0sjAg$
>>>
>>
>> (Dropped a few inactive emails from delivery.)
>>
>> Santosh is the maintainer for the subsystem, so my vote would go for him.
> 
> Thanks for your prompt reply Tero.
> 
> It looks as though Santosh has been on Cc since the start.  He must
> just be busy.  I'll give him a little while longer before submitting a
> [RESEND].
> 
Go ahead and re-post. These seems to be trivial so will pick
it up.

Regards,
Santosh
