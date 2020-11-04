Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262A32A6D97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgKDTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:11:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11782 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731243AbgKDTLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:11:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4J1IjH073873;
        Wed, 4 Nov 2020 14:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=DqOTob3AwioDey1KiiTHJajU7QOQhnFPsLrIyrA03QM=;
 b=RvC4QqbrScz4QENf1PHdPxBcKDU5n2FIBj2ssUmQuBrpucJrF/EC6f+gqJ0IqWwiTzF+
 IYjQ6oT18g5PmH3TPwAFGr3sSrJgToDdYoVtBa+uzfSj5lK1S0Ln9hLJOTI58ExrpG4c
 0jyOLIMdcy91tw1nPiUREjZno2/YNUZNJDhWo6SxPOiImv916k1wcthWEjBraK3U5saF
 OxMxMBtUZ5E/IdVHrsIc9eiSSneD7vg3nb3Vy26wZaQE25LpYesJn8EGo+6xM3SiIsx5
 /6IgeYntkwPvKFhOggYS5epVszKViInzMUOr0qDrnHFANLd6r+jBzftbtQFRNld6R/WJ 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kga5sp22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 14:11:13 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A4J1daw075836;
        Wed, 4 Nov 2020 14:11:13 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kga5sp14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 14:11:12 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A4J7FfV021411;
        Wed, 4 Nov 2020 19:11:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 34h0fcvn3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 19:11:10 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A4JB8vK7209622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 19:11:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B5764C044;
        Wed,  4 Nov 2020 19:11:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17A034C040;
        Wed,  4 Nov 2020 19:11:07 +0000 (GMT)
Received: from localhost (unknown [9.145.163.252])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Nov 2020 19:11:06 +0000 (GMT)
Date:   Wed, 4 Nov 2020 20:11:05 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 16/41] kasan: rename KASAN_SHADOW_* to KASAN_GRANULE_*
Message-ID: <your-ad-here.call-01604517065-ext-2603@work.hours>
References: <cover.1604333009.git.andreyknvl@google.com>
 <4dee872cf377e011290bbe2e90c7e7fd24e789dd.1604333009.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dee872cf377e011290bbe2e90c7e7fd24e789dd.1604333009.git.andreyknvl@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_12:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 priorityscore=1501 suspectscore=1 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:03:56PM +0100, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> The new mode won't be using shadow memory, but will still use the concept
> of memory granules. Each memory granule maps to a single metadata entry:
> 8 bytes per one shadow byte for generic mode, 16 bytes per one shadow byte
> for software tag-based mode, and 16 bytes per one allocation tag for
> hardware tag-based mode.
> 
> Rename KASAN_SHADOW_SCALE_SIZE to KASAN_GRANULE_SIZE, and KASAN_SHADOW_MASK
> to KASAN_GRANULE_MASK.
> 
> Also use MASK when used as a mask, otherwise use SIZE.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---
> Change-Id: Iac733e2248aa9d29f6fc425d8946ba07cca73ecf
> ---
>  Documentation/dev-tools/kasan.rst |  2 +-
>  lib/test_kasan.c                  |  2 +-
>  mm/kasan/common.c                 | 39 ++++++++++++++++---------------
>  mm/kasan/generic.c                | 14 +++++------
>  mm/kasan/generic_report.c         |  8 +++----
>  mm/kasan/init.c                   |  8 +++----
>  mm/kasan/kasan.h                  |  4 ++--
>  mm/kasan/report.c                 | 10 ++++----
>  mm/kasan/tags_report.c            |  2 +-
>  9 files changed, 45 insertions(+), 44 deletions(-)

hm, this one got escaped somehow

lib/test_kasan_module.c:
18 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_SHADOW_SCALE_SIZE)
