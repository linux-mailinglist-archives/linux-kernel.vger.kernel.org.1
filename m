Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3862E8C56
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 14:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhACNsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 08:48:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbhACNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 08:48:54 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 103DhRZX123034;
        Sun, 3 Jan 2021 08:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=SkZQp9jW9i8QL+GRqBfKgF4UrMoMAnBuO7mxoDmp6KM=;
 b=T/axILhdxpWGoIgZz/krNq/WcIyAgs7U/n6c7tMk5lhIR8gEJFgd/9kUja12g8ETyiik
 EbXlrCbwUuZ50dU9fuHg5Y5D3EHwYqZjeAvrlmg1ed8+Nywz0nc415W+ZxK+ml/pVO2j
 8JWDuJ4DRTzvMz8jm+bqqzII94C9m2GEHiOgdpuoNkrz1peghQlmf/C0Urrq06+0ozm0
 0UX3ZKYBoqmOZYbrUAkRg8Y1f8bk1AQ4DIVxWBmuGHtp2g4ATUnnGu85JpGFisvy8Z9Q
 DYTOaFyIUGNQLEiS5dNh5XW6UkQB8mXx9Y8Z6BwWuxficUV+soD0bRqELAzdK9Qhqn/3 aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35uf2ag1kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jan 2021 08:48:02 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 103DlAq8133424;
        Sun, 3 Jan 2021 08:48:02 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35uf2ag1js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jan 2021 08:48:02 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 103DhsNl024119;
        Sun, 3 Jan 2021 13:47:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 35u3pmgcaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jan 2021 13:47:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 103Dlv9g37290336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Jan 2021 13:47:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35A8C11C04A;
        Sun,  3 Jan 2021 13:47:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FC6A11C04C;
        Sun,  3 Jan 2021 13:47:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.176.60])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  3 Jan 2021 13:47:55 +0000 (GMT)
Date:   Sun, 3 Jan 2021 15:47:53 +0200
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
Message-ID: <20210103134753.GC832698@linux.ibm.com>
References: <5fd3e5d9.1c69fb81.f9e69.5028@mx.google.com>
 <127999c4-7d56-0c36-7f88-8e1a5c934cae@collabora.com>
 <20201213082314.GA198221@linux.ibm.com>
 <0633d44a-3796-8a1b-e5dc-99fc62aa4dc7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0633d44a-3796-8a1b-e5dc-99fc62aa4dc7@collabora.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-03_06:2020-12-31,2021-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101030082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 09:59:26PM +0000, Guillaume Tucker wrote:
> On 13/12/2020 08:23, Mike Rapoport wrote:
> > Hi Guillaume,
> > 
> > On Fri, Dec 11, 2020 at 09:53:46PM +0000, Guillaume Tucker wrote:
> >> Hi Mike,
> >>
> 
> OK, sorry for the delay.  I've built a kernel and booted it as
> you requested, and also found that the issue was due to this
> memory area defined in arch/arm/boot/dts/rk3288.dtsi:
> 
>         reserved-memory {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges;
> 
>                 /*
>                  * The rk3288 cannot use the memory area above 0xfe000000
>                  * for dma operations for some reason. While there is
>                  * probably a better solution available somewhere, we
>                  * haven't found it yet and while devices with 2GB of ram
>                  * are not affected, this issue prevents 4GB from booting.
>                  * So to make these devices at least bootable, block
>                  * this area for the time being until the real solution
>                  * is found.
>                  */
>                 dma-unusable@fe000000 {
>                         reg = <0x0 0xfe000000 0x0 0x1000000>;
>                 };
>         };
> 
> So I've put a hack[1] on top of 950c37691925 to skip adding a
> node in memblock_enforce_memory_reserved_overlap() if the base
> address is 0xfe000000, which got the kernel booting.  Here's the
> console log:
> 
>   https://people.collabora.com/~gtucker/tmp/2966825.txt
> 
> and the full test job details, if this helps:
> 
>   https://lava.collabora.co.uk/scheduler/job/2966825
> 
> 
> I haven't really looked much further than that, but I'll be
> available on Monday to help run other tests if needed.

Sorry for the delay, I was mostly offline for the last three weeks.

Thanks for the logs, it seems that implicitly adding reserved regions to
memblock.memory wasn't that bright idea :)
 
> Thanks,
> Guillaume
> 
> [1] https://people.collabora.com/~gtucker/tmp/2966825.patch

-- 
Sincerely yours,
Mike.
