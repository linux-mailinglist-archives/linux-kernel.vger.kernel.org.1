Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E1227DB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 00:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgI2WPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 18:15:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33314 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgI2WPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 18:15:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TMF3aN067539;
        Tue, 29 Sep 2020 22:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=v8FVZp2ta6OWGjFwuE9tOKJUzJfhRFSODvV9tZ//xik=;
 b=WWdvwFICm5JQBlAaWNiwFyCjkalq2bOBQya8xw2z5QXpjtRmVqMe/QGfu4Zyc4j1oXh/
 t0Lohy4ezjZ/6czhJLRg/OXI4iiqp360EdS0MJyy2aOTaWQmQMF5GKBXdoSluQi61pdw
 wB/ykAoYVh51r1F8Vf+ZV97oBYCbba9O15sYhTqCsnBpYPFZveRAZwjcOEace+VPaQuc
 GT5rjaiAe9jhS7gBchCk8wIwxuteuxl0qBa9I/RL8eHB6UocBGGD5HO9lggqZ8GItsOA
 ZnIyTR2JOV75Yl14BoNNljbGOUA2ISjiu5c7YxeLQBk1MBaI+YqzoehEyASz2jRKF4Jp rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33sx9n5e2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 22:15:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TM4wwV158901;
        Tue, 29 Sep 2020 22:13:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 33uv2eh4he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 22:13:16 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08TMDEMO031506;
        Tue, 29 Sep 2020 22:13:14 GMT
Received: from [10.39.199.45] (/10.39.199.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 15:13:14 -0700
Subject: Re: [PATCH] x86/boot: Place kernel_info at a fixed offset
To:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200929210455.2718827-1-nivedita@alum.mit.edu>
From:   Ross Philipson <ross.philipson@oracle.com>
Autocrypt: addr=ross.philipson@oracle.com; keydata=
 mQENBFtHZ04BCADHhtvMImplKfIEOytU7ZH4haZ9eFAqZpGeIpG9D+pzTCuReM2/49bvgNoI
 e1xuiQFO+UEJ8FjedFjDdqY7fSw3xVdX9gLwD1Rmw0Dadc1w6sGbcoOQLHcglesu+BmcKBtU
 tWQZkzCpEShN4etgZThk8469YnAvO08vNZsrizgrpD90T7mEYiNXxIkX87sPGbnBrL1X7RvZ
 TaRXfE8174W+XVwGEpSiO/GjRgLW8+DFZB5MgXpCR993+U1YT9Lz97/MRzr4hqcOYry6LBYi
 s8dOly4oP7gK15oW8Xap9+ur0Jd8Vy8o99Axq+7yunF+2KE2SwP3/w8H3VDpx7EeDhWDABEB
 AAG0KlJvc3MgUGhpbGlwc29uIDxyb3NzLnBoaWxpcHNvbkBvcmFjbGUuY29tPokBVAQTAQgA
 PgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJb
 R2eBBQkJZgGzAAoJENpHdTZHiMYcPYcH/Rlp3/F3P4/2i/W0F4yQDVD6rAkejCws4KlbgC5D
 Slkdvk6j8jOW/HNeIY3n+a3mW0iyyhZlipgYAqkK1loDiDxJjc2eUaHxiYWNLQ4CwIj2EC27
 AWCp6hgwHNWmZrdeNbM/Z6LTFQILx5xzgX+86KNqzFV7gOcAaS2qBVz1D83dgrFZaGaao918
 nvfe+SnImo0GaEf8nVDKgsD2zfzMBkk4q/E0mrEADFXwBHSvNCnVyrCN6Ve0dHWgI7SszUDt
 7v01zbGPR5mRfGuyC9gykd2SDCw5/Q27RMWfaPFL/dtiZBljUzb2yW5jicZAz7zNdDcBSUGR
 r//wxtG4k/dBrMW5AQ0EW0dnTwEIAPelEnLDnfJnHdFR+1Thrvv3Udt/1cjqQfHqH4F8zef/
 MsIcPV1skL7qPUYD+CrbasvmqhlPxtJAtN68inPa70fA2g0PtNmLUH1NBb2e6EjOoVZg9ais
 BWfdYUITZouOXs2zCTFsoNWjTJANnXxexbTf1ZEqfzlVtQK+xAnXl3kiL4Y47VMbgDkGedhw
 3ZMWQ2zMMZqYJkPYhtlTXtedhV91DL1347ULwHsvkUJDZ0gL+WU6tYhsCOOiD61x58PfUiFb
 /WkZEPxb96dSSSWrTlLlBWSSD24RnhfbJjfsXeSu9s4XldmGTDkj7jclMVU1xV0BUfqEwhVn
 xR8FlC+dZvkAEQEAAYkBPAQYAQgAJgIbDBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJbR2eB
 BQkJZgGyAAoJENpHdTZHiMYcDIAIAIRJrKjIStRvLsOOCX92s9XJPUjrC/xmtVsqVviyFWIC
 QRPQzDE+bDSvRazudBHmcPW+BOOB5B+p7zKZzOGoZV2peG8oA/Y8oCxOYBtpbBaZ5KJexm/g
 BbnJUwb3uhmKtDShHGUCmtq8MZBJBr6Q6xHprOU8Qnzs9Jea8NVwaz9O226Rrg4XVv/sK1Lh
 ++xZfhi7YqKWdx5vdfdnX1xWe8ma0eXLeCDh3V6Ys+Habw1jEbMuafrcVzAbp1rMt2Lju1ls
 BNAoxeViK7QXWfwGTmGJP++jHmo99gMqEtiohf+37N0oS6uYu6kaE7PxsEcOjWKJxW/DdgwO
 eFq+D6xuiKk=
Message-ID: <39c6052e-5615-9692-56fc-9850fa53f5de@oracle.com>
Date:   Tue, 29 Sep 2020 18:13:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929210455.2718827-1-nivedita@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290190
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290191
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 5:04 PM, Arvind Sankar wrote:
> There are use cases for storing the offset of a symbol in kernel_info.
> For example, the trenchboot series [0] needs to store the offset of the
> Measured Launch Environment header in kernel_info.
> 
> Since commit (note: commit ID from tip/master)
> 
>   527afc212231 ("x86/boot: Check that there are no run-time relocations")
> 
> run-time relocations are not allowed in the compressed kernel, so simply
> using the symbol in kernel_info, as
> 
> 	.long	symbol
> 
> will cause a linker error because this is not position-independent.
> 
> With kernel_info being a separate object file and in a different section
> from startup_32, there is no way to calculate the offset of a symbol
> from the start of the image in a position-independent way.
> 
> To enable such use cases, put kernel_info into its own section which is
> placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
> script. This will allow calculating the symbol offset in a
> position-independent way, by adding the offset from the start of
> kernel_info to KERNEL_INFO_OFFSET.
> 
> Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
> instead of bare labels. This stores the size of the kernel_info
> structure in the ELF symbol table.

That is great. It looks like just what we will need. Thank you very much.

Acked-by: Ross Philipson <ross.philipson@oracle.com>

> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Ross Philipson <ross.philipson@oracle.com>
> [0] https://urldefense.com/v3/__https://lore.kernel.org/lkml/1600959521-24158-8-git-send-email-ross.philipson@oracle.com/__;!!GqivPVa7Brio!JiEGSToX4gewsr8DY0iWrRR7oTzMZl1b-WBsZ1U6M7dCJXuGzIrF-5qVqN4v8LEys8M$ 
> ---
>  arch/x86/boot/compressed/kernel_info.S | 19 +++++++++++++++----
>  arch/x86/boot/compressed/kernel_info.h | 12 ++++++++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  6 ++++++
>  3 files changed, 33 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/kernel_info.h
> 
> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> index f818ee8fba38..c18f07181dd5 100644
> --- a/arch/x86/boot/compressed/kernel_info.S
> +++ b/arch/x86/boot/compressed/kernel_info.S
> @@ -1,12 +1,23 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
> +#include <linux/linkage.h>
>  #include <asm/bootparam.h>
> +#include "kernel_info.h"
>  
> -	.section ".rodata.kernel_info", "a"
> +/*
> + * If a field needs to hold the offset of a symbol from the start
> + * of the image, use the macro below, eg
> + *	.long	rva(symbol)
> + * This will avoid creating run-time relocations, which are not
> + * allowed in the compressed kernel.
> + */
> +
> +#define rva(X) (((X) - kernel_info) + KERNEL_INFO_OFFSET)
>  
> -	.global kernel_info
> +	.section ".rodata.kernel_info", "a"
>  
> -kernel_info:
> +	.balign	16
> +SYM_DATA_START(kernel_info)
>  	/* Header, Linux top (structure). */
>  	.ascii	"LToP"
>  	/* Size. */
> @@ -19,4 +30,4 @@ kernel_info:
>  
>  kernel_info_var_len_data:
>  	/* Empty for time being... */
> -kernel_info_end:
> +SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> diff --git a/arch/x86/boot/compressed/kernel_info.h b/arch/x86/boot/compressed/kernel_info.h
> new file mode 100644
> index 000000000000..c127f84aec63
> --- /dev/null
> +++ b/arch/x86/boot/compressed/kernel_info.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BOOT_COMPRESSED_KERNEL_INFO_H
> +#define BOOT_COMPRESSED_KERNEL_INFO_H
> +
> +#ifdef CONFIG_X86_64
> +#define KERNEL_INFO_OFFSET 0x500
> +#else /* 32-bit */
> +#define KERNEL_INFO_OFFSET 0x100
> +#endif
> +
> +#endif /* BOOT_COMPRESSED_KERNEL_INFO_H */
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 112b2375d021..84c7b4de489e 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -7,6 +7,7 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
>  
>  #include <asm/cache.h>
>  #include <asm/page_types.h>
> +#include "kernel_info.h"
>  
>  #ifdef CONFIG_X86_64
>  OUTPUT_ARCH(i386:x86-64)
> @@ -27,6 +28,11 @@ SECTIONS
>  		HEAD_TEXT
>  		_ehead = . ;
>  	}
> +	.rodata.kernel_info KERNEL_INFO_OFFSET : {
> +		*(.rodata.kernel_info)
> +	}
> +	ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> +
>  	.rodata..compressed : {
>  		*(.rodata..compressed)
>  	}
> 

