Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC67304603
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394126AbhAZSKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:10:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727289AbhAZQjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:39:33 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10QGVtw1003687;
        Tue, 26 Jan 2021 11:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ZA69SfO+UB85h74Gw14O6OprcnXQbu2Fy0v64u0OXTs=;
 b=QZFJVIydknZBBLMUIzXL12iJrFc4Wq5USO9C+dvb0o408/YlkD7zlwfx7/gM7ETLr+f7
 myFVBNW5S75Suwa9NZWmyoYNV8HZT5g5Qrutzc/l78gZdAp0KZgQuG4YXvbTBOeqS8hU
 +JJj/5rGKDm/N9XdVmt0xha/ZjjPofxOmHcYj4a08qAblDojG3ISPALJsKJvxZE1V7rT
 YsySaI8ilpYqA5emeqvlSX4Wejc4HWB/BqUoxmzBmqLUMeaRntBCltxHvQ2QBx3LZLJw
 F9Cz8+gRnBAGDmzIAwDe4tNFjT8ULdZUQGs98FSKRFfRJQd9IIUsjBA1MN79DS9CQPsm Eg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36apd7gr8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 11:38:07 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10QGI1Mk002943;
        Tue, 26 Jan 2021 16:38:05 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 368be81j1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 16:38:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10QGc2Ld45547912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 16:38:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90B8EAE053;
        Tue, 26 Jan 2021 16:38:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE2A0AE051;
        Tue, 26 Jan 2021 16:38:01 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.26.126])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Jan 2021 16:38:01 +0000 (GMT)
Date:   Tue, 26 Jan 2021 18:37:59 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc5
Message-ID: <20210126163759.GD196782@linux.ibm.com>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <161160687463.28991.354987542182281928@build.alporthouse.com>
 <20210125210456.GA196782@linux.ibm.com>
 <161160923954.29150.8571056944016500691@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161160923954.29150.8571056944016500691@build.alporthouse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_08:2021-01-26,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 09:13:59PM +0000, Chris Wilson wrote:
> Quoting Mike Rapoport (2021-01-25 21:04:56)
> > On Mon, Jan 25, 2021 at 08:34:34PM +0000, Chris Wilson wrote:
> > > Quoting Linus Torvalds (2021-01-25 01:06:40)
> > > > Mike Rapoport (3):
> > > ...
> > > >       mm: fix initialization of struct page for holes in memory layout
> > > 
> > > We have half a dozen or so different machines in CI that are silently
> > > failing to boot, that we believe is bisected to this patch.
> > > 
> > > 17:56              tsa : ickle: dolphin: I hit the following patch in my bisection, and the hang is also dependent on kconfig
> > > 17:56              tsa : first bad commit: [d3921cb8be29ce5668c64e23ffdaeec5f8c69399] mm: fix initialization of struct page for holes in
> > >                          memory layout
> > > 17:57              tsa : couldn't reproduce on older CI kconfig, current one does it
> > >                          https://gitlab.freedesktop.org/gfx-ci/i915-infra/-/blob/master/kconfig/debug
> > > 
> > > Here's a boot dmesg from some affected machines from just before the merge
> > > with rc5:
> > > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/shard-skl1/boot18.txt
> > > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-skl-6600u/boot.html
> > > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-bsw-cyan/boot.html
> > > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-bdw-samus/boot.html
> > 
> > Is there any way to get early console from these machines?
> 
> 12:16 tsa : none of those have good hook for serial
> 
> Nothing on the console and no serial console option, and panics before
> netconsole.
> 
> Maybe some early_printk and boot_delay if you think there's something to
> see with those, but I'll have to ask Tomi nicely tomorrow.

I think there could be an early panic at some point of mm initialization.
So if it was possible to see early printks somehow that would have been
helpful. 

> -Chris

-- 
Sincerely yours,
Mike.
