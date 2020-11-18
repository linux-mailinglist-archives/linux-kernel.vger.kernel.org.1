Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8032B7710
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgKRHkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:40:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59916 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgKRHkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:40:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AI7OEDo180962;
        Wed, 18 Nov 2020 07:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4KgLT+B0lb8kNH88ZUkx3bx2giYs+dXPjO0zGf/6wwc=;
 b=niscrOODhEXVydQUCTyWmsb2VkhUWuGFOWu6VirfilOr48IzW8hHegxWU+spUvCop29Z
 POrDaBvkBmrqwibKifYTeeWWBpX5cRpvMRfkeYewNCYSEcSwUa9S6Cw3jbotlN7J6NpX
 4XfEL3j8109ixreSldUqyT6m7eSokVo/PUNOf7MCWix2x1bBYgEUyOhsfsebSnk23/Zn
 8K8OLEBAcUsonZ0lkNs9W9PeQj/EdxatfmFUN2ZYLIFNv5gzodYOE2BjoKtgxmtISD7V
 nSbYpFEZ6U2JNALY4YqySmUvtgXhcUZvdJ8K/h5ydspjsgVh6JMOZl1M4ytl8Xz9tvTl bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34t76kxjv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 07:39:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AI7PJlE058852;
        Wed, 18 Nov 2020 07:39:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34umd0863h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 07:39:32 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AI7dNvX026966;
        Wed, 18 Nov 2020 07:39:23 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 23:39:23 -0800
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, junaids@google.com, oweisse@google.com,
        rppt@linux.vnet.ibm.com, graf@amazon.de, mgross@linux.intel.com,
        kuzuno@gmail.com
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
 <20201117165539.GG5719@zn.tnic>
 <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
 <20201117212608.GS5719@zn.tnic>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <b63ec614-8a49-728d-aa61-76339378183f@oracle.com>
Date:   Wed, 18 Nov 2020 08:41:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117212608.GS5719@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/17/20 10:26 PM, Borislav Petkov wrote:
> On Tue, Nov 17, 2020 at 07:12:07PM +0100, Alexandre Chartre wrote:
>> Some benchmarks are available, in particular from phoronix:
> 
> What I was expecting was benchmarks *you* have run which show that
> perf penalty, not something one can find quickly on the internet and
> something one cannot always reproduce her-/himself.
> 
> You do know that presenting convincing numbers with a patchset greatly
> improves its chances of getting it upstreamed, right?
> 

Well, it looks like I wrongfully assume that KPTI was a well known performance
overhead since it was introduced (because it adds extra page-table switches),
but you are right I should be presenting my own numbers.

Thanks,

alex.
