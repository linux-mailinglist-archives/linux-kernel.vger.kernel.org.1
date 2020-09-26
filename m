Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879BA2798F0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgIZMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 08:47:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgIZMrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 08:47:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08QCQ7EW138181;
        Sat, 26 Sep 2020 08:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=8LdtzD9z70sMUdf7Q0gBMl1ujJha7UtbNjFGaFAi+GM=;
 b=Z18nZYBvTnX3SVBoCKePaE1A3DguY5Acl46pyRn7CyXu+qlx9nZZYikwmYBbpaUBe+gM
 lMKaJHOVupVdndd0ivHlruUnRrX0b1Ywj/KyRwo+oeDXMWfRNVZz/Dfv95Kez+FwtTc5
 +Be5LfaeZxIw60sFw7U42vUkVt5cxb6E7psFIBLYbOtn8g4aG4gN3t8sYBigNFdD9fSL
 pjuhTkYNy31gSzWLEcBln85GVBY8t9FEOyfz/MowaFkDI44QoncI4AgpF/WCqkFIdiYS
 8mhn2CIP6UrZetjLcg8mhG6JWF9FTWgRzLniEY2ny6InHEZeqCDb9ip89zPtKKWBYTOH uA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33t5n709ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Sep 2020 08:46:58 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08QChDcP023531;
        Sat, 26 Sep 2020 12:46:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 33sw9885xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Sep 2020 12:46:55 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08QCkrGl23855388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Sep 2020 12:46:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 072F911C050;
        Sat, 26 Sep 2020 12:46:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A50511C04A;
        Sat, 26 Sep 2020 12:46:52 +0000 (GMT)
Received: from localhost (unknown [9.145.18.16])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 26 Sep 2020 12:46:52 +0000 (GMT)
Date:   Sat, 26 Sep 2020 14:46:50 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] s390/3215: simplify the return expression of
 tty3215_open()
Message-ID: <your-ad-here.call-01601124410-ext-9995@work.hours>
References: <20200921131101.93037-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921131101.93037-1-miaoqinglang@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-26_10:2020-09-24,2020-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=1 bulkscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009260111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:11:01PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/s390/char/con3215.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index 92757f9bd..d8acabbb1 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -978,7 +978,6 @@ static int tty3215_install(struct tty_driver *driver, struct tty_struct *tty)
>  static int tty3215_open(struct tty_struct *tty, struct file * filp)
>  {
>  	struct raw3215_info *raw = tty->driver_data;
> -	int retval;
>  
>  	tty_port_tty_set(&raw->port, tty);
>  
> @@ -986,11 +985,7 @@ static int tty3215_open(struct tty_struct *tty, struct file * filp)
>  	/*
>  	 * Start up 3215 device
>  	 */
> -	retval = raw3215_startup(raw);
> -	if (retval)
> -		return retval;
> -
> -	return 0;
> +	return raw3215_startup(raw);
>  }

Applied, thank you.
