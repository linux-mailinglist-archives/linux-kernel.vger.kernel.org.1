Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91312B76AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKRHHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:07:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49926 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:07:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AI6s9ll084754;
        Wed, 18 Nov 2020 07:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=W9Dn17eSP/nnht7DwPA04ZqWOvMUdMMYD9HsTapUw3s=;
 b=HvCdngw+jBC2wVcr6apwwhutpePCFVd7Cf1k8GW2LD6Oog+X6UzDlfOCBpR6fKrycYlp
 d5tj5PXuB7YJ4tGhNhXGvcW6TA9YIZbN5S8M9bHwE+5D9CJEnFfi1D8VhmYhYh9xdSz2
 FfgAI6Kle/tlC94VaJ7tnnvONZm6lJPtphpdxbe56YKn83zB5RU7d9fN4sIJw31f2kZw
 EuZNg6MtGKTVGwmh1xyBESF7UTXN9dtoZcCT/BXoF1zYPC8Y+quLic2Qhn9/osQzFyVt
 MCbAGd5DyOZkwAPX//rcad19iyVvzeteY352inR/ZvwPoZTt6215ikHmxGZUhYiS1Y8X Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34t7vn6efx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 07:06:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AI6tIJI166456;
        Wed, 18 Nov 2020 07:06:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34umd076rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 07:06:40 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AI76RxM012749;
        Wed, 18 Nov 2020 07:06:31 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 23:06:27 -0800
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
 <20201117182809.GK5719@zn.tnic>
 <33a1c6ee-0122-0b0c-ed2d-1578b29ef7c1@oracle.com>
 <20201117212307.GR5719@zn.tnic>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <1c39ebd0-2afd-5f51-ef48-ea3f378d8a0d@oracle.com>
Date:   Wed, 18 Nov 2020 08:08:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117212307.GR5719@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/17/20 10:23 PM, Borislav Petkov wrote:
> On Tue, Nov 17, 2020 at 08:02:51PM +0100, Alexandre Chartre wrote:
>> No. This prevents the guest VM from gathering data from the host
>> kernel on the same cpu-thread. But there's no mitigation for a guest
>> VM running on a cpu-thread attacking another cpu-thread (which can be
>> running another guest VM or the host kernel) from the same cpu-core.
>> You cannot use flush/clear barriers because the two cpu-threads are
>> running in parallel.
> 
> Now there's your justification for why you're doing this. It took a
> while...
> 
> The "why" should always be part of the 0th message to provide
> reviewers/maintainers with answers to the question, what this pile of
> patches is all about. Please always add this rationale to your patchset
> in the future.
> 

Sorry about that, I will definitively try to do better next time. :-}

Thanks,

alex.
