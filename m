Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08E821DFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 20:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGMS1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 14:27:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726058AbgGMS1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:27:52 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DI3PoD036740;
        Mon, 13 Jul 2020 14:27:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3276ag04jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 14:27:25 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06DIQYnf105762;
        Mon, 13 Jul 2020 14:27:25 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3276ag04hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 14:27:25 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06DIJWnY003604;
        Mon, 13 Jul 2020 18:27:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 327527th2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 18:27:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06DIRJxS46399502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 18:27:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB27252051;
        Mon, 13 Jul 2020 18:27:19 +0000 (GMT)
Received: from [9.85.72.195] (unknown [9.85.72.195])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 27B2A52050;
        Mon, 13 Jul 2020 18:27:15 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] Power10 basic energy management
To:     Nicholas Piggin <npiggin@gmail.com>, benh@kernel.crashing.org,
        ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
        mpe@ellerman.id.au, paulus@samba.org, pratik.r.sampat@gmail.com,
        ravi.bangoria@linux.ibm.com, svaidy@linux.ibm.com
References: <20200710052207.12003-1-psampat@linux.ibm.com>
 <1594617564.57k8bsyfd0.astroid@bobo.none>
 <bc6494c0-9a17-2416-c6cc-15612020f497@linux.ibm.com>
 <1594658947.97ndhsx6xh.astroid@bobo.none>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <cce3c51b-8614-5f4b-89ea-be5872bdcd7c@linux.ibm.com>
Date:   Mon, 13 Jul 2020 23:57:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594658947.97ndhsx6xh.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_15:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/20 10:20 pm, Nicholas Piggin wrote:
> Excerpts from Pratik Sampat's message of July 13, 2020 8:02 pm:
>> Thank you for your comments,
>>
>> On 13/07/20 10:53 am, Nicholas Piggin wrote:
>>> Excerpts from Pratik Rajesh Sampat's message of July 10, 2020 3:22 pm:
>>>> Changelog v1 --> v2:
>>>> 1. Save-restore DAWR and DAWRX unconditionally as they are lost in
>>>> shallow idle states too
>>>> 2. Rename pnv_first_spr_loss_level to pnv_first_fullstate_loss_level to
>>>> correct naming terminology
>>>>
>>>> Pratik Rajesh Sampat (3):
>>>>     powerpc/powernv/idle: Exclude mfspr on HID1,4,5 on P9 and above
>>>>     powerpc/powernv/idle: save-restore DAWR0,DAWRX0 for P10
>>>>     powerpc/powernv/idle: Rename pnv_first_spr_loss_level variable
>>>>
>>>>    arch/powerpc/platforms/powernv/idle.c | 34 +++++++++++++++++----------
>>>>    1 file changed, 22 insertions(+), 12 deletions(-)
>>> These look okay to me, but the CPU_FTR_ARCH_300 test for
>>> pnv_power9_idle_init() is actually wrong, it should be a PVR test
>>> because idle is not completely architected (not even shallow stop
>>> states, unfortunately).
>>>
>>> It doesn't look like we support POWER10 idle correctly yet, and on older
>>> kernels it wouldn't work even if we fixed newer, so ideally the PVR
>>> check would be backported as a fix in the front of the series.
>>>
>>> Sadly, we have no OPAL idle driver yet. Hopefully we will before the
>>> next processor shows up :P
>>>
>>> Thanks,
>>> Nick
>> So if I understand this correctly, in powernv/idle.c where we check for
>> CPU_FTR_ARCH_300, we should rather be making a pvr_version_is(PVR_POWER9)
>> check instead?
>>
>> Of course, the P10 PVR and its relevant checks will have to be added then too.
> Yes I think so, unfortunately.
>
> Thanks,
> Nick

Sure, I'll add these checks in.

Thanks,
Pratik

