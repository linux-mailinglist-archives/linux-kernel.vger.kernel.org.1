Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B01C2B5259
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbgKPUTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:19:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40480 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgKPUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:19:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGKE7FC184017;
        Mon, 16 Nov 2020 20:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BYnJRTZcs0oaUzlPY8WjSL5rSKEpZDv+xiUp4uldaUo=;
 b=OaZMygvS4nsU1iJVGY1OS8MDUKL4YHc3INxFzS7U9kiKGx69Plx5KRM04lnKSOD8R3MX
 QPH9eq9l4wOSh98GZCu1VuX/QWn4OUTASKPSPNbK1CT4ahzG8g/2TlAfR8IosGGZq7ou
 kabF9x/HLVIMO27Ft8T48AyDkjnxovEhngV91TeDewJLHKdbNoH2JT4nWWqCk7pwrQZF
 j/jJcx9kLTI/mny+MGVSxzMToBQcWF7dI0RqHelCkhhhtBkeir9VrZ/xgykM+/IJS2cq
 QHxjRA88gz551wYrhHT3HaUzD1SNQIO+f3RXbZnhZiMlz6MI2dXFAB9E3OY+1+4fTDgP Wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34t76kq3su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 20:18:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGKAUKS132359;
        Mon, 16 Nov 2020 20:18:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34ts5v5016-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 20:18:46 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGKIhNg018994;
        Mon, 16 Nov 2020 20:18:43 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 12:18:43 -0800
Subject: Re: [RFC][PATCH v2 11/21] x86/pti: Extend PTI user mappings
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Junaid Shahid <junaids@google.com>,
        oweisse@google.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>, mgross@linux.intel.com,
        kuzuno@gmail.com
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116144757.1920077-12-alexandre.chartre@oracle.com>
 <CALCETrXoykRjRPYPfZr6gBKoMnHuRYiJTDOcFYMq8GLef00j1A@mail.gmail.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <820278dc-5f8e-6224-71b4-7c61819f68d1@oracle.com>
Date:   Mon, 16 Nov 2020 21:21:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXoykRjRPYPfZr6gBKoMnHuRYiJTDOcFYMq8GLef00j1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/20 8:48 PM, Andy Lutomirski wrote:
> On Mon, Nov 16, 2020 at 6:49 AM Alexandre Chartre
> <alexandre.chartre@oracle.com> wrote:
>>
>> Extend PTI user mappings so that more kernel entry code can be executed
>> with the user page-table. To do so, we need to map syscall and interrupt
>> entry code, per cpu offsets (__per_cpu_offset, which is used some in
>> entry code), the stack canary, and the PTI stack (which is defined per
>> task).
> 
> Does anything unmap the PTI stack?  Mapping is easy, and unmapping
> could be a pretty big mess.
> 

No, there's no unmap. The mapping exists as long as the task page-table
does (i.e. as long as the task mm exits). I assume that the task stack
and mm are freed at the same time but that's not something I have checked.

alex.
