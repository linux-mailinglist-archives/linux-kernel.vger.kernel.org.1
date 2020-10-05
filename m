Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2BD28422A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 23:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgJEVgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 17:36:49 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:23796 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgJEVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:36:48 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095La5Wk026355;
        Mon, 5 Oct 2020 21:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=wefYufi/SyhpH8c7CRLVlRheotu72P1NKL0A3Cqfe7U=;
 b=hTExfM30NxzMA59OdPc98Sh1hHw7IRlpoqp1KndtUp1bzChAmlZRpKYPuII+uoVnIFii
 2yJBXk4w3DxRkvTuM/F5Sd+YfJdEkHpWzEa4U2pUcw0oC1RsgjHhrlfTvl10Z5dIHXmd
 EqKbOwAM6gYtL7Yxgmah9IKE6/lnhH2KD2QzkM+i54R+9EBCfVQ0acdXI7aCDZ3PiIQ1
 5wGP1YA4/hKVCc0+UwjTJ2ZU5L0g25NQIZ7MWShEtG29SpwnSC/orZKkLrhwdoMg7R1r
 YLR3RQEg1zex4eDsq36/HZGCQ7mjqK4rgws3ACdjXStWTpYpM3Fkag28COJ6rkXer0hM xQ== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 33xgdvknh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 21:36:05 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id DC40785;
        Mon,  5 Oct 2020 21:36:01 +0000 (UTC)
Received: from [16.99.129.98] (unknown [16.99.129.98])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 3DCFE54;
        Mon,  5 Oct 2020 21:35:59 +0000 (UTC)
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
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <d2c7d3d8-3863-f15f-7ec6-ae41cf8b2657@hpe.com>
Date:   Mon, 5 Oct 2020 14:35:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20201005212135.GL21151@zn.tnic>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_16:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=582 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050153
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2020 2:21 PM, Borislav Petkov wrote:
> On Mon, Oct 05, 2020 at 03:39:22PM -0500, Mike Travis wrote:
>> A patch to add and process the UV Arch Type field in the UVsystab passed
>> from UV BIOS to the kernel.
> 
> What does that mean?
> 

There have been recent cases where OEM's want to use the OEM_ID in the 
ACPI tables to brand their own product.  The UV BIOS used that field to 
tell the Linux kernel which UV arch the running system is.  The Arch 
Type in the UVsystab (also created by UV BIOS) now carries that field in 
systems that support it.
