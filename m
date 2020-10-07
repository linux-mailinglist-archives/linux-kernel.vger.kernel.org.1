Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E6828560C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 03:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgJGBLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 21:11:42 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:27890 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgJGBLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:11:42 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09718dWw007994;
        Wed, 7 Oct 2020 01:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=sE+zw621QC4f5OrYdi/sP433dL2LnBi2wXl+ev99row=;
 b=LuaY+6PgvsoeYP/0xyXsZjn9XkbHi2bRkJCQ3pFZvyE20WXTyxDUxtpnZWMsUOt5C7Ny
 Txs13SOHlRup2T2oQd7eiKf5ErDci90sQHZcWiCpkUk8L8YKadpnvJXfZxOSRnhhs7bb
 5zcmba/ul/z3e0+z6GFvXCWcVAQ4TPW5DbCggeXGst7q28ATPyp/SzG7lgEJ3LopsoXr
 Oh9Rt3BOnJwka7juISVXiadnXgv45hDuxb8rOuJYEuDTyKfm7lttQnirH9CucVVHhbiR
 NJztKnkuBljjzMn2BsCLPUIZ16kor28kiHFctBjFR6aahdeT33Cr/4qVFbz1FvvPkROA 3A== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 340xjyt4x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 01:11:09 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 688865C;
        Wed,  7 Oct 2020 01:11:08 +0000 (UTC)
Received: from [16.99.129.196] (unknown [16.99.129.196])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 2F9DD4F;
        Wed,  7 Oct 2020 01:11:06 +0000 (UTC)
Subject: Re: [PATCH v4 02/13] x86/platform/uv: Remove SCIR MMR references for
 UVY systems.
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20201005203929.148656-1-mike.travis@hpe.com>
 <20201005203929.148656-3-mike.travis@hpe.com>
 <20201006131602.GE27700@zn.tnic>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <eedfeab5-1bba-ad0c-4590-60fccf08aef2@hpe.com>
Date:   Tue, 6 Oct 2020 18:11:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20201006131602.GE27700@zn.tnic>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-06_15:2020-10-06,2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 mlxlogscore=847 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/2020 6:16 AM, Borislav Petkov wrote:
>> Subject: Re: [PATCH v4 02/13] x86/platform/uv: Remove SCIR MMR references for UVY systems.
> 
> You mean "UV" systems, right? Or are there "UVY" systems too? git grep
> says no.

I thought there was more references to the UVY class which currently has 
only UV5 as a member.  There might be UV5 references where they should 
be UVY.  The struct references use "uvy" as the selector so the grep 
should look for upper and lower case.

The UV5 system is still in the design stage so we are doing development 
using simulators.  More UV5 support is expected to arrive as needed. 
(The earlier class was UVX if interested.)

> On Mon, Oct 05, 2020 at 03:39:18PM -0500, Mike Travis wrote:
>> UV class systems no longer use System Controller for monitoring of CPU
>> activity provided by this driver.  Other methods have been developed
>> for BIOS and the management controller (BMC).  This patch removes that
>> supporting code.
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process >
> for more details.
> 
> I've fixed it up but please try not to do that in future patches.

Will do, thanks for the update it has been awhile for me.
> 
> Thx.
> 
