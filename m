Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5BD2FFBD4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 05:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbhAVEiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 23:38:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbhAVEiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 23:38:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10M4V5wp152474;
        Thu, 21 Jan 2021 23:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vkX/AsSloHT96juAe9Yya0blAn3yMSuqmehDZQklXrg=;
 b=N/68MV7oWLGpiFjW4KTzhq7E0CtW+jHErzGi/w7opYvuwQC28pZDVNGaCPAFI6uMlQP2
 +o6rPlFwK0J2W/Y4ofh/tB/4t6m8IG1CZi8x2Ex/w1zq0LODDirewdZGjHy+DYK4bu/i
 Bs8t73LhRbC50AvDTG2W2xC8AKzOGwgnvi10XLjpt001PGE0FzifdrgCLxYDDQ2sSNXX
 toiL2OnYAsdTQKre67aNmtdTewRckwqS6dliylasUL3inNezqmXJ2T7V1CKiK3jliNNs
 pwms8X6B2ljH6IGadewMU/No6v5dDdjiBPV2fdAQklcF0lZC5c8E2e+2dEjc2W5WmOOw Kw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 367pcm9svb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 23:37:40 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10M4Wvn7003581;
        Fri, 22 Jan 2021 04:37:40 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 367k0shx5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 04:37:40 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10M4bdVL37159296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 04:37:39 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69444AC05B;
        Fri, 22 Jan 2021 04:37:39 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13BBBAC059;
        Fri, 22 Jan 2021 04:37:36 +0000 (GMT)
Received: from manicouagan.localdomain.com (unknown [9.85.140.199])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jan 2021 04:37:35 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, guro@fb.com, iamjoonsoo.kim@lge.com,
        Ram Pai <linuxram@us.ibm.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        mhocko@kernel.org, riel@surriel.com,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] memblock: do not start bottom-up allocations with kernel_end
Date:   Fri, 22 Jan 2021 01:37:14 -0300
Message-Id: <20210122043714.266075-1-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201220064959.GB392325@kernel.org>
References: <20201220064959.GB392325@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_02:2021-01-21,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=952 spamscore=0 clxscore=1011 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:

> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

I've seen a couple of spurious triggers of the WARN_ONCE() removed by this
patch. This happens on some ppc64le bare metal (powernv) server machines with
CONFIG_SWIOTLB=y and crashkernel=4G, as described in a candidate patch I posted
to solve this issue in a different way:

https://lore.kernel.org/linuxppc-dev/20201218062103.76102-1-bauerman@linux.ibm.com/

Since this patch solves that problem, is it possible to include it in the next
feasible v5.11-rcX, with the following tag?

Fixes: 8fabc623238e ("powerpc: Ensure that swiotlb buffer is allocated from low memory")

This is because reverting the commit above also solves the problem on the
machines where I've seen this issue.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
