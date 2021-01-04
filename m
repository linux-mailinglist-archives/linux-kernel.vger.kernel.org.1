Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B55C2E96B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbhADOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:04:24 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35642 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:04:23 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104DwfPs099438;
        Mon, 4 Jan 2021 14:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=I4WFnLYfTO/cuzQEHLd5owK4ghKtdgjCoWDrmD92TWs=;
 b=zX3Km9L5Gxf1wgCkhljZW/JPAdyG7TnO4i6p/2J8pvYMBWwWex5IXAKVw3g5vdgVV/iF
 5I9lDxQHCbEYlhrgY4pTpv3ObiGleLmLJfr78qyi46PEuxwSQHWjr1iB8rYHhM8Nsksn
 Of0l2yLl55Ri8UOOwm9UOQtXKofWoh/C6vOzdNr3B+LLH4ugs+YuQ/0iG3HftZRGjF2i
 oB3AMRDfUMdyHPTGPWiy0RYbnq3OKBzRKPAQVq28VKwWBnImW8kNNDQUtgeFPiYT5YBg
 1l5Ju2F4C8quyvyWkjMbfxfUeHfeG6vNGuuu9E9d4VrIS76KpdNt9Sj4uvOmytiDXFMg 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35tebamf36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 14:03:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104E0IW9057366;
        Mon, 4 Jan 2021 14:01:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35uxnr6dn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 14:01:25 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104E1Oqm023785;
        Mon, 4 Jan 2021 14:01:24 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 06:01:23 -0800
Date:   Mon, 4 Jan 2021 17:01:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     nsaenzjulienne@suse.de, bcm-kernel-feedback-list@broadcom.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: vc04_services: use DEFINE_MUTEX (and
 mutex_init() had been too late)
Message-ID: <20210104140110.GQ2809@kadam>
References: <20201223141129.32401-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223141129.32401-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:11:29PM +0800, Zheng Yongjun wrote:
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_connected.c        | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> index 79b75efa6868..864253866155 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> @@ -12,13 +12,12 @@ static   int                        g_connected;
>  static   int                        g_num_deferred_callbacks;
>  static   VCHIQ_CONNECTED_CALLBACK_T g_deferred_callback[MAX_CALLBACKS];
>  static   int                        g_once_init;
> -static   struct mutex               g_connected_mutex;
> +static   DEFINE_MUTEX(g_connected_mutex);
>  
>  /* Function to initialize our lock */
>  static void connected_init(void)
>  {
>  	if (!g_once_init) {
> -		mutex_init(&g_connected_mutex);
>  		g_once_init = 1;
>  	}

Delete the extra curly braces.

regards,
dan carpenter

