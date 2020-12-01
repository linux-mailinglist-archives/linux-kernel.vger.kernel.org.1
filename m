Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCE2CA442
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391295AbgLANrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:47:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387833AbgLANrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:47:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1DW7sT123297;
        Tue, 1 Dec 2020 08:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=18Fac/MEWExn20Bjt6+tNWvHuYIjWyqinvH4ZsDeOt4=;
 b=mAMuRfTrhWR/wm9K7jInD4HeW2CXs0a7ReWrS7lObQPDoBJN1ToKzDIXtIbxjJMAcb5s
 ker3/bkXVuodjalHeBsXOQMD2acZC5HTQMxCfKpPYoUgaPYtX4jwb2fEh8LuYxjoutSY
 4tJ+yGSi/vUicxRZ1F2tqB/RWltZlH3sgmIk9gqYiFrBEl8OFRam9KZkAawdao+JBYGN
 am1JVvmxdAf7etD/nFyOjehs7G/I2/VCRqnwYe0BSeb+UCWw65avM3MAGLtiUN/HlA8j
 geyITHHZJCeD0smc1Gw2vgacaTouuAWfY4vk4e/n8n+rhEboPZmbgjlYR2GxOwTferTr ug== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 355k527nww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 08:46:30 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1DcMfF005462;
        Tue, 1 Dec 2020 13:46:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 353e689nhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 13:46:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1DkQDx35258876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 13:46:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 817004204D;
        Tue,  1 Dec 2020 13:46:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1FDB4203F;
        Tue,  1 Dec 2020 13:46:25 +0000 (GMT)
Received: from localhost (unknown [9.85.93.73])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Dec 2020 13:46:25 +0000 (GMT)
Date:   Tue, 01 Dec 2020 19:16:21 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 01/14] ftrace: Fix updating FTRACE_FL_TRAMP
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
        <56c113aa9c3e10c19144a36d9684c7882bf09af5.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
        <20201130212346.31e2a8b7@oasis.local.home>
In-Reply-To: <20201130212346.31e2a8b7@oasis.local.home>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Message-Id: <1606830090.lipn68ihsf.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_05:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012010083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Thu, 26 Nov 2020 23:38:38 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> On powerpc, kprobe-direct.tc triggered FTRACE_WARN_ON() in
>> ftrace_get_addr_new() followed by the below message:
>>   Bad trampoline accounting at: 000000004222522f (wake_up_process+0xc/0x=
20) (f0000001)
>>=20
>> The set of steps leading to this involved:
>> - modprobe ftrace-direct-too
>> - enable_probe
>> - modprobe ftrace-direct
>> - rmmod ftrace-direct <-- trigger
>>=20
>> The problem turned out to be that we were not updating flags in the
>> ftrace record properly. From the above message about the trampoline
>> accounting being bad, it can be seen that the ftrace record still has
>> FTRACE_FL_TRAMP set though ftrace-direct module is going away. This
>> happens because we are checking if any ftrace_ops has the
>> FTRACE_FL_TRAMP flag set _before_ updating the filter hash.
>>=20
>> The fix for this is to look for any _other_ ftrace_ops that also needs
>> FTRACE_FL_TRAMP.
>=20
> I'm applying this now and sending this for -rc and stable.
>=20
> The code worked on x86 because x86 has a way to make all users use
> trampolines, so this was never an issue (everything has a trampoline).
> I modified the kernel so that x86 would not create its own trampoline
> (see the weak function arch_ftrace_update_trampoline(), and I was able
> to reproduce the bug.

Good to know that you were able to reproduce this.

>=20
> I'm adding:
>=20
> Cc: stable@vger.kernel.org
> Fixes: a124692b698b0 ("ftrace: Enable trampoline when rec count returns b=
ack to one")

That looks good to me. Thanks for picking the two patches and for your=20
review on the others!


- Naveen

