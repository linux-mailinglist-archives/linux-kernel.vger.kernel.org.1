Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25472EC315
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbhAFSQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 13:16:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39766 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbhAFSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 13:16:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 106I8uMJ125957;
        Wed, 6 Jan 2021 18:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=njrIPL1dY3te72wQwa97PmtTQJBPGgXD5ItKsbLYRMw=;
 b=BY6W+BbjISVdEuCEOe0EvGCnhKiwAY6c1gggPUS4gSpkr4uIdP678KO/oTM3gQUtarhl
 QPeHexKbLVztTeRH9Q/kwdHYb2Nb085xZ3YzXbgxNblXqEMepe8HXKjT2fjTmI08LLCx
 8Lkf6bvKt19SzkoJdKUfb9zwAKPAMwnUZvhFNQku1M4z9coz22WkSEYLEy60+XQK75f8
 QUzIbt4apDgXUqZqjMW6FOcpkUTwC2XSzRR8C7IOMD5VHGcLnZj7SlFqXk450aRRfTkd
 8DS9pjG55NaLv0EMnjDy/0T64+W6/m3QfV31kDjcebDT2uk+ctUvPn5qFzEafOPz9FaL Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35wepm980j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 18:16:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 106IAQEp057363;
        Wed, 6 Jan 2021 18:14:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 35w3qsbugc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 18:14:00 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 106IDxnl003665;
        Wed, 6 Jan 2021 18:13:59 GMT
Received: from [192.168.0.108] (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Jan 2021 10:13:59 -0800
Subject: Re: vfio-pci: protect remap_pfn_range() from simultaneous calls
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
References: <MWHPR18MB152034C6BAE8CC6D503DDEBEE3D09@MWHPR18MB1520.namprd18.prod.outlook.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <f33979f5-0e89-4fa2-c48e-06d353379f23@oracle.com>
Date:   Wed, 6 Jan 2021 10:13:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <MWHPR18MB152034C6BAE8CC6D503DDEBEE3D09@MWHPR18MB1520.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9856 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9856 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-06 8:17 a.m., Bharat Bhushan wrote:
> Hi Ankur,
> 
> We are observing below BUG_ON() with latest kernel
> 
>     [10011.321645] ------------[ cut here ]------------
>     [10011.322262] kernel BUG at mm/memory.c:1816!
>     [10011.323793] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>     [10011.326108] CPU: 2 PID: 1147 Comm: odp_l2fwd Not tainted 5.4.74-05938-gb9598e49fe61 #15
>     [10011.328272] Hardware name: Marvell CN106XX board (DT)
>     [10011.330328] pstate: 80400009 (Nzcv daif +PAN -UAO)
>     [10011.332402] pc : remap_pfn_range+0x1a4/0x260
>     [10011.334383] lr : remap_pfn_range+0x14c/0x260
>     [10011.335911] sp : ffff8000156afc10
>     [10011.337360] x29: ffff8000156afc10 x28: ffffffdffa240000
>     [10011.339671] x27: ffff00014a241000 x26: 0000002182000000
>     [10011.341984] x25: ffff0001489fbe00 x24: 0000002182040000
>     [10011.344279] x23: 0000002182040000 x22: 0068000000000fc3
>     [10011.346539] x21: 0000002182040000 x20: ffff000149d70860
>     [10011.348846] x19: 0000000000000041 x18: 0000000000000000
>     [10011.351064] x17: 0000000000000000 x16: 0000000000000000
>     [10011.353304] x15: 0000000000000000 x14: 0000000000000000
>     [10011.355519] x13: 0000000000000000 x12: 0000000000000000
>     [10011.357812] x11: 0000000000000000 x10: ffffffdfffe00000
>     [10011.360136] x9 : 0000000000000000 x8 : 0000000000000000
>     [10011.362414] x7 : 0000000000000000 x6 : 0000042182000000
>     [10011.364773] x5 : 0001000000000000 x4 : 0000000000000000
>     [10011.367103] x3 : ffffffe000328928 x2 : 016800017c240fc3
>     [10011.369462] x1 : 0000000000000000 x0 : ffffffe000328928
>     [10011.371694] Call trace:
>     [10011.373510]  remap_pfn_range+0x1a4/0x260
>     [10011.375386]  vfio_pci_mmap_fault+0x9c/0x114
>     [10011.377346]  __do_fault+0x38/0x100
>     [10011.379253]  __handle_mm_fault+0x81c/0xce4
>     [10011.381247]  handle_mm_fault+0xb4/0x17c
>     [10011.383220]  do_page_fault+0x110/0x430
>     [10011.385188]  do_translation_fault+0x80/0x90
>     [10011.387069]  do_mem_abort+0x3c/0xa0
>     [10011.388852]  el0_da+0x20/0x24
>     [10011.391239] Code: eb1a02ff 54000080 f9400362 b4fffe42 (d4210000)
>     [10011.393306] ---[ end trace ae8b75b32426d53c ]---
>     [10011.395140] note: odp_l2fwd[1147] exited with preempt_count 2
> 
> This is observed after patch "vfio-pci: Fault mmaps to enable vma tracking" where actual mapping delayed on page fault.
> When address of same page accessed by multiple threads at/around same time by threads running on different cores causes page fault for same page on multiple cores at same time. One of the fault hander creates mapping while second hander find that page-table mapping already exists and leads to above kernel BUG_ON().

Yeah, that's what my fix addressed as well.

> 
> While article  https://lwn.net/Articles/828536/ suggest that you have already faced and fixed this issue
>         "- vfio-pci: protect remap_pfn_range() from simultaneous calls (Ankur  Arora) [Orabug: 31663628] {CVE-2020-12888} {CVE-2020-12888}"
> 
> But I do not see any patch submitted or under review in upstream, hopefully I did not missed some discussion. Please let us know in case you already submitted or planning to submit fix or someone else fixed same.

No you haven't missed a discussion on this. For upstream this was more of
a theoretical race so I dallied a bit before sending the patch upstream.

I'll submit a patch soon. Also, would you mind if I ask you to run this
failing test before submission?

Thanks
Ankur

> 
> Thanks
> -Bharat
> 
