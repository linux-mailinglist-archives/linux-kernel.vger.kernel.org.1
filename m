Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FAC26C8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgIPTBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:01:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727558AbgIPRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:49:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GC4jJf100414;
        Wed, 16 Sep 2020 08:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=04a4Bp9rWfftQ3MOB4re166le6yiuSiKbirJ2RuDRzk=;
 b=nCobPw28mbbUI0cjchYc2LRtLsgZgdo5aOgJca3TGCXVa8WPl15uLeCxgNL2u/tUnLxf
 guCcjZYZUQX1ZJIQ076yMasodN6etInilikTjDj2OdTk3Rpt3Dcqora2ht7vO8NeZHEo
 r5/IjmkYa8xOpcihRBfMU/5xr3kRzzq8mIIOKJpncpPtzLnhaRbDaeWMDYDTFPoAI2Gl
 dmnfMEczKI6bgO2MooDNzHHPHy+kZBCzM2ZgmMF5lNQws25biYc4FjTrxTEXWBaetdtV
 o6BpP8iYxMAQuSQWnTAB2HA3LhSbSgK/RI4dBmshKIRmuVhsxjcvVDCTHpiQQtOJoKeP KA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33kct32y7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 08:20:39 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GCHgio019153;
        Wed, 16 Sep 2020 12:20:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 33k9ge8fq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 12:20:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08GCKYJe18153804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 12:20:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52D9711C05C;
        Wed, 16 Sep 2020 12:20:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16A1E11C04A;
        Wed, 16 Sep 2020 12:20:34 +0000 (GMT)
Received: from osiris (unknown [9.171.80.23])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Sep 2020 12:20:34 +0000 (GMT)
Date:   Wed, 16 Sep 2020 14:20:32 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] s390/diag: convert to use DEFINE_SEQ_ATTRIBUTE
 macro
Message-ID: <20200916122032.GA7076@osiris>
References: <20200916025029.3992939-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916025029.3992939-1-liushixin2@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_06:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=1 mlxscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009160087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:50:29AM +0800, Liu Shixin wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  arch/s390/kernel/diag.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Applied, thanks.
