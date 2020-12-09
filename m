Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE0B2D3D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgLIIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:40:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgLIIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:40:21 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B98WpUF077141;
        Wed, 9 Dec 2020 03:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Zs/rcTRYxg3j8byrlx8jtSxDLbD0ZN+CN0RAAXUUh4c=;
 b=C6FvaFhvJWMOYthpjnbV9gepKZQKhinBXLHf1QcV/bbZhN/Jq0A61zY21wJFfhVlkzMp
 UeinhsPJiKii8WcKpRit2dlr/0SYlq88azQk03h9NT4WUvmSvjK0p2pvBSXNbtIQ7gvh
 2ECmBbH1XMxDgCgY5t9tiC8VYXMJ12/pw7w3eTHcdvLjt2zcgScyD69GDIwCD9OT5b+S
 IwEv2zeEjRIFWHpT9M6GH4PLwE6Xax5vW/91qO7ZfUaGoWAaXVCLiVAKiRUGXnE4a82i
 lkLy26VvDt6IuF6vlwHFFs/0Rj0bMfGbn1V+JusU/AS4Lo+FHqA9l7VwX8WkSB3rqU1Y ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35afek9x3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 03:39:29 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B98Wveq077592;
        Wed, 9 Dec 2020 03:39:29 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35afek9x2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 03:39:28 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B98Y8cE022565;
        Wed, 9 Dec 2020 08:39:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3581u84cmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 08:39:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B98dOdi24576374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Dec 2020 08:39:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4470EA4051;
        Wed,  9 Dec 2020 08:39:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 427EBA4057;
        Wed,  9 Dec 2020 08:39:22 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  9 Dec 2020 08:39:22 +0000 (GMT)
Date:   Wed, 9 Dec 2020 14:09:21 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc/cacheinfo: Print correct cache-sibling
 map/list for L2 cache
Message-ID: <20201209083921.GL528281@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1607057327-29822-1-git-send-email-ego@linux.vnet.ibm.com>
 <1607057327-29822-4-git-send-email-ego@linux.vnet.ibm.com>
 <20201207131138.GJ528281@linux.vnet.ibm.com>
 <20201208175647.GC14206@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20201208175647.GC14206@in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_07:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=1 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gautham R Shenoy <ego@linux.vnet.ibm.com> [2020-12-08 23:26:47]:

> > The drawback of this is even if cpus 0,2,4,6 are released L1 cache will not
> > be released. Is this as expected?
> 
> cacheinfo populates the cache->shared_cpu_map on the basis of which
> CPUs share the common device-tree node for a particular cache.  There
> is one l1-cache object in the device-tree for a CPU node corresponding
> to a big-core. That the L1 is further split between the threads of the
> core is shown using ibm,thread-groups.
> 

Yes.

> The ideal thing would be to add a "group_leader" field to "struct
> cache" so that we can create separate cache objects , one per thread
> group. I will take a stab at this in the v2.
> 

I am not saying this needs to be done immediately. We could add a TODO and
get it done later. Your patch is not making it worse. Its just that there is
still something more left to be done.

-- 
Thanks and Regards
Srikar Dronamraju
