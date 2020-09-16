Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD4826C5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIPRQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:16:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgIPRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:10:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GB3vsU117647;
        Wed, 16 Sep 2020 08:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zAVBQ++6d5ZC0uw5q6xbSv5Mv4NHicB2IH95EfBvfho=;
 b=rsSbWp8fjOTtLeU2Tt+2Wxap6g9m1gAyIfdb7B0z9+DqAIzGkNR7b5ZoahUqiu7Ux9FR
 pTPchQiE0OeIXmPI1Ih6D/iQTUjhj+9pSRTn+W09KNozDRV3JLsE44rOALt7791qEW7j
 B7YWMoCv5g6AdvtdJXw6+KxJ2P2vwchT48u+S85Z79W1isg0Os4dG7hQt9JHyh2nEc8D
 OmKzo12QfkxzrJtd23kDCLAKE15hoxP6UJB8dbb+a5BK3kWh1ScrS2pMe/5Bi1Os7jz/
 yjkbJsNdrIrgBXSp9zLYI3SafGmL/q7GPMjZVnxi431FyqKPWgRQVqLWKKFul4Yrt16I kA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33kfv65etq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 08:20:53 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GCHhcf000828;
        Wed, 16 Sep 2020 12:20:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 33k65v0asx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 12:20:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08GCJD8E29032952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 12:19:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B617CAE053;
        Wed, 16 Sep 2020 12:20:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67B7CAE051;
        Wed, 16 Sep 2020 12:20:47 +0000 (GMT)
Received: from osiris (unknown [9.171.80.23])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Sep 2020 12:20:47 +0000 (GMT)
Date:   Wed, 16 Sep 2020 14:20:46 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] s390/ap: remove unnecessary spin_lock_init()
Message-ID: <20200916122046.GB7076@osiris>
References: <20200916062130.190910-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916062130.190910-1-miaoqinglang@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_06:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=1
 clxscore=1011 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 02:21:30PM +0800, Qinglang Miao wrote:
> The spinlock ap_poll_timer_lock is initialized statically. It is
> unnecessary to initialize by spin_lock_init().
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
