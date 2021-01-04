Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210F02E96F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhADOQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:16:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42642 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbhADOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:16:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104EFJR5184294;
        Mon, 4 Jan 2021 14:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LL6sOxcA0lvqQmDvi8qmBGRnTWkWpJGalyEnal3vYwg=;
 b=xBOsAq4GDo/LK0LYTFaA6d7tPCj4K6ALCVJzkmLUuoXmh6G7vX6/pOIBe3cz0YnSbzJV
 0o06GUuwJgFlT1IW0AVCCUJDBCKqtx4uXHoasczSV+PlnCFsQvME9nIp9H6WrI4QMJ1k
 w5ojVVLQanJb5xIMfEH/cc66STYVM4jGzysmf38op/hYpJa2/272r0l5vEqI1KEhTCOA
 SzmsI4nOabrwTOYxEyyz793RW+1I+jOsgFJebV1yXVW0+edscfGVMn7NS8YOQOpJR6Bb
 3+dNWldyP29iYYCdnPh+dsM74OrwavX619/8Pz/q2dGkpXHLVYBzrJMpTdN6i+T6345a 1w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35tg8qve66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 14:15:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104EAGl5087352;
        Mon, 4 Jan 2021 14:15:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 35uxnr6sxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 14:15:19 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 104EFG2V012808;
        Mon, 4 Jan 2021 14:15:16 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 14:15:16 +0000
Date:   Mon, 4 Jan 2021 17:14:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     nsaenzjulienne@suse.de, bcm-kernel-feedback-list@broadcom.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 -next] staging: vc04_services: use DEFINE_MUTEX() for
 mutex lock
Message-ID: <20210104141454.GR2809@kadam>
References: <20201224132528.31558-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224132528.31558-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 09:25:28PM +0800, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
> 
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

