Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC2285637
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 03:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgJGBVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 21:21:32 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:29018 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbgJGBVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:21:31 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0971FYMx002841;
        Wed, 7 Oct 2020 01:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=/zpvpQBMo/f3GdTerzEYdyceizkLUV976JwIcMUSvAE=;
 b=IS7kIkt6HsPjb3f8023w68tbjpEyzwdY4cugKXrJXB0Rq9tpYI9V7eTKDAwXRfLPXRyL
 sf9jOR8yvXqLvy3Hcnv2nZ1DzFUv3PA0Uw2fl7Gcc16BqZICwm47T35Xo6zrdTKOz4+/
 mblNwKhpZT3pVdu+ZqiLocIiziwiVLHHQW3T54FJyHjjYWF0+RUL1TtK6BmHxtrAMqgJ
 9ilFIwW31ED/r6/NOaMoWXZFnA1lOjJSBrNtlTmV8STBUkaH2rIMcwWF+v3g8lDz1spt
 V050Z1lLptW9KBScGBOQCZu56sxeaOfq7PwgrqB0yKhC6PYajdxHSd7wO2nNvbd08eNd 9g== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 33xjkpeb07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 01:21:18 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id D9B4892;
        Wed,  7 Oct 2020 01:21:16 +0000 (UTC)
Received: from [16.99.129.196] (unknown [16.99.129.196])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id E1EE54B;
        Wed,  7 Oct 2020 01:21:14 +0000 (UTC)
Subject: Re: [PATCH v4 06/13] x86/platform/uv: Add and Decode Arch Type in
 UVsystab
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20201005203929.148656-1-mike.travis@hpe.com>
 <20201005203929.148656-7-mike.travis@hpe.com>
 <20201005212135.GL21151@zn.tnic>
 <d2c7d3d8-3863-f15f-7ec6-ae41cf8b2657@hpe.com>
 <20201006151959.GF27700@zn.tnic>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <ee51449f-22b1-1074-19c1-b1b5a51fed64@hpe.com>
Date:   Tue, 6 Oct 2020 18:21:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20201006151959.GF27700@zn.tnic>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-06_15:2020-10-06,2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010070005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/2020 8:19 AM, Borislav Petkov wrote:
> On Mon, Oct 05, 2020 at 02:35:58PM -0700, Mike Travis wrote:
>>
>>
>> On 10/5/2020 2:21 PM, Borislav Petkov wrote:
>>> On Mon, Oct 05, 2020 at 03:39:22PM -0500, Mike Travis wrote:
>>>> A patch to add and process the UV Arch Type field in the UVsystab passed
>>>> from UV BIOS to the kernel.
>>>
>>> What does that mean?
>>>
>>
>> There have been recent cases where OEM's want to use the OEM_ID in the ACPI
>> tables to brand their own product.  The UV BIOS used that field to tell the
>> Linux kernel which UV arch the running system is.  The Arch Type in the
>> UVsystab (also created by UV BIOS) now carries that field in systems that
>> support it.
> 
> I am unclear on the whole patch passing from UV BIOS to the kernel. Are
> you talking about a kernel patch here? If so, commit ID is? Or what kind
> of patch are you talking about?
> 

When the UV BIOS starts the kernel it passes the UVsystab info struct to 
the kernel which contains information elements more specific than ACPI, 
and generally pertinent only to the MMR's.  These are read only fields 
so information is passed one way only.  A new field starting with UV5 is 
the UV architecture type so the ACPI OEM_ID field can be used for other 
purposes going forward.  The UV Arch Type selects the entirety of the 
MMRs available, with their addresses and fields defined in uv_mmrs.h.

Thanks,
Mike
