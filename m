Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A85B302D51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbhAYVLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:11:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732372AbhAYVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:06:34 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10PL1165181067;
        Mon, 25 Jan 2021 16:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wMJkYZnn+DMx8Rf3CnK9AaJnCvK2vh8MmaFENL1GyyU=;
 b=Y0c63B67zEaHuzUp79ZKUCuHAXMK4pVJrFzoNWfMQ54Y3AY/0YNeqZJ2hSy1yp1aGsrM
 S4nil1Xb8mIV1jBOpNg31w2QUC0wbeSTHwy1GS3/6z/Lso4xS+saMzsubx+lEAralm8F
 kujHu/T9SViqPom8/ppslHple89TZopWYimy4AJWZCLxPgFc62sJGjVpRoTDzU/uhI+Y
 +XuKsRVTGb4H18Y9P5XtH6vSZTBjSRbE15sMuDXzt5hv9Dv2l69Z+AtMhDkIfNjFke1n
 wj1jdLg7MH3JJiwgd4KbyI/BRz7cRE70LwTlGBbk1hb8gATm6BanZgKgmO3ZVHANcFQr ig== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36a4d0hwpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 16:05:04 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10PKvnFZ017910;
        Mon, 25 Jan 2021 21:05:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 368be8a61m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 21:05:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10PL50Bb34341326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 21:05:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB49BA405B;
        Mon, 25 Jan 2021 21:05:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C623A4054;
        Mon, 25 Jan 2021 21:04:59 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.26.126])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Jan 2021 21:04:59 +0000 (GMT)
Date:   Mon, 25 Jan 2021 23:04:56 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc5
Message-ID: <20210125210456.GA196782@linux.ibm.com>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <161160687463.28991.354987542182281928@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161160687463.28991.354987542182281928@build.alporthouse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_09:2021-01-25,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 08:34:34PM +0000, Chris Wilson wrote:
> Quoting Linus Torvalds (2021-01-25 01:06:40)
> > Mike Rapoport (3):
> ...
> >       mm: fix initialization of struct page for holes in memory layout
> 
> We have half a dozen or so different machines in CI that are silently
> failing to boot, that we believe is bisected to this patch.
> 
> 17:56              tsa : ickle: dolphin: I hit the following patch in my bisection, and the hang is also dependent on kconfig
> 17:56              tsa : first bad commit: [d3921cb8be29ce5668c64e23ffdaeec5f8c69399] mm: fix initialization of struct page for holes in
>                          memory layout
> 17:57              tsa : couldn't reproduce on older CI kconfig, current one does it
>                          https://gitlab.freedesktop.org/gfx-ci/i915-infra/-/blob/master/kconfig/debug
> 
> Here's a boot dmesg from some affected machines from just before the merge
> with rc5:
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/shard-skl1/boot18.txt
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-skl-6600u/boot.html
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-bsw-cyan/boot.html
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-bdw-samus/boot.html

Is there any way to get early console from these machines?

> -Chris

-- 
Sincerely yours,
Mike.
