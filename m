Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423612DA962
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgLOIoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:44:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42678 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727290AbgLOIoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:44:00 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BF8WBqO001350;
        Tue, 15 Dec 2020 03:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=R0yQC24o3EUueMy/dKBJwOXgcvEJ+Y/+XaBKrFrUk0c=;
 b=iFdzJ2QBUMFXj6s91CG/UELZ9QfXG6sB+0B7SCryVBSL1nEotShYKWwz6O8JN+ETt4MW
 ocjRze4Sh1oH+qR6iLa3Qf6MFPQIKM1Wx62shEv5pJB6GyDTxScVFIee8JdM3Uw9g6Eo
 GxqhSJ3UO7VXxTVXRncBk6FrlBt35VIYcydNx/rohKMMn2uKu8w93tt0S9iQSY/NC4Sx
 r3qo2TrAySUkK7ucaG2KXed0KhmnWssoCSMwGTVY5okf/jng6hq6tPscoUuAl+8PhnaB
 5yfpbgVSOK1dThiAl+JLuPVn+UHjJ8/CGgfzR4fSwgDBMXgTQawfQuV+aa5nkrl5wKn5 pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35es0t1jfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 03:42:58 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BF8WBU8001382;
        Tue, 15 Dec 2020 03:42:57 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35es0t1je8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 03:42:57 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BF8gtlN025673;
        Tue, 15 Dec 2020 08:42:55 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 35cng89ju9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 08:42:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BF8grPM29098412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 08:42:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37B5F5205A;
        Tue, 15 Dec 2020 08:42:53 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 355B052050;
        Tue, 15 Dec 2020 08:42:51 +0000 (GMT)
Date:   Tue, 15 Dec 2020 14:12:50 +0530
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
Subject: Re: [PATCH v3 2/5] powerpc/smp: Rename cpu_l1_cache_map as
 thread_group_l1_cache_map
Message-ID: <20201215084250.GB1239129@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1607596739-32439-1-git-send-email-ego@linux.vnet.ibm.com>
 <1607596739-32439-3-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1607596739-32439-3-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_04:2020-12-11,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 adultscore=0 mlxlogscore=781 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2020-12-10 16:08:56]:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On platforms which have the "ibm,thread-groups" property, the per-cpu
> variable cpu_l1_cache_map keeps a track of which group of threads
> within the same core share the L1 cache, Instruction and Data flow.
> 
> This patch renames the variable to "thread_group_l1_cache_map" to make
> it consistent with a subsequent patch which will introduce
> thread_group_l2_cache_map.
> 
> This patch introduces no functional change.
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
-- 
Thanks and Regards
Srikar Dronamraju
