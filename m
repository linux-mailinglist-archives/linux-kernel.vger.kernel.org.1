Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A329DA48
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbgJ1XSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:18:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59548 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgJ1XSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:18:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SNF6HU055259;
        Wed, 28 Oct 2020 23:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=c6vIzTVSFavI3ABTKFqmn3JPPiEUFbOCxiMzvkPgJ2A=;
 b=KSUivPGDgFxkinEjVTmaPcGAWwAkCw0tkNb1zST+s/cwci7o5vnwb/Lkvnr5L35HHcqu
 kpurWnDC6MkiE9T9KtjRMWPnOwo+K/7Sl8Yo8YNMpLRUsVg5kgaYYGu8hOsATZN8YsVk
 TeiRcXQCOZv+hN8giQbp/7ncxClChhUHastW8y86sC3d7gtomnUwlfizKU/DuGyxiRkp
 O5xfo1H5hSjmdngARsWKWtDSMXDG6eQLh+z+sFAdj1TKtW+37uN55CgeH4BIZGKUpWgr
 LehCaz3QB9MXQ8tFXZIJnsM6wt2INKYun8JmItn0rxYsmBpIqmGnr0E9nEMiF8YSqcDD hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7m25av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 23:17:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SNG7jQ169880;
        Wed, 28 Oct 2020 23:17:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34cx5yw4e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 23:17:56 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09SNHtfj022000;
        Wed, 28 Oct 2020 23:17:55 GMT
Received: from [10.74.108.119] (/10.74.108.119)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 16:17:54 -0700
Subject: Re: [PATCH] soc: ti: ti_sci_pm_domains: check for proper args count
 in xlate
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20201028141700.10510-1-t-kristo@ti.com>
 <20201028214336.qfwbs46j5x6cpjhr@award>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <80b42f3e-d333-3e01-478d-a46b8660db1e@oracle.com>
Date:   Wed, 28 Oct 2020 16:17:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201028214336.qfwbs46j5x6cpjhr@award>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 2:43 PM, Nishanth Menon wrote:
> On 16:17-20201028, Tero Kristo wrote:
>> K2G devices still only use single parameter for power-domains property,
>> so check for this properly in the driver. Without this, every peripheral
>> fails to probe resulting in boot failure.
>>
>> Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/soc/ti/ti_sci_pm_domains.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
>> index af2126d2b2ff..8afb3f45d263 100644
>> --- a/drivers/soc/ti/ti_sci_pm_domains.c
>> +++ b/drivers/soc/ti/ti_sci_pm_domains.c
>> @@ -91,7 +91,7 @@ static struct generic_pm_domain *ti_sci_pd_xlate(
>>   	struct genpd_onecell_data *genpd_data = data;
>>   	unsigned int idx = genpdspec->args[0];
>>   
>> -	if (genpdspec->args_count < 2)
>> +	if (genpdspec->args_count != 1 && genpdspec->args_count != 2)
>>   		return ERR_PTR(-EINVAL);
>>   
>>   	if (idx >= genpd_data->num_domains) {
> 
> 
> Thanks Tero.
> 
> Acked-by: Nishanth Menon <nm@ti.com>
> 
> Santosh: can we queue this one for 5.10? - I am trying to track and get
> all platforms booting and functional in 5.10
> 
Sure. Can you re-post with my ack to soc@kernel.org and copy me ?
Will try to get this one applied.

Regards,
Santosh
