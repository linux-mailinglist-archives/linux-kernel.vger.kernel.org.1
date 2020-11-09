Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C585E2AC58C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgKITzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:55:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51072 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbgKITzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:55:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Jnodb124453;
        Mon, 9 Nov 2020 19:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Oj+4P5DeZIfnxmXx8aK/IInNq6W/Q8SBz+vVr/XLSmE=;
 b=cYycDKNUJtkH3N6nFsNQZ3wfB4bF2K/DmKrbF1dc4PZBjc7XFz9PeXiZeCDF3OgS6KFD
 IZ6feWySzMJwnQrDMjzOEMARNwkJqIpvSrc327EhdHbR/6TP1Q9dDUtweZHF2/SdN9ep
 VS3jkm+7jP8GJYh8uds11ISpj5DICTYMpwKHsN3Mz4jNzgF8nrqd+E+prjb1SeePjBxa
 lhPLreCr7Q2nwXgQlbHowNndye+374LkFV0sXVZAQFQ/FFd3dHYV6HU/pobanMZzULdi
 9luTb4XoXJGgtyZ7mDoEXNDW/pV3T5lt+Bxm454UQJABZzJYJIiUCZgmdkWnvB9XBJpP rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34nh3ar4b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 19:54:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Jo4Tj084300;
        Mon, 9 Nov 2020 19:52:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34p5gvqba2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 19:52:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9JqlQk009975;
        Mon, 9 Nov 2020 19:52:47 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 11:52:46 -0800
Subject: Re: [RFC][PATCH 08/24] x86/entry: Add C version of SWAPGS and
 SWAPGS_UNSAFE_STACK
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
 <20201109144425.270789-9-alexandre.chartre@oracle.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <a0febfb8-4efb-6b27-e7c5-78ad33ae1e3d@oracle.com>
Date:   Mon, 9 Nov 2020 20:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109144425.270789-9-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[Copying the reply to Andy in the thread with the right email addresses]

On 11/9/20 6:38 PM, Andy Lutomirski wrote:
> On Mon, Nov 9, 2020 at 3:22 AM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>> SWAPGS and SWAPGS_UNSAFE_STACK are assembly macros. Add C versions
>> of these macros (swapgs() and swapgs_unsafe_stack()).
>
> This needs a very good justification.  It also needs some kind of
> static verification that these helpers are only used by noinstr code,
> and they need to be __always_inline.  And I cannot fathom how C code
> could possibly use SWAPGS_UNSAFE_STACK in a meaningful way.
>

You're right, I probably need to revisit the usage of SWAPGS_UNSAFE_STACK
in C code, that doesn't make sense. Looks like only SWAPGS is then needed.

Or maybe we can just use native_swapgs() instead?

I have added a C version of SWAPGS for moving paranoid_entry() to C because,
in this function, we need to switch CR3 before doing the updating GS. But I
really wonder if we need a paravirt swapgs here, and we can probably just use
native_swapgs().

Also, if we map the per cpu offsets (__per_cpu_offset) in the user page-table
then we will be able to update GS before switching CR3. That way we can keep the
GS update in assembly code, and just do the CR3 switch in C code. This would also
avoid having to disable stack-protector (patch 21).

alex.
