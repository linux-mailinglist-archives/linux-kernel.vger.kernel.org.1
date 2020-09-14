Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005EA268EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgINO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:58:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49732 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgINO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:58:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08EEoXKO028263;
        Mon, 14 Sep 2020 14:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4izGF0qUEAze0J2Yn20TGpCx+vMJvv4zEUUP027BbZY=;
 b=GnRiB+hoSzOHSWv6MCc2S+PeiDkwezOmtbeVHT2rOOtXslkHBLjd5YM9JM32X7sH/LRm
 Xxse3lr/s2LBf/e9hICgeXYYdjjtCTFKXDeHFY8bwXD+5T7Ua+00Lam2XauoCfuUSBpl
 Z+GJixSyoPUwi51NL6+WyDPEComcMn4iMu910rMQKrZZSlbJvZ9rKjKjm78xjtuudKh/
 A/aGSHy+ayY9YVVkcr7YLhJu9sC5HPLRHKHOpGHXCW9BYOF6rRoft8G0Y7Ioav/eYR5J
 h802e+rh2b0fcGiU//5WGN/9ylr7ahZG+xcDQm5YKjw/ilO1L7pklmFsvoHLB4tUxjLh Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33j91d8qnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 14:58:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08EEo8Br131762;
        Mon, 14 Sep 2020 14:58:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33h7wma4d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 14:58:03 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08EEw1fP005339;
        Mon, 14 Sep 2020 14:58:02 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Sep 2020 14:58:01 +0000
Date:   Mon, 14 Sep 2020 17:57:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sohom Datta <sohom.datta@learner.manipal.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [RESEND PATCH] staging: rtl8188eu: Fix else after return WARNING
 (checkpatch)
Message-ID: <20200914145755.GD4282@kadam>
References: <230f781dcaadfc797a016cc6036d63efe6542062.camel@learner.manipal.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230f781dcaadfc797a016cc6036d63efe6542062.camel@learner.manipal.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9743 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 12:19:50PM +0530, Sohom Datta wrote:
> >From 4c8c8f3ff7f4d711daea4ac3bb987fcecc7ef1ed Mon Sep 17 00:00:00 2001
> From: Sohom <sohom.datta@learner.manipal.edu>
> Date: Sat, 12 Sep 2020 18:04:56 +0530
> Subject: [RESEND PATCH] staging: rtl8188eu: Fix else after return WARNING
>  (checkpatch)
> 
> Fixed:
> WARNING: else is not generally useful after a break or return
> 1636: FILE: ./rtw_recv.c:1636:
> +           return false;
> +       else
> 
> Separated the return statement into a separate block since
> it doesn't seem to depend on the SN_LESS explicity being false.
> 
> Signed-off-by: Sohom <sohom.datta@learner.manipal.edu>
> ---
>  drivers/staging/rtl8188eu/core/rtw_recv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
> index 5fe7a0458dd2..5e81134ffb6d 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_recv.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
> @@ -1629,10 +1629,11 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl,
>  		hdr = list_entry(plist, struct recv_frame, list);
>  		pnextattrib = &hdr->attrib;
>  
> +		if (SN_EQUAL(pnextattrib->seq_num, pattrib->seq_num))
> +			return false;
> +
>  		if (SN_LESS(pnextattrib->seq_num, pattrib->seq_num))
>  			plist = plist->next;
> -		else if (SN_EQUAL(pnextattrib->seq_num, pattrib->seq_num))
> -			return false;
>  		else
>  			break;
>  	}

Checkpatch is just wrong here.  Ignore it when it's wrong.

regards,
dan carpenter

