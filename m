Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3A52AC31B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgKISCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:02:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58774 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgKISCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:02:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9I00bD004962;
        Mon, 9 Nov 2020 18:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tiwujwGdilKZr84pbLNR0dqaeKfAKUdWj3W5vd0l2Eg=;
 b=MQtnAui+XKLB79uEBKYCPuKpNvH815neLehESfz6rGFNoeWcgRdZfhO2eAe8Nen0oJ8E
 332WcX09l5lSLclwNSBpg0t+I+kv7P0CtrDAJ2X9h/07UHJPItzvw0UDNVcW4x9BGddB
 Eikc3Gzfz3DE1BLy5j0/lMUeFkCwwvHysjqdko4eQkCbXQnJXatDXKqw5MExfEK0Vqe/
 NSWP43tzmtwgmaT+cEcXV1/QRBFRvVNV+WRoQMQ8NqvjKrHGY9QthhCMYVMd2CJrPS/d
 CK+iJxvon8xyuY3AP9q/lYTC6aAWl18jeYZtwIiZpT4hWCtY60ukj7ZfMtUKIiugtUAZ hQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34nkhkqcfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 18:02:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9I12UR095977;
        Mon, 9 Nov 2020 18:02:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34p5bquedc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 18:02:31 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9I2UYK018892;
        Mon, 9 Nov 2020 18:02:30 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 10:02:30 -0800
Subject: Re: [RFC][PATCH 08/24] x86/entry: Add C version of SWAPGS and
 SWAPGS_UNSAFE_STACK
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
 <20201109112319.264511-9-alexandre.chartre@oracle.com>
 <CALCETrXtqC9w5gAa=UcF=B4z7vKuUL2sutsCJOjaSCK4CX4q0Q@mail.gmail.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <c5485ba4-3652-8c98-c485-918d322c015e@oracle.com>
Date:   Mon, 9 Nov 2020 19:04:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXtqC9w5gAa=UcF=B4z7vKuUL2sutsCJOjaSCK4CX4q0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
