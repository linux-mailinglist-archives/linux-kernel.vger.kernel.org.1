Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D30028424D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 23:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgJEVvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 17:51:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56684 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgJEVvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:51:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095Lnn4K133505;
        Mon, 5 Oct 2020 21:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4N0sCybXFk4irim21d+YD8gT/YMYlEzhjwEuZuDTDdg=;
 b=PBRu99lWXfCLpNcV24Znz+CFvpzAQbuaV/DV2pF8OOP8q3y32m6lbxld3iZ/3hl3vDo+
 mJwqyjeJHTwuX7bd2xvThdauPWUMJeycax2W5NG5Sh1ueu49oqlFKjL+bzyeaZci1RPY
 /aBTZgTN15/mEg+FSF4azeFRBC00Txk2F4A4tHEwItAwnTTNxVbG1aBYQzG+8vehHddc
 3E41QD0LA6+sx68ybcaH4X2H+6x0hLFKyGcwH97cMOSKZQmYVFZZFGNgdK4MVAZLJACZ
 tuQA7+q79Ykg9shMrMDbH4X75e7P+v9d0LIqOPOmp1x30T3Nt/i6lcMghUumnayfuAwX Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33xhxmqxh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 05 Oct 2020 21:51:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095LikpI027193;
        Mon, 5 Oct 2020 21:51:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33y36x1vas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Oct 2020 21:51:38 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 095LpbZY000724;
        Mon, 5 Oct 2020 21:51:37 GMT
Received: from [10.0.0.106] (/73.249.122.195)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Oct 2020 14:51:37 -0700
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
Message-ID: <566011dc-06e3-ba09-f63c-b794be43f1ba@oracle.com>
Date:   Mon, 5 Oct 2020 17:51:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929210455.2718827-1-nivedita@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050155
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

I pulled this change in and made all the changes to remove other code
that was causing relocations in the compressed kernel. I tested it and
it is working well. Thanks for all the help.

Tested-by: Ross Philipson <ross.philipson@oracle.com>

> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Ross Philipson <ross.philipson@oracle.com>
> [0] https://urldefense.com/v3/__https://lore.kernel.org/lkml/1600959521-24158-8-git-send-email-ross.philipson@oracle.com/__;!!GqivPVa7Brio!JiEGSToX4gewsr8DY0iWrRR7oTzMZl1b-WBsZ1U6M7dCJXuGzIrF-5qVqN4v8LEys8M$ 
> ---

[snip]
