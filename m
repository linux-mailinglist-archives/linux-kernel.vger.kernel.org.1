Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BD2B6DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgKQTBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:01:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgKQTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:01:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIxq70028846;
        Tue, 17 Nov 2020 19:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kFhpvmVlIgv+wqtZAim1r+yLEWpAFdL90ENg0K3Wbp0=;
 b=KeampoBcYOqID7YX4N/DVLeiW5HCBfFU9MQ5u+yXNBbXoumb+5VzoJxp0Fpn3Lu0t/AK
 Obn17Ieg0ZTZhyoFnv7rYpCWuHqWuWpfMZrL4abYWhS0twYQjMW2XNatfUMU7/NICaIA
 RxIgd5kZcSjLkoM63JZh2DFzAHaLsP1NB5eoywX9RBA6nka8Ci1t1rpmWiaKPwJoLFMM
 iY43rAKoKjDoC+WtrkZ7l+tNVIsCI0mkH7eUyCiodffyKArsAefKHdt92++aIAAjcEwa
 gF+T8ogJn9Tir/yzfeQjCCARYfzq9yrQnV6MMRQUUUiwedyZlv4pzMKFV2uvJVBzMpEz Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34t7vn483x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 19:00:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHItTO1027581;
        Tue, 17 Nov 2020 19:00:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ts0ra84x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 19:00:41 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AHJ0Wf0011449;
        Tue, 17 Nov 2020 19:00:37 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 11:00:32 -0800
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
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <33a1c6ee-0122-0b0c-ed2d-1578b29ef7c1@oracle.com>
Date:   Tue, 17 Nov 2020 20:02:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117182809.GK5719@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/20 7:28 PM, Borislav Petkov wrote:
> On Tue, Nov 17, 2020 at 07:12:07PM +0100, Alexandre Chartre wrote:
>> Yes. L1TF/MDS allow some inter cpu-thread attacks which are not mitigated at
>> the moment. In particular, this allows a guest VM to attack another guest VM
>> or the host kernel running on a sibling cpu-thread. Core Scheduling will
>> mitigate the guest-to-guest attack but not the guest-to-host attack.
> 
> I see in vmx_vcpu_enter_exit():
> 
>          /* L1D Flush includes CPU buffer clear to mitigate MDS */
>          if (static_branch_unlikely(&vmx_l1d_should_flush))
>                  vmx_l1d_flush(vcpu);
>          else if (static_branch_unlikely(&mds_user_clear))
>                  mds_clear_cpu_buffers();
> 
> Is that not enough?

No. This prevents the guest VM from gathering data from the host kernel on the
same cpu-thread. But there's no mitigation for a guest VM running on a cpu-thread
attacking another cpu-thread (which can be running another guest VM or the
host kernel) from the same cpu-core. You cannot use flush/clear barriers because
the two cpu-threads are running in parallel.

alex.
