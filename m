Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4D2C84F8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgK3NTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:19:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgK3NTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:19:39 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUD3f6B104113;
        Mon, 30 Nov 2020 08:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=58ao67nn4tnXiDeKz0ADd8aVHvL3E9mqByct7ab3mH4=;
 b=Tdcq8qI9gt2Ix7fqtD3P06n6qULHNtFSokjArw5pXAO0VQ36IBLZbuIKpqj6Gk2BmSzQ
 32ez35GW9MX7fhCM1AjBaVGe80jjeIHPjK8hfcOlZ3YcO8DJ9RtE1ggbv/dzWiSj28dh
 mogmj3NEL/rDEB7qQquFG1OhIV/ql6v9dgE9Z5PEibv4F0z3/e/xLo9y31HZS2AyYHav
 st5v2J1rkmaW6g6CO2odtdjpmXdXibas2CTw+q6YXksKzF8pXAFwIXSlGbXhjsayJ6Lv
 iphR74ZNAMiZqXe5sPpU5bPSDpuAL147hwrHycL3QvCUAqkps5f2sOA1nHMJloSvUYz1 cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355101rygp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 08:18:55 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AUD4UHm110993;
        Mon, 30 Nov 2020 08:18:55 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355101ryfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 08:18:55 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AUDHc2g016655;
        Mon, 30 Nov 2020 13:18:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 353e68222m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 13:18:52 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AUDIovh8258160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 13:18:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADE69A405B;
        Mon, 30 Nov 2020 13:18:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 647D2A4060;
        Mon, 30 Nov 2020 13:18:50 +0000 (GMT)
Received: from osiris (unknown [9.171.81.148])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Nov 2020 13:18:50 +0000 (GMT)
Date:   Mon, 30 Nov 2020 14:18:48 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     kbuild-all@lists.01.org, svens@linux.ibm.com,
        clang-built-linux@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] include/getcpu.h: Fixed kernel test robot
 warning
Message-ID: <20201130131848.GA11190@osiris>
References: <1606578117-2895-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606578117-2895-1-git-send-email-jrdr.linux@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_03:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 09:11:57PM +0530, Souptick Joarder wrote:
> Kernel test robot generates below warning ->
> 
> >> arch/s390/kernel/vdso64/getcpu.c:8:5: warning: no previous prototype
> >> for function '__s390_vdso_getcpu' [-Wmissing-prototypes]
>    int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct
> getcpu_cache *unused)
>        ^
>    arch/s390/kernel/vdso64/getcpu.c:8:1: note: declare 'static' if the
> function is not intended to be used outside of this translation unit
>    int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct
> getcpu_cache *unused)
>    ^
>    static
>    1 warning generated.
> 
> vim +/__s390_vdso_getcpu +8 arch/s390/kernel/vdso64/getcpu.c
> 
>      7
>    > 8  int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct
>    > getcpu_cache *unused)
> 
> It is fixed by adding a prototype.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  include/linux/getcpu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/getcpu.h b/include/linux/getcpu.h
> index c304dcd..43c9208 100644
> --- a/include/linux/getcpu.h
> +++ b/include/linux/getcpu.h
> @@ -16,4 +16,5 @@ struct getcpu_cache {
>  	unsigned long blob[128 / sizeof(long)];
>  };
>  
> +int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused);

Sorry, no. We won't add s390 specific prototypes to common code header
files. Anyway, I solved this differently and the "fix" should be in
linux-next soon.
