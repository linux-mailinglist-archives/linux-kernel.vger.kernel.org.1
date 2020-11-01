Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F812A1F6A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgKAQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:06:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgKAQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:06:12 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A1G2rsS177322;
        Sun, 1 Nov 2020 11:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=/0YF/qY9dCDnt+uKhwz6GW3xvIKJ3yi/oQCwjRDJUO8=;
 b=UKRqaVuYwXCjh6umIteeZU9uYiyBzOLNCaegKlGQky97klh6RgBhhcI8CmrXmnLv1xQl
 FncyMGuVKQVSsp7ZHV0Oq34m1rxPENaAppc5cZPC6Ha1Y6B6AANqtl7Ja1IO5dy/K+Pw
 VidB+/ZgPcbmmz/w1Vz/gBcZ3pHonVIZqpyJsicnk5I8k9rxORrbo3nlNL78c43OjiZV
 Ip/6Z98w1tnZBbKZ4SBspRYgMBNrX3IaIhSFThCtgguq2B302XsaVfZfemZ2ZXwZoKbJ
 YdjGC+3/zfvqddwzcNJHVA2tJS7s7H3S1eaC8DZrvoAx8osEzuzzn3CuNM3LKyEi4muQ AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34h3jry0a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Nov 2020 11:06:04 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A1G2wQn177670;
        Sun, 1 Nov 2020 11:06:04 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34h3jry09a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Nov 2020 11:06:03 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A1G1OFo017802;
        Sun, 1 Nov 2020 16:05:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 34h01kgmhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Nov 2020 16:05:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A1G5uM48585818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 1 Nov 2020 16:05:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C33C52051;
        Sun,  1 Nov 2020 16:05:56 +0000 (GMT)
Received: from osiris (unknown [9.171.90.71])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3C1445204E;
        Sun,  1 Nov 2020 16:05:56 +0000 (GMT)
Date:   Sun, 1 Nov 2020 17:05:54 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Qian Cai <cai@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201101160554.GA9375@osiris>
References: <20201028182742.13773-1-cai@redhat.com>
 <20201031183725.GA9529@osiris>
 <1f0ef4b832c67dcec1bcc793407e62c58a97904e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f0ef4b832c67dcec1bcc793407e62c58a97904e.camel@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-01_05:2020-10-30,2020-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=984 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011010130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 07:38:52PM -0400, Qian Cai wrote:
> > > This is avoided by moving the call to rcu_cpu_starting up near the
> > > beginning of the smp_init_secondary() function. Note that the
> > > raw_smp_processor_id() is required in order to avoid calling into
> > > lockdep before RCU has declared the CPU to be watched for readers.
> > > 
> > > Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> > > Signed-off-by: Qian Cai <cai@redhat.com>
> > > ---
> > >  arch/s390/kernel/smp.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Could you provide the config you used? I'm wondering why I can't
> > reproduce this even though I have lot's of debug options enabled.
> https://cailca.coding.net/public/linux/mm/git/files/master/s390.config
> 
> Essentially, I believe it requires CONFIG_PROVE_RCU_LIST=y. Also, it occurs to
> me that this only starts to happen after the commit mentioned in the above link.

Yes, with that enabled I can reprocuce it. Thanks! It depends on
CONFIG_RCU_EXPERT. I can't image why I didn't had that enabled.. :)
