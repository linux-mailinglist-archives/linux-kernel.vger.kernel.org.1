Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B7A3043D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392899AbhAZQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:28:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392864AbhAZQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:26:15 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10QGP8IQ066031;
        Tue, 26 Jan 2021 11:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=OJFcPo7KRFHWnjGUhiBMcFlh9LaHSGlEnWElzgmfBWg=;
 b=Tsm8LKeu+ZSCaVK1hbNPWLn0TRxsUp+Mu0TeN7BuWUlhVnftKLkeHt03zSR1kdmPilza
 4uuKNHOfUfLS/1wEFwC3PLj1gS+o1dSUdCZj7rOSwBgnQncfc3hQ12x1iX1K+ZlwBKUD
 BM0craamvv8MII6vOURjbKegH9WjS01KXzxBjFO5HhkBtuR9E3GXoot2dD09JL24Yosn
 YiDBNneYHe1dKuz6T1X4omvSPu/RC7NgwJpMGYOxhSR/Aa6A09aFcBR4Y/q+DryXn5S8
 ZTqPbx2b/s8stXzBjF/ymkS4wtGgzGuZAkgAyxwiOYwnacGsb6gLODqYA22o4i/KWWAk ZA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36an2ruh38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 11:25:24 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10QGIAJL019997;
        Tue, 26 Jan 2021 16:24:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 368be89h80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 16:24:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10QGOjVU26280446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 16:24:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE56EA405C;
        Tue, 26 Jan 2021 16:24:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A550FA4054;
        Tue, 26 Jan 2021 16:24:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.26.126])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Jan 2021 16:24:43 +0000 (GMT)
Date:   Tue, 26 Jan 2021 18:24:40 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc5
Message-ID: <20210126162440.GC196782@linux.ibm.com>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <161160687463.28991.354987542182281928@build.alporthouse.com>
 <CAHk-=wh23BXwBwBgPmt9h2EJztnzKKf=qr5r=B0Hr6BGgZ-QDA@mail.gmail.com>
 <20210125213348.GB196782@linux.ibm.com>
 <161161117911.29150.13853544418926100149@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161161117911.29150.13853544418926100149@build.alporthouse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_08:2021-01-26,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 09:46:19PM +0000, Chris Wilson wrote:
> Quoting Mike Rapoport (2021-01-25 21:33:48)
> > On Mon, Jan 25, 2021 at 12:49:39PM -0800, Linus Torvalds wrote:
> > > On Mon, Jan 25, 2021 at 12:35 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > > >
> > > > Quoting Linus Torvalds (2021-01-25 01:06:40)
> > > > > Mike Rapoport (3):
> > > > ...
> > > > >       mm: fix initialization of struct page for holes in memory layout
> > > >
> > > > We have half a dozen or so different machines in CI that are silently
> > > > failing to boot, that we believe is bisected to this patch.
> > > 
> > > That commit reverts cleanly - so if you can verify that reverting it
> > > fixes your CI machines, I think that that's the right thing to do for
> > > now, unless Mike can figure out some obvious "Duh!" moment from your
> > > working dmesg.
> > 
> > Unfortunately not, at least at 11pm :(
> > Maybe tomorrow I'll have something smarter to say.
> 
> CI does confirm that the revert of d3921cb8be29 brings the machines back
> to life.

I still cannot see what could possibly go wrong, so let's revert
d3921cb8be29 for now and I'll continue to work with Chris to debug this.
   
> > > Mike: should we perhaps revert the first patch too (commit
> > > bde9cfa3afe4: "x86/setup: don't remove E820_TYPE_RAM for pfn 0")?

This change should be quite innocuous, we anyway never allocate pfn 0 but
treat 0 as memory start in many places.

> > I wonder, maybe actually this one is causing troubles?
> > 
> > Chris, would it be possible to check what happens if you revert only
> > bde9cfa3afe4?
> 
> Queued for CI, will be run in about an hour.
> -Chris

-- 
Sincerely yours,
Mike.
