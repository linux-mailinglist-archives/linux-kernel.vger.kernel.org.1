Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793A72B2C73
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 10:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgKNJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 04:42:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgKNJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 04:42:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AE9XKW7002246;
        Sat, 14 Nov 2020 04:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ELuHNsvddKFtvuksdaCYSoV4mY9hdvtR2HgD0M1zblc=;
 b=HKKKt5WfM1G8KDtPAUM2BABRVrmtzdVJzVSMuMQkmrXAdvezk//J0x4aIlKJyEAeYEEI
 zkNpb+Q4/jN+WYlvPEQN8vWBKfQT8l6jFZSmH19n0oiXRAhJUSX9LYWyD11s1/5LmAfP
 kzpxzHKRTixjyKjgU5dCj1eDgOE5dAKfNgZXw+WF1Qf9bYuFg/s3TK3E8eRVGIbeTbgY
 UjkOUAjXSxsOVq8Ef+jqXdzspJOiAwO3Jm/TdYP3jZuyqQxBCELsB3fRU5aTCofqBmyQ
 C+39BYPG9Tzt6A1eVPKQuoliF+Fn7UgXmq/G08xy4cWzXtc90SgxkGKZUe5TGD19xtPU JA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34tcn605r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Nov 2020 04:42:23 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AE9W1m6015637;
        Sat, 14 Nov 2020 09:42:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34t6gh07mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Nov 2020 09:42:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AE9gIwO4129494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Nov 2020 09:42:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99DC842042;
        Sat, 14 Nov 2020 09:42:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5090642041;
        Sat, 14 Nov 2020 09:42:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.51.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 14 Nov 2020 09:42:18 +0000 (GMT)
Subject: Re: [PATCH kernel v3] genirq/irqdomain: Add reference counting to
 IRQs
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <20201109094646.71565-1-aik@ozlabs.ru>
 <fac73255eabb43242528821888acf2cc@kernel.org>
 <98d06682-da53-c851-74a7-952bf958b793@ozlabs.ru>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <e552f6a9-8b82-f446-d67d-2f666870c766@linux.ibm.com>
Date:   Sat, 14 Nov 2020 10:42:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <98d06682-da53-c851-74a7-952bf958b793@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-14_04:2020-11-13,2020-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=764 lowpriorityscore=0
 clxscore=1011 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=48 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011140060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2020 04:37, Alexey Kardashevskiy wrote:

>> I'll try to go through this patch over the week-end (or more probably
>> early next week), and try to understand where our understandings
>> differ.
> 
> Great, thanks! Fred spotted a problem with irq_free_descs() not doing 
> kobject_put() anymore and this is a problem for sa1111.c and the likes 
> and I will go though these places anyway.

So there are callers out there which don't care about mapping the 
interrupt. Wouldn't it be easier to leave alone the kobject from the irq 
descriptor (my understanding is that it's there to handle the sysfs 
representation) and add a simple kref counter, just to handle the 
mapping part?

   Fred


