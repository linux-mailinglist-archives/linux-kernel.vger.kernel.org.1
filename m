Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D1F2A6DED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbgKDTbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:31:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731561AbgKDTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:31:07 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4J38xR010691;
        Wed, 4 Nov 2020 14:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=kqKl/Fy8OlJQj/Gv88agH7/I5WU7KGmVdKg9ghw1xjE=;
 b=axlsn2DRWHDAS1wDGm5KQ2jnhCI2uU7k639SaPpAjB8Z+DVxulOkpAMQ1G/H5twIxT5e
 9PRqMtQtX5M4rqSTIMf4U+Q+6c/JT/NjOBDbavk00Qie57PBy7U1zHmLj4cZpN+Ft2U4
 nALH8GWZpYxVp4pFTLOx7zMROTMMUEH18i1y6p7XpS+m8O9SWD0UG0ENIeFoy0oDa0x6
 xDuCD5bo1uJjojo5EpBeiCNMFVPdxV29En81C9QKwkGYZkWuqQHycGAGu47txBVnPT57
 Qj7WIg5ZLz8mRYWytWSsGErDtthbiBPn5q5xt5zEG2TlbvhScOmiLNOslB/C0MX+8s3Q DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m0qck9gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 14:30:54 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A4J3INU011124;
        Wed, 4 Nov 2020 14:30:53 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m0qck9ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 14:30:53 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A4JRnj4026068;
        Wed, 4 Nov 2020 19:30:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 34j8rh9jk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 19:30:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A4JUjQb60424536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 19:30:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 544FF4C04A;
        Wed,  4 Nov 2020 19:30:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4925A4C044;
        Wed,  4 Nov 2020 19:30:44 +0000 (GMT)
Received: from localhost (unknown [9.145.163.252])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Nov 2020 19:30:44 +0000 (GMT)
Date:   Wed, 4 Nov 2020 20:30:42 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 16/41] kasan: rename KASAN_SHADOW_* to KASAN_GRANULE_*
Message-ID: <your-ad-here.call-01604518242-ext-7611@work.hours>
References: <cover.1604333009.git.andreyknvl@google.com>
 <4dee872cf377e011290bbe2e90c7e7fd24e789dd.1604333009.git.andreyknvl@google.com>
 <your-ad-here.call-01604517065-ext-2603@work.hours>
 <CAAeHK+wuJ5HuGgyor903VcBJSx8sUewJqmhA_nsbVbw0h2UFXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAeHK+wuJ5HuGgyor903VcBJSx8sUewJqmhA_nsbVbw0h2UFXg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_12:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 08:22:07PM +0100, Andrey Konovalov wrote:
> On Wed, Nov 4, 2020 at 8:11 PM Vasily Gorbik <gor@linux.ibm.com> wrote:
> >
> > On Mon, Nov 02, 2020 at 05:03:56PM +0100, Andrey Konovalov wrote:
> > > This is a preparatory commit for the upcoming addition of a new hardware
> > > tag-based (MTE-based) KASAN mode.
> > >
> > > The new mode won't be using shadow memory, but will still use the concept
> > > of memory granules. Each memory granule maps to a single metadata entry:
> > > 8 bytes per one shadow byte for generic mode, 16 bytes per one shadow byte
> > > for software tag-based mode, and 16 bytes per one allocation tag for
> > > hardware tag-based mode.
> > >
> > > Rename KASAN_SHADOW_SCALE_SIZE to KASAN_GRANULE_SIZE, and KASAN_SHADOW_MASK
> > > to KASAN_GRANULE_MASK.
> > >
> > > Also use MASK when used as a mask, otherwise use SIZE.
> > >
> > > No functional changes.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > Reviewed-by: Marco Elver <elver@google.com>
> > > ---
> > > Change-Id: Iac733e2248aa9d29f6fc425d8946ba07cca73ecf
> > > ---
> > >  Documentation/dev-tools/kasan.rst |  2 +-
> > >  lib/test_kasan.c                  |  2 +-
> > >  mm/kasan/common.c                 | 39 ++++++++++++++++---------------
> > >  mm/kasan/generic.c                | 14 +++++------
> > >  mm/kasan/generic_report.c         |  8 +++----
> > >  mm/kasan/init.c                   |  8 +++----
> > >  mm/kasan/kasan.h                  |  4 ++--
> > >  mm/kasan/report.c                 | 10 ++++----
> > >  mm/kasan/tags_report.c            |  2 +-
> > >  9 files changed, 45 insertions(+), 44 deletions(-)
> >
> > hm, this one got escaped somehow
> >
> > lib/test_kasan_module.c:
> > 18 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_SHADOW_SCALE_SIZE)
> 
> You mean it's not on the patch? It is, almost at the very top.

lib/test_kasan_module.c != lib/test_kasan.c

I fetched your branch. And I had to fix it up to build old good kasan
test module CONFIG_TEST_KASAN_MODULE=m
