Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B072DA966
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgLOIo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:44:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgLOIoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:44:46 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BF8XUQc180122;
        Tue, 15 Dec 2020 03:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=3eizvgFfLu8kHBNlSsAuKsp1GTZViZsgYbZfkqUgLBs=;
 b=oAu4Xz/ASBg+tn05SYsqFJdOnHNkGwR9lkzpbyqPgZEFH4jtZulpPQVpui2hG4JrcCED
 a7wYOxYCpv/I73dWCNN84fuksmZkHceXZRseXa5Dhrp9BvD4Q9VRelfleVFdCUnnAbue
 iSgQzoFI1VOWSyBPuBOgrL24PAFyDBlpzej5AeQtVbpB7xCX/d9CRlhqmwPspEAO+oKZ
 wb/PMQ2STpE00oxbsI2TW6YTb/dENEOnyCOSQFEODKBjOiRx0AGVelQ+2uWZeZ7lgush
 c9ObUhQjOL+27bAEy/Vz0EfDtVpRqhhyzZmv28EHlPykAn9PKCFQUl2UKgppLd/jg2Hn YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35en9f7e3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 03:43:51 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BF8XgYP180938;
        Tue, 15 Dec 2020 03:43:50 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35en9f7e2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 03:43:50 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BF8gPKL009216;
        Tue, 15 Dec 2020 08:43:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 35cng89jfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 08:43:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BF8hjTs27918652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 08:43:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CC4211C050;
        Tue, 15 Dec 2020 08:43:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 300F611C066;
        Tue, 15 Dec 2020 08:43:43 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 15 Dec 2020 08:43:43 +0000 (GMT)
Date:   Tue, 15 Dec 2020 14:13:42 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] powerpc/smp: Add support detecting thread-groups
 sharing L2 cache
Message-ID: <20201215084342.GD1239129@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1607596739-32439-1-git-send-email-ego@linux.vnet.ibm.com>
 <1607596739-32439-5-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1607596739-32439-5-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_04:2020-12-11,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2020-12-10 16:08:58]:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On POWER systems, groups of threads within a core sharing the L2-cache
> can be indicated by the "ibm,thread-groups" property array with the
> identifier "2".
> 
> This patch adds support for detecting this, and when present, populate
> the populating the cpu_l2_cache_mask of every CPU to the core-siblings
> which share L2 with the CPU as specified in the by the
> "ibm,thread-groups" property array.
> 
> On a platform with the following "ibm,thread-group" configuration
> 		 00000001 00000002 00000004 00000000
> 		 00000002 00000004 00000006 00000001
> 		 00000003 00000005 00000007 00000002
> 		 00000002 00000004 00000000 00000002
> 		 00000004 00000006 00000001 00000003
> 		 00000005 00000007
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
