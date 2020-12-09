Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB442D483B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgLIRr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:47:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55512 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLIRr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:47:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9HjMPG156339;
        Wed, 9 Dec 2020 17:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0KsIGX1ORHzxyvZHspVuYUfgAjIts9odHQEERpyqU/s=;
 b=j1HAxznXNnMAnDFce4sgM04MGFUDjF0jU+zzwdEVSKBPiTxsI/EcRM4Xm5fYCeTgws/R
 wPicFPPIbgYalwGgq43LlYh2jkV1YX20CroGoTGJaRuMsTdJK1YDzxOGaVo8acOwbtrh
 /3UiH623w7ZLzmGfhnSVqFWy7anrZOzoETkGKIJFguPtwXV6/Z9vPRIKzJX0ZIc5tvOc
 aHvaa7tCQ7TcC7OKqd68BEa46KQxGb+Q51ITc1PzghhMhl/U0IYsBJwXay7MAuKN5Foz
 vi+e21kip3h0g0Qg8ehn5xqmaPlWyupXQBpyPoaU5zs0YPFMEfKaLlnq7cXOj4bUR90X aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35825m9ggh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 17:46:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9HkYqJ064639;
        Wed, 9 Dec 2020 17:46:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 358m40krm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 17:46:35 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9HkNxQ028711;
        Wed, 9 Dec 2020 17:46:24 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 09:46:23 -0800
Date:   Wed, 9 Dec 2020 20:46:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     shaojie.dong@isrc.iscas.ac.cn
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: check register_netdev() return value
Message-ID: <20201209174615.GI2767@kadam>
References: <20201209150124.23446-1-shaojie.dong@isrc.iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209150124.23446-1-shaojie.dong@isrc.iscas.ac.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=67 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=67 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:01:24PM +0800, shaojie.dong@isrc.iscas.ac.cn wrote:
> From: "shaojie.dong" <shaojie.dong@isrc.iscas.ac.cn>
> 
> Function register_netdev() can fail, so we should check it's return value
> 
> Signed-off-by: shaojie.dong <shaojie.dong@isrc.iscas.ac.cn>
> ---
>  drivers/staging/rtl8712/hal_init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
> index 715f1fe8b..38a3e3d44 100644
> --- a/drivers/staging/rtl8712/hal_init.c
> +++ b/drivers/staging/rtl8712/hal_init.c
> @@ -45,7 +45,10 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
>  	}
>  	adapter->fw = firmware;
>  	/* firmware available - start netdev */
> -	register_netdev(adapter->pnetdev);
> +	if (register_netdev(adapter->pnetdev) != 0) {
> +		netdev_err(adapter->pnetdev, "register_netdev() failed\n");
> +		free_netdev(adapter->pnetdev);
> +	}

This function should not be calling register_netdev().  What does that
have to do with firmware?  It should also not free_netdev() because
that will just lead to a use after free in the caller.

regards,
dan carpenter

>  	complete(&adapter->rtl8712_fw_ready);
>  }
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
