Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBBF2EA723
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbhAEJOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:14:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727658AbhAEJOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:14:37 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10593KCR123968;
        Tue, 5 Jan 2021 04:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Hhc5GiPGpLK0t1a0sKKejme9Rm6KKPSudMwrMquDECE=;
 b=OnI5FpF91Xa7r+WGTmycremIoD10ifB/B+i+D7iwCNRAt7dIJFDQ4yZYPj7A27YOBUCi
 mTLVE6ruROuIQ/LbQbtaPRy+AGghFGM7qMSBpJ4FOsPQPEtWb1FaYDhJnFPadCW00K0+
 L4is+iXmoh5A1HSyiH0BnOF3aGAjku/OVwY7b6juUJUPLCreR9L3LzMXWfeO7mghlcVk
 674wE3r8frKcr9u1F0n7nx0+UbfvS0mUBu5DLMR8Pox2aJ1VDpkM+oFVzTlMcqk5RVM3
 cIukkzweeJ6mgkysPYEb5oT+vdn5VJ/uMJVLFjTj/nqYK9cL66cHQTHqHwJ1BYC1HBaZ og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35vmg9s6et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 04:13:42 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10596JsG132633;
        Tue, 5 Jan 2021 04:13:41 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35vmg9s6dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 04:13:41 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1059DM0S011095;
        Tue, 5 Jan 2021 09:13:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 35tgf89dja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 09:13:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1059DYIB44105990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jan 2021 09:13:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0901A52051;
        Tue,  5 Jan 2021 09:13:34 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.176.60])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id BC6125204F;
        Tue,  5 Jan 2021 09:13:32 +0000 (GMT)
Date:   Tue, 5 Jan 2021 11:13:30 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernelci-results-staging@groups.io,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: kernelci/staging-next bisection: sleep.login on
 rk3288-rock2-square #2286-staging
Message-ID: <20210105091330.GD832698@linux.ibm.com>
References: <5fd3e5d9.1c69fb81.f9e69.5028@mx.google.com>
 <127999c4-7d56-0c36-7f88-8e1a5c934cae@collabora.com>
 <20201213082314.GA198221@linux.ibm.com>
 <0633d44a-3796-8a1b-e5dc-99fc62aa4dc7@collabora.com>
 <20210103134753.GC832698@linux.ibm.com>
 <X/Ikalm2CLln2alz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/Ikalm2CLln2alz@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-04,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 03:09:14PM -0500, Andrea Arcangeli wrote:
> Hello Mike,
> 
> On Sun, Jan 03, 2021 at 03:47:53PM +0200, Mike Rapoport wrote:
> > Thanks for the logs, it seems that implicitly adding reserved regions to
> > memblock.memory wasn't that bright idea :)
> 
> Would it be possible to somehow clean up the hack then?
> 
> The only difference between the clean solution and the hack is that
> the hack intended to achieved the exact same, but without adding the
> reserved regions to memblock.memory.

I didn't consider adding reserved regions to memblock.memory as a clean
solution, this was still a hack, but I didn't think that things are that
fragile.

I still think we cannot rely on memblock.reserved to detect
memory/zone/node sizes and the boot failure reported here confirms this.
 
> The comment on that problematic area says the reserved area cannot be
> used for DMA because of some unexplained hw issue, and that doing so
> prevents booting, but since the area got reserved, even with the clean
> solution, it shouldn't have never been used for DMA?
>
> So I can only imagine that the physical memory region is way more
> problematic than just for DMA. It sounds like that anything that
> touches it, including the CPU, will hang the system, not just DMA. It
> sounds somewhat similar to the other e820 direct mapping issue on x86?

My understanding is that the boot failed because when I implicitly added
the reserved region to memblock.memory the memory size seen by
free_area_init() jumped from 2G to 4G because the reserved area was close
to 4G. The very first allocation would get a chunk from slightly below of
4G and as there is no real memory there, the kernel would crash.
 
> If you want to test the hack on the arm board to check if it boots you
> can use the below commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?id=c3ea2633015104ce0df33dcddbc36f57de1392bc

My take is your solution would boot with this memory configuration, but I
still don't think that using memblock.reserved for zone/node sizing is
correct.

> Thanks,
> Andrea
> 

-- 
Sincerely yours,
Mike.
