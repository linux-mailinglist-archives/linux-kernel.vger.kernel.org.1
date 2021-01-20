Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681642FD6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403957AbhATRSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:18:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391783AbhATRRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:17:54 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10KH2nCW173241;
        Wed, 20 Jan 2021 12:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2MjYTQAKg0XcBO/QYJ9eWIey23lQUMAlaNMBygShzeQ=;
 b=PCySfe32pH4LgMJecWe5JOM64akELCHpqhnbpn/SVRX5rrY9/Jx2wzCBUaK/xyEK4lZE
 HfXUuxU2eYpTP/B4daMW7BnZrKJIznzdleUjATimhSXw5Bzchedq73u6GKy2b9Ux5tbq
 gueq7qq4Rmmron/PzFKg+G52/uIHEvU9RUkK36au7yfAuvosv1Y47uc8fUkGzie7CZyB
 4aCvJU9M9gZg/nDETcKI4zJ7Vk2rijpRxmm+G3wUin0VVMTkTOkjeQ0C03/wlQ9Qd4Or
 QVDBUVZwmivcb4w7kHEbC4a8cVy7kaEioUncsa8gR4Jm4VbYvc817+Y1d/0Yud4A4nfa ow== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 366rbj0vn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 12:17:00 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10KHGPD5011286;
        Wed, 20 Jan 2021 17:17:00 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 3668ps7d22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 17:17:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10KHGx1U15860140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 17:16:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70D8A112067;
        Wed, 20 Jan 2021 17:16:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C453112064;
        Wed, 20 Jan 2021 17:16:58 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.65.196.188])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jan 2021 17:16:58 +0000 (GMT)
Subject: Re: [PATCH 1/3] tty: hvcs: Drop unnecessary if block
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
 <20210114175718.137483-2-u.kleine-koenig@pengutronix.de>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <ce62e2fb-d882-ab6b-1a81-2315ce9a2b64@linux.ibm.com>
Date:   Wed, 20 Jan 2021 09:16:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114175718.137483-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_10:2021-01-20,2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1011 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=961 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/21 9:57 AM, Uwe Kleine-König wrote:
> If hvcs_probe() succeeded dev_set_drvdata() is called with a non-NULL
> value, and if hvcs_probe() failed hvcs_remove() isn't called.
> 
> So there is no way dev_get_drvdata() can return NULL in hvcs_remove() and
> the check can just go away.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>

> ---
>  drivers/tty/hvc/hvcs.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index 509d1042825a..3e0461285c34 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -825,9 +825,6 @@ static int hvcs_remove(struct vio_dev *dev)
>  	unsigned long flags;
>  	struct tty_struct *tty;
> 
> -	if (!hvcsd)
> -		return -ENODEV;
> -
>  	/* By this time the vty-server won't be getting any more interrupts */
> 
>  	spin_lock_irqsave(&hvcsd->lock, flags);
> 

