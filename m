Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3A7234345
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbgGaJ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 05:29:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732168AbgGaJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:29:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V92i4g129877;
        Fri, 31 Jul 2020 05:29:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32md5bdnmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 05:29:10 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06V9CM0f156530;
        Fri, 31 Jul 2020 05:29:09 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32md5bdnkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 05:29:09 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06V9Kru6007361;
        Fri, 31 Jul 2020 09:29:07 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 32gcq0vc0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 09:29:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06V9T4ta58130526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 09:29:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4AFAA4040;
        Fri, 31 Jul 2020 09:29:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 768DBA404D;
        Fri, 31 Jul 2020 09:29:02 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 31 Jul 2020 09:29:02 +0000 (GMT)
Date:   Fri, 31 Jul 2020 14:59:01 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v4 06/10] powerpc/smp: Generalize 2nd sched domain
Message-ID: <20200731092901.GH14603@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com>
 <20200727053230.19753-7-srikar@linux.vnet.ibm.com>
 <875za45dr2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <875za45dr2.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_02:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Ellerman <mpe@ellerman.id.au> [2020-07-31 17:45:37]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > Currently "CACHE" domain happens to be the 2nd sched domain as per
> > powerpc_topology. This domain will collapse if cpumask of l2-cache is
> > same as SMT domain. However we could generalize this domain such that it
> > could mean either be a "CACHE" domain or a "BIGCORE" domain.
> >
> > While setting up the "CACHE" domain, check if shared_cache is already
> > set.
> 
> PeterZ asked for some overview of what you're doing and why, you
> responded to his mail, but I was expecting to see that text incorporated
> here somewhere.
> 

Okay, do you want that as part of the code or documentation dir or the
changelog?

> He also asked for some comments, which I would also like to see.
> 
> 
> I'm also not clear why we want to rename it to "bigcore", that's not a
> commonly understood term, I don't think it's clear to new readers what
> it means.
> 
> Leaving it as the shared cache domain, and having a comment mentioning
> that "bigcores" share a cache, would be clearer I think.
> 

Today, Shared cache is equal to Big Core. However in not too distant future,
Shared cache domain and Big Core may not be the same. For example lets
assume that L2 cache were to Shrink per small core with the firmware
exposing the core as a bigcore. Then with the current design, we have a SMT
== SHARED CACHE, and a DIE. We would not have any domain at the publicised 8
thread level. Keeping the Bigcore as a domain and mapping the shared
cache, (I am resetting the domain name as CACHE if BIGCORE==SHARED_CACHE),
helps us in this scenario.

> cheers
> 

-- 
Thanks and Regards
Srikar Dronamraju
