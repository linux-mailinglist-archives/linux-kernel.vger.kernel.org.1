Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF652B5AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgKQI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:27:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60646 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbgKQI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:27:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH8OEMH155617;
        Tue, 17 Nov 2020 08:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8NAL2OR4NP5UIcSZUGGgNfPxjpXAwG3H5GMTA/9afgQ=;
 b=o3qOaJtIU3VeaSs7ilnIiI08SWl6O6hwf5sgOh/azxTOAs/EaAlpzJd/gvDjBEqOKwsi
 sv8qu0s7Ot0H7fiy0Dxk7fKbbCurMLpWQ6OXOqFolzPTYcnM7Tbm8n5IBzUNoHYXg9Ln
 R7DGeCuu4d5AS9QkWtp1DNrKoXeqmz+b46xRSOcT06D1i23Ii1DfSAE+9oNLZTYS8hLN
 YAIqK37h7lrbhUzspaav0mkjbGKa9R7hVDaaatBTj9x7odd5dT3yJ5m1Rxlb/hu2ENOo
 hkNAhP3AwtL5w+MWgnkLZhGRZTrc+nORN/wL5MqvJ5TiSHzX6TwCRUQI6qKf/ZhFBWa8 xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34t4rasa3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 08:27:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH8KWcw075138;
        Tue, 17 Nov 2020 08:25:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34ts5vryde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 08:25:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AH8Ooka017691;
        Tue, 17 Nov 2020 08:24:51 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 00:24:50 -0800
Subject: Re: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of
 trampoline stack
To:     David Laight <David.Laight@ACULAB.COM>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "jan.setjeeilers@oracle.com" <jan.setjeeilers@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        "oweisse@google.com" <oweisse@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "kuzuno@gmail.com" <kuzuno@gmail.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116144757.1920077-13-alexandre.chartre@oracle.com>
 <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com>
 <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com>
 <985e90259d654d7c9eb74398c5d927ee@AcuMS.aculab.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <e6e168db-5d16-66a6-e817-6d23ea0bf1eb@oracle.com>
Date:   Tue, 17 Nov 2020 09:27:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <985e90259d654d7c9eb74398c5d927ee@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/20 10:24 PM, David Laight wrote:
> From: Alexandre Chartre
>> Sent: 16 November 2020 18:10
>>
>> On 11/16/20 5:57 PM, Andy Lutomirski wrote:
>>> On Mon, Nov 16, 2020 at 6:47 AM Alexandre Chartre
>>> <alexandre.chartre@oracle.com> wrote:
>>>>
>>>> When entering the kernel from userland, use the per-task PTI stack
>>>> instead of the per-cpu trampoline stack. Like the trampoline stack,
>>>> the PTI stack is mapped both in the kernel and in the user page-table.
>>>> Using a per-task stack which is mapped into the kernel and the user
>>>> page-table instead of a per-cpu stack will allow executing more code
>>>> before switching to the kernel stack and to the kernel page-table.
>>>
>>> Why?
>>
>> When executing more code in the kernel, we are likely to reach a point
>> where we need to sleep while we are using the user page-table, so we need
>> to be using a per-thread stack.
> 
> Isn't that going to allocate a lot more kernel memory?

That's one of my concern, hence this RFC. The current code is doubling the
task stack (this was an easy solution), so that's +8KB per task. See my
reply to Boris, it has a bit more details.

alex.


> ISTR some thoughts about using dynamically allocated kernel
> stacks when (at least some) wakeups are done by directly
> restarting the system call - so that the sleeping thread
> doesn't even need a kernel stack.
> (I can't remember if that was linux or one of the BSDs)
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
