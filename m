Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4D1F4C08
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 06:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgFJEPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 00:15:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgFJEPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 00:15:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05A40rR2031382;
        Wed, 10 Jun 2020 00:15:29 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ja3a7u45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 00:15:29 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05A4BBCB006418;
        Wed, 10 Jun 2020 04:15:29 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 31hw1bjtvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 04:15:29 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05A4FQMa8127182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 04:15:26 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEDB9BE056;
        Wed, 10 Jun 2020 04:15:27 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22285BE04F;
        Wed, 10 Jun 2020 04:15:26 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.67.12])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Jun 2020 04:15:25 +0000 (GMT)
References: <20200609105731.14032-1-sathnaga@linux.vnet.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ram Pai <linuxram@us.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries/svm: Remove unwanted check for shared_lppaca_size
In-reply-to: <20200609105731.14032-1-sathnaga@linux.vnet.ibm.com>
Date:   Wed, 10 Jun 2020 01:15:21 -0300
Message-ID: <873673eeue.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_14:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 cotscore=-2147483648
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Satheesh Rajendran <sathnaga@linux.vnet.ibm.com> writes:

> Early secure guest boot hits the below crash while booting with
> vcpus numbers aligned with page boundary for PAGE size of 64k
> and LPPACA size of 1k i.e 64, 128 etc, due to the BUG_ON assert
> for shared_lppaca_total_size equal to shared_lppaca_size,
>
>  [    0.000000] Partition configured for 64 cpus.
>  [    0.000000] CPU maps initialized for 1 thread per core
>  [    0.000000] ------------[ cut here ]------------
>  [    0.000000] kernel BUG at arch/powerpc/kernel/paca.c:89!
>  [    0.000000] Oops: Exception in kernel mode, sig: 5 [#1]
>  [    0.000000] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>
> which is not necessary, let's remove it.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Ram Pai <linuxram@us.ibm.com>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Cc: Laurent Dufour <ldufour@linux.ibm.com>
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/paca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for fixing this bug! I would only add:

Fixes: bd104e6db6f0 ("powerpc/pseries/svm: Use shared memory for LPPACA structures")

In any case:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
