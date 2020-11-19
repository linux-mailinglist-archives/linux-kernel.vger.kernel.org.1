Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0E2B923D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgKSMLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:11:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726860AbgKSMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:11:48 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJC2NJ5086457;
        Thu, 19 Nov 2020 07:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iyU21aQmMQey/jdmhEXsxXVUZJgvfWQLOibvrBCl8Uw=;
 b=Z6kP2hpZznJq0TBB9Y6027Q3ud/P48N3M6YKY8QPU36Ux1tQJO6QdUnDax49rj98wN0l
 omFD+yfcpRoWlCoo4+6h88qdqOWXls9zKAmkFFc+i6FO0bZZah9x/zVcHixVS6oeBguZ
 O9mIZ8Vpw2Iv5vRcvY9EF1jJ7Qs3aHDBhBp1gCnC1aTxHI1ftnyiySmTb1Wpf/UB1969
 MOwkUzVpX4qFQxH4lWfOgtY55b6eJBPAw8aSn595L+5olzsH/JdGlRWX2GmxkV5NGFNF
 LZTmbIn+3XWH6GhTUYyjm0zItIuzbkcckXkLWdhHjaImZ6vPrXOqQaWYvsG6JNTLbGOm mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34wg5s5n8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 07:11:46 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AJC2bV3087715;
        Thu, 19 Nov 2020 07:11:46 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34wg5s5n7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 07:11:46 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJCBV4C004320;
        Thu, 19 Nov 2020 12:11:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 34t6v82pnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 12:11:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJCBgpP9830928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 12:11:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84CB7A405C;
        Thu, 19 Nov 2020 12:11:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FBEFA4054;
        Thu, 19 Nov 2020 12:11:42 +0000 (GMT)
Received: from [9.145.59.141] (unknown [9.145.59.141])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Nov 2020 12:11:42 +0000 (GMT)
Subject: Re: [PATCH] gcov: fix kernel-doc markup issue
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <1605252352-63983-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <13e07309-45dc-af6f-7e71-b9cc11a28b11@linux.ibm.com>
Date:   Thu, 19 Nov 2020 13:11:42 +0100
MIME-Version: 1.0
In-Reply-To: <1605252352-63983-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_08:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011190087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.2020 08:25, Alex Shi wrote:
> Fix the following kernel-doc issue in gcov:
> kernel/gcov/gcc_4_7.c:238: warning: Function parameter or member 'dst'
> not described in 'gcov_info_add'
> kernel/gcov/gcc_4_7.c:238: warning: Function parameter or member 'src'
> not described in 'gcov_info_add'
> kernel/gcov/gcc_4_7.c:238: warning: Excess function parameter 'dest'
> description in 'gcov_info_add'
> kernel/gcov/gcc_4_7.c:238: warning: Excess function parameter 'source'
> description in 'gcov_info_add'
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org

Looks good - thanks for the fix!

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Andrew, could you add this patch via your tree?


Regards,
  Peter

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
