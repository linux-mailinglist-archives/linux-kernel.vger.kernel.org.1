Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1132F2EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbhALMH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:07:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732218AbhALMH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:07:58 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10CC2Ja3107344;
        Tue, 12 Jan 2021 07:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yGvhckPIWq+OZTr20FBQMwOJaKxv0ZA018v9tYETN88=;
 b=mWSNdL97iTs3HxMGTNZMJ/ivRTdbZSPXfE/BWvqC12nf6M583aSzkt0IScKuI9NtGgb6
 VikgeKfq54kv1nwq2DZBWRR1/PWnqY9vkn4QNIm4BR7CNyARTm8yd57oHIlqAqO9RmDI
 7NuQ5GJZPtBKpjZX5MixeRTATzlBBkuLvIbhlI5M02yJU6Sk5qXRqQSabzbsUYHDHEs+
 OSV/wfF0bGp4WANNSyfQS6DvRqUwok7/1lz3V2RK6HS0GxjVVjj7s7IgE4ZwzdmSQCy0
 57IRDf5sRZSxnytxg/99bgs2MIuJyWKat3lIsvqnjCKUWOUncPCKgWoClLovqMJ41W7e Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361b05gvxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 07:07:06 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10CC4icw119535;
        Tue, 12 Jan 2021 07:07:05 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361b05gvvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 07:07:05 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10CBwUsx009096;
        Tue, 12 Jan 2021 12:07:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 35y448bkkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 12:07:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10CC70Ct32375242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 12:07:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4471A4054;
        Tue, 12 Jan 2021 12:07:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF51EA405C;
        Tue, 12 Jan 2021 12:06:58 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.176.60])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Jan 2021 12:06:58 +0000 (GMT)
Date:   Tue, 12 Jan 2021 14:06:56 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernelci-results-staging@groups.io,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: kernelci/staging-next bisection: sleep.login on
 rk3288-rock2-square #2286-staging
Message-ID: <20210112120656.GJ832698@linux.ibm.com>
References: <5fd3e5d9.1c69fb81.f9e69.5028@mx.google.com>
 <127999c4-7d56-0c36-7f88-8e1a5c934cae@collabora.com>
 <20201213082314.GA198221@linux.ibm.com>
 <0633d44a-3796-8a1b-e5dc-99fc62aa4dc7@collabora.com>
 <20210103134753.GC832698@linux.ibm.com>
 <X/Ikalm2CLln2alz@redhat.com>
 <20210105091330.GD832698@linux.ibm.com>
 <28e59120-f8b9-7256-325a-1e4ca90887b5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e59120-f8b9-7256-325a-1e4ca90887b5@collabora.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_06:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:53:45AM +0000, Guillaume Tucker wrote:
> On 05/01/2021 09:13, Mike Rapoport wrote:
> > On Sun, Jan 03, 2021 at 03:09:14PM -0500, Andrea Arcangeli wrote:
> >> Hello Mike,
> >>
> >> On Sun, Jan 03, 2021 at 03:47:53PM +0200, Mike Rapoport wrote:
> >>> Thanks for the logs, it seems that implicitly adding reserved regions to
> >>> memblock.memory wasn't that bright idea :)
> >>
> >> Would it be possible to somehow clean up the hack then?
> >>
> >> The only difference between the clean solution and the hack is that
> >> the hack intended to achieved the exact same, but without adding the
> >> reserved regions to memblock.memory.
> > 
> > I didn't consider adding reserved regions to memblock.memory as a clean
> > solution, this was still a hack, but I didn't think that things are that
> > fragile.
> > 
> > I still think we cannot rely on memblock.reserved to detect
> > memory/zone/node sizes and the boot failure reported here confirms this.
> >  
> >> The comment on that problematic area says the reserved area cannot be
> >> used for DMA because of some unexplained hw issue, and that doing so
> >> prevents booting, but since the area got reserved, even with the clean
> >> solution, it shouldn't have never been used for DMA?
> >>
> >> So I can only imagine that the physical memory region is way more
> >> problematic than just for DMA. It sounds like that anything that
> >> touches it, including the CPU, will hang the system, not just DMA. It
> >> sounds somewhat similar to the other e820 direct mapping issue on x86?
> > 
> > My understanding is that the boot failed because when I implicitly added
> > the reserved region to memblock.memory the memory size seen by
> > free_area_init() jumped from 2G to 4G because the reserved area was close
> > to 4G. The very first allocation would get a chunk from slightly below of
> > 4G and as there is no real memory there, the kernel would crash.
> >  
> >> If you want to test the hack on the arm board to check if it boots you
> >> can use the below commit:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?id=c3ea2633015104ce0df33dcddbc36f57de1392bc
> > 
> > My take is your solution would boot with this memory configuration, but I
> > still don't think that using memblock.reserved for zone/node sizing is
> > correct.
> 
> The rk3288 platform has now been failing to boot for nearly a
> month on linux-next:
> 
>   https://kernelci.org/test/case/id/5ffbed0a31ad81239bc94cdb/
> 
> Until a fix or a new version of this patch is made, would it be
> possible to drop it or revert it so the platform become usable
> again?

There is a new version of these patches:

https://lore.kernel.org/lkml/20210111194017.22696-1-rppt@kernel.org

It's going to be in linux-next as soon as Andrew pushes mmotm.
 
> Or if you want, I can make a cleaned-up version of my hack to
> ignore the problematic region if you still need your patch to be
> on linux-next, but that would probably be less than ideal.
> 
> Thanks,
> Guillaume

-- 
Sincerely yours,
Mike.
