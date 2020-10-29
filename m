Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBD929F618
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgJ2UVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:21:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57902 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2UVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:21:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TKEdMv080452;
        Thu, 29 Oct 2020 20:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JjDgkWBfLLog9pvza+5imZ+B0T6evJSkm3QpERsp9Cw=;
 b=C2GQgUIoO1E1XGvPnG3V4DwWg9BXUGB/xD1/p07856lKByC1cXU3RHGGympE4/16b11n
 nIRmcqbHGYwu6cDFTH8W3Z0fgNVuClbWONhpuffGutMCWNe3LgHvB605Lyfpyz0zzaNH
 H5SE/ZDTA+qhsB3U3lg9beA4SG9fzYVrDc5JA86lukoLKdkVogIg25zfFqNFJujUtvdl
 XTZFx3hQBJUa89+pAphW9LYyiBtsyOe26+8+pJlkMHk1fhEQT7RvSLGU3UT+CxfBfU46
 zwTYQ97tazMxnIRThNd4P8bREVQ+mvUqfMZi9O8aNgOVIXshJP6ncTVdtjAdaUQlVJBo Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34dgm4cfhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 20:21:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TKKBAh110105;
        Thu, 29 Oct 2020 20:21:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34cx60x19v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 20:21:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09TKLXpP004572;
        Thu, 29 Oct 2020 20:21:33 GMT
Received: from [192.168.86.24] (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 13:21:33 -0700
Subject: Re: [RESEND PATCH] soc: ti: ti_sci_pm_domains: check for proper args
 count in xlate
To:     soc@kernel.org
Cc:     Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ssantosh@kernel.org,
        nm@ti.com, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
References: <20201029093337.21170-1-t-kristo@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <5d3bb050-98db-5ec1-9f52-ad98b303749a@oracle.com>
Date:   Thu, 29 Oct 2020 13:21:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201029093337.21170-1-t-kristo@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=13 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=13 clxscore=1011 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, olof,

On 10/29/20 2:33 AM, Tero Kristo wrote:
> K2G devices still only use single parameter for power-domains property,
> so check for this properly in the driver. Without this, every peripheral
> fails to probe resulting in boot failure.
> 
> Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> ---
Can you please add this to your fixes queue ?
This fixes boot failures on K2Gdevices ?

>   drivers/soc/ti/ti_sci_pm_domains.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
> index af2126d2b2ff..8afb3f45d263 100644
> --- a/drivers/soc/ti/ti_sci_pm_domains.c
> +++ b/drivers/soc/ti/ti_sci_pm_domains.c
> @@ -91,7 +91,7 @@ static struct generic_pm_domain *ti_sci_pd_xlate(
>   	struct genpd_onecell_data *genpd_data = data;
>   	unsigned int idx = genpdspec->args[0];
>   
> -	if (genpdspec->args_count < 2)
> +	if (genpdspec->args_count != 1 && genpdspec->args_count != 2)
>   		return ERR_PTR(-EINVAL);
>   
>   	if (idx >= genpd_data->num_domains) {
> 
