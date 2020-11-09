Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA142ABF66
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbgKIPER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:04:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731507AbgKIPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:04:16 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EXJ3S007393;
        Mon, 9 Nov 2020 10:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=z5oC/8a+GTxhWeb+ZbLr8Xr4K+9R59YBdDdSSh5RKRM=;
 b=XBIiWh0WE20556srxE4tLXEI6LHTLU0XOZ47YJ+y5FuzrW6vuf5w3TIr9w02PGtl0Vm2
 DuyXTJVwYsCISKNILJK+M1iFuUbShIE99Jq3DvQ0X1oX8LTGL34og77coACb+wK/HnCR
 AVRIlisnmRGpjCYnFi2E9U+kSrjh53XqIuAVfOxVS9IbINjiz9ouXPIQfH7yUyevg9fc
 0cuNK+RY6Rh+1w1zFDzDYDLhR8XfzoI7LW78lTBKqQts2p3iPmUCCyCpGOO1FeUilMD3
 8ctNR0S83H168re3lA8+p6vac/432WdtO2v2czqxzZ5czK9JDYTlY7G1LjWXEnXT8HFU zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34q5urdbxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 10:03:25 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A9EXd3B009077;
        Mon, 9 Nov 2020 10:03:23 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34q5urdbtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 10:03:23 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A9F1mKL012969;
        Mon, 9 Nov 2020 15:03:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 34p26phjpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 15:03:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A9F3Gqd55771522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Nov 2020 15:03:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8080BAE055;
        Mon,  9 Nov 2020 15:03:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9050FAE051;
        Mon,  9 Nov 2020 15:03:15 +0000 (GMT)
Received: from osiris (unknown [9.171.58.192])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  9 Nov 2020 15:03:15 +0000 (GMT)
Date:   Mon, 9 Nov 2020 16:03:14 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux-foundation.org,
        YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH seccomp 5/8] s390: Enable seccomp architecture tracking
Message-ID: <20201109150314.GA16690@osiris>
References: <cover.1604410035.git.yifeifz2@illinois.edu>
 <0fbe0c14d598e18effad3b648ab4808f9cd95eba.1604410035.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fbe0c14d598e18effad3b648ab4808f9cd95eba.1604410035.git.yifeifz2@illinois.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_02:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=859
 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=1 adultscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 07:43:01AM -0600, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
> 
> To enable seccomp constant action bitmaps, we need to have a static
> mapping to the audit architecture and system call table size. Add these
> for s390.
> 
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/s390/include/asm/seccomp.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
> index 795bbe0d7ca6..71d46f0ba97b 100644
> --- a/arch/s390/include/asm/seccomp.h
> +++ b/arch/s390/include/asm/seccomp.h
> @@ -16,4 +16,13 @@
>  
>  #include <asm-generic/seccomp.h>
>  
> +#define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_S390X
> +#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +#define SECCOMP_ARCH_NATIVE_NAME	"s390x"
> +#ifdef CONFIG_COMPAT
> +# define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_S390
> +# define SECCOMP_ARCH_COMPAT_NR		NR_syscalls
> +# define SECCOMP_ARCH_COMPAT_NAME	"s390"
> +#endif
> +

Acked-by: Heiko Carstens <hca@linux.ibm.com>
