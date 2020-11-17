Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3128A2B6D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbgKQSZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:25:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36760 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbgKQSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:25:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIONmV157259;
        Tue, 17 Nov 2020 18:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RkdMEuojSc3ehI93FYso5qdeBe0QJXljLV+GT8Oxri0=;
 b=PeCpF2KhTnT5f+gX4ks0Xn0sriEnHFFqBrf9sIKN7oMJLmdHJx5LCITUriPIF56pijzK
 iUXdJ14xf9GI6Rmau+u1KONVtut3AifvqG4E1aokuEmuN4GVRAUjikt5/gLWgyhrKedi
 CpSODOnRbSg76hXJB+8Ibh/NogEuW1vHKuUPIXEMW6cVqIUBpnuVhq6S48TmaKkyI35r
 ObGl/MrDiCIPRGfFduKV7D8Xs6Wi9jIMgnkf0a2Ppt5kIbMu/pScwnV44TlHccQ+WNaP
 NiNADORsnvIz9HkxCbYHB/mNGVNKqR8AKcguUIm+bIkQcPca7bJCG0osoKJlTxboYBWm rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34t76kv4av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 18:24:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHI9auK066259;
        Tue, 17 Nov 2020 18:22:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34usptrcfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 18:22:25 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AHIMN5X031425;
        Tue, 17 Nov 2020 18:22:23 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 10:22:22 -0800
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
 <20201116202426.GF1131@zn.tnic>
 <692599af-53c8-7881-2bc7-8898085400cd@oracle.com>
 <20201117170735.GH5719@zn.tnic>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <14f4a09c-361c-2110-f2e8-e2465076ab5b@oracle.com>
Date:   Tue, 17 Nov 2020 19:24:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117170735.GH5719@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/17/20 6:07 PM, Borislav Petkov wrote:
> On Tue, Nov 17, 2020 at 09:19:01AM +0100, Alexandre Chartre wrote:
>> We are not reversing PTI, we are extending it.
> 
> You're reversing it in the sense that you're mapping more kernel memory
> into the user page table than what is mapped now.
> 
>> PTI removes all kernel mapping from the user page-table. However there's
>> no issue with mapping some kernel data into the user page-table as long as
>> these data have no sensitive information.
> 
> I hope that is the case.
> 
>> Actually, PTI is already doing that but with a very limited scope. PTI adds
>> into the user page-table some kernel mappings which are needed for userland
>> to enter the kernel (such as the kernel entry text, the ESPFIX, the
>> CPU_ENTRY_AREA_BASE...).
>>
>> So here, we are extending the PTI mapping so that we can execute more kernel
>> code while using the user page-table; it's a kind of PTI on steroids.
> 
> And this is what bothers me - someone else might come after you and say,
> but but, I need to map more stuff into the user pgt because I wanna do
> X... and so on.

Agree, any addition should be strictly checked. I have been careful to expand
it to the minimum I needed.


>> The minimum size would be 1 page (4KB) as this is the minimum mapping size.
>> It's certainly enough for now as the usage of the PTI stack is limited, but
>> we will need larger stack if we won't to execute more kernel code with the
>> user page-table.
> 
> So on a big machine with a million tasks, that's at least a million
> pages more which is what, ~4 Gb?
> 
> There better be a very good justification for the additional memory
> consumption...

Yeah, adding a per-task allocation is my main concern, hence this RFC.


alex.
