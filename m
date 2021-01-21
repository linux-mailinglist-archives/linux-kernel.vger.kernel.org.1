Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE16E2FE12F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbhAUEyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:54:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbhAUExs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:53:48 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10L4WqI4089328;
        Wed, 20 Jan 2021 23:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RVXB0HxJECvAqVkWEAt8xv6dH03+cy0zvVouo6IAUJs=;
 b=c28SGI/eM2CKXA5phv9gVD4Y+aYTXcoXGyaLK0mzPi1Hj5OP8p2JSPKIpiQcJQ445n1G
 GE/WANgvD4811V5k+Kk+kPb1CLJl3RzllUio8xrLoMjB3Z5W5n+Dth9ZlaqzmNLnNr6G
 /jm90Xhrd3tQWR9+LbAnr9id7xcsY0gA1AO1lU4pdkQOTWbTTfH4rzrMvHINV3J+lc3n
 XPF5cP6jrXDu+4jyIS48DnKCEY2EBWJo0El5DCPF+dEwPoBZljZQyki55b4wcjPgHjtv
 oK7k/R4LR1LvrDRTV4YIoRlBiHgmyqJSrBYG/FueZTSS0/+aUacGhIh3TNBtwF3E9ohk kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3672mc8dfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 23:52:44 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10L4X2M4090390;
        Wed, 20 Jan 2021 23:52:44 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3672mc8dfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 23:52:43 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10L4iWTK024476;
        Thu, 21 Jan 2021 04:52:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3668p80nt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 04:52:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10L4qcIH42008972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 04:52:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C326F42041;
        Thu, 21 Jan 2021 04:52:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7D184203F;
        Thu, 21 Jan 2021 04:52:36 +0000 (GMT)
Received: from JARVIS2.in.ibm.com (unknown [9.85.120.163])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Jan 2021 04:52:36 +0000 (GMT)
Subject: Re: [PATCH] objtool: Don't fail the kernel build on fatal errors
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org
References: <9ec7a9531e99f461e02adc18a4124c921c0ab777.1610664286.git.jpoimboe@redhat.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <545be952-908a-f125-ebb0-d96ed1e25cd5@linux.vnet.ibm.com>
Date:   Thu, 21 Jan 2021 10:22:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9ec7a9531e99f461e02adc18a4124c921c0ab777.1610664286.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-21_02:2021-01-20,2021-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/21 4:15 AM, Josh Poimboeuf wrote:
> This is basically a revert of commit 644592d32837 ("objtool: Fail the
> kernel build on fatal errors").
> 
> That change turned out to be more trouble than it's worth.  Failing the
> build is an extreme measure which sometimes gets too much attention and
> blocks CI build testing.
> 
> These fatal-type warnings aren't yet as rare as we'd hope, due to the
> ever-increasing matrix of supported toolchains/plugins and their
> fast-changing nature as of late.
> 
> Also, there are more people (and bots) looking for objtool warnings than
> ever before, so such warnings not likely to be ignored for long.
> 
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Kamalesh
