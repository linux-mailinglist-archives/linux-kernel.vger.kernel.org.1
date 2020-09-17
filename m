Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC826DE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgIQObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:31:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727560AbgIQOaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:30:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HDKtbm185587;
        Thu, 17 Sep 2020 09:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lg/T0bUlY4lb0hy9zy/UrD8J01AIKFECWlffkInNKdc=;
 b=EvjzTy8QQFfJ2hlMfdq1ZOl/jPzrfE/bdzv0zOmZlHnA8PHzseo78Y+EYa6tCqVrDpxu
 W5/YC/lBe0/YD4mNtbTk7+GArjIhkvteOYVmAtHXhWB2tKaGDaCOLOlvKFlZDF/CGWII
 NVDcDE6mQw+t46MnGwsd5wwVYnCUHf6bnQHlSVKSGKAeYGx2cLiu9GStUC2ijOe7M5fU
 1aYK0iKAEjT/MLgA6SIZgrpe/RyaDdaJ1nvn4AnN6jflhKmPGwzFnCjfSTqQrwNP7D4T
 sj/8ol4plkegberzof46ay+PMTMVDX+c8gefWelH//kotmkQCfbISN6gamPmxqSpcyeY FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m8kr836w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 09:25:38 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HDMJ7Q194042;
        Thu, 17 Sep 2020 09:25:38 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m8kr8368-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 09:25:38 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HDMbmM008410;
        Thu, 17 Sep 2020 13:25:37 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 33k5v20xef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 13:25:37 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08HDPaaa30998818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 13:25:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EB96AE05F;
        Thu, 17 Sep 2020 13:25:36 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00D64AE064;
        Thu, 17 Sep 2020 13:25:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.95.89])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Sep 2020 13:25:32 +0000 (GMT)
Subject: Re: [PATCH v6 2/8] powerpc/watchpoint: Fix handling of vector
 instructions
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        christophe.leroy@c-s.fr
Cc:     mikey@neuling.org, jniethe5@gmail.com, pedromfc@linux.ibm.com,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        rogealve@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
 <20200902042945.129369-3-ravi.bangoria@linux.ibm.com>
From:   Rogerio Alves <rcardoso@linux.ibm.com>
Message-ID: <45936ae1-5150-a0f0-1b82-1689b9f729c3@linux.ibm.com>
Date:   Thu, 17 Sep 2020 10:25:31 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902042945.129369-3-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_09:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009170098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/20 1:29 AM, Ravi Bangoria wrote:
> Vector load/store instructions are special because they are always
> aligned. Thus unaligned EA needs to be aligned down before comparing
> it with watch ranges. Otherwise we might consider valid event as
> invalid.
> 
> Fixes: 74c6881019b7 ("powerpc/watchpoint: Prepare handler to handle more than one watchpoint")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Rogerio Alves <rcardoso@linux.ibm.com>
> ---
>   arch/powerpc/kernel/hw_breakpoint.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 9f7df1c37233..f6b24838ca3c 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -644,6 +644,8 @@ static void get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
>   	if (*type == CACHEOP) {
>   		*size = cache_op_size();
>   		*ea &= ~(*size - 1);
> +	} else if (*type == LOAD_VMX || *type == STORE_VMX) {
> +		*ea &= ~(*size - 1);
>   	}
>   }
>   
> 
