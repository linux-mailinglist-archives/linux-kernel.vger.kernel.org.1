Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555002A2999
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgKBLeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:34:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbgKBLeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:34:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2BXo1I042508;
        Mon, 2 Nov 2020 06:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=yVfGJj6N4god5EORBV4psCRzp8EdrnwowyI5GZT39ag=;
 b=jVpcUcKv+olpOAEePgROI/sfGAqaFNQC/B8Bsrb/z4FnLw6pNmAnVpgXJ3TM7s8so36O
 omF5kuNBOos03W0+ZUsdc5vzuttCNiasaBxIyzogOsU4nIougeU5IUI/2NtrJzRvcOFG
 R0gdY5OUTi2izEdIGHv56enOCC7+jqGOhWh3wsYh4sM4dxD5WdhYmzcDqZmjQd5K62+A
 ryHqouchl4leI+zZMcPBQEkbHaQ8hdbukG7fzj1+EoLhxOOf92e9FDbnMb9Db2m1PniZ
 7dyXFjK7LO0DopQpQWXS4Khw8G+MAZ88XeegMocAOlNmE02y4rSl37OY7JAXYnN7XIVW cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jaw9v5cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 06:34:03 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A2BY2lv043652;
        Mon, 2 Nov 2020 06:34:02 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jaw9v4sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 06:34:02 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A2BTRb8002171;
        Mon, 2 Nov 2020 11:33:13 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 34h01kh1t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 11:33:13 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A2BXBQM65405390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Nov 2020 11:33:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16E6D4C04A;
        Mon,  2 Nov 2020 11:33:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23C9D4C050;
        Mon,  2 Nov 2020 11:33:09 +0000 (GMT)
Received: from in.ibm.com (unknown [9.85.70.13])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Nov 2020 11:33:08 +0000 (GMT)
Date:   Mon, 2 Nov 2020 17:03:06 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@linux.com,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, shakeelb@google.com,
        hannes@cmpxchg.org, aneesh.kumar@linux.ibm.com
Subject: Re: Higher slub memory consumption on 64K page-size systems?
Message-ID: <20201102113306.GA584494@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20201028055030.GA362097@in.ibm.com>
 <20201029000757.GE827280@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029000757.GE827280@carbon.dhcp.thefacebook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_07:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=1
 adultscore=0 phishscore=0 mlxlogscore=794 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 05:07:57PM -0700, Roman Gushchin wrote:
> On Wed, Oct 28, 2020 at 11:20:30AM +0530, Bharata B Rao wrote:
> > I have mostly looked at reducing the slab memory consumption here.
> > But I do understand that default tunable values have been arrived
> > at based on some benchmark numbers. Are there ways or possibilities
> > to reduce the slub memory consumption with the existing level of
> > performance is what I would like to understand and explore.
> 
> Hi Bharata!
> 
> I wonder how the distribution of the consumed memory by slab_caches
> differs between 4k and 64k pages. In particular, I wonder if
> page-sized and larger kmallocs make the difference (or a big part of it)?
> There are many places in the kernel which are doing something like
> kmalloc(PAGE_SIZE).

Here is comparision of topmost slabs in terms of memory usage b/n
4K and 64K configurations:

Case 1: After boot
==================
4K page-size
------------
Name                   Objects Objsize           Space Slabs/Part/Cpu  O/S O %Fr %Ef Flg
inode_cache              23382     592           14.1M       400/0/33   54 3   0  97 a
dentry                   29484     192            5.7M      592/0/110   42 1   0  98 a
kmalloc-1k                5358    1024            5.6M       130/9/42   32 3   5  97
task_struct                371    9856            4.1M        88/6/40    3 3   4  87
kmalloc-512               6640     512            3.4M       159/3/49   32 2   1  99
...
kmalloc-4k                 530    4096            2.2M        42/6/27    8 3   8  96

64K page-size
-------------
pgtable-2^11               935   16384           38.7M       16/16/58   16 3  21  39
inode_cache              23980     592           14.4M       203/0/17  109 0   0  98 a
thread_stack               709   16384           12.0M         6/1/17   32 3   4  96
task_struct               1012    9856           10.4M         4/1/16   53 3   5  95
kmalloc-64k                144   65536            9.4M         2/0/16    8 3   0 100

Case 2: After hackbench run
===========================
4K page-size
------------
inode_cache              21823     592           13.3M       361/3/46   54 3   0  96 a
kmalloc-512              10309     512            9.4M    433/325/146   32 2  56  55
kmalloc-1k                6207    1024            6.5M      121/12/78   32 3   6  97
dentry                   28923     192            5.9M     468/48/261   42 1   6  92 a
task_struct                418    9856            5.1M      106/24/51    3 3  15  80
...
kmalloc-4k                 510    4096            2.1M       41/10/26    8 3  14  95

64K page-size
-------------
kmalloc-8k                3081    8192           84.9M     241/241/83   32 2  74  29
thread_stack              2919   16384           52.4M       15/10/85   32 3  10  91
pgtable-2^11              1281   16384           50.8M       20/20/77   16 3  20  41
task_struct               3771    9856           40.3M         9/6/68   53 3   7  92
vm_area_struct           92295     200           18.9M        8/8/281  327 0   2  97
...
kmalloc-64k                144   65536            9.4M         2/0/16    8 3   0 100

I can't see any specific pattern wrt to kmalloc cache usage in both the
above cases (boot vs hackbench run). In the boot case, the 64K configuration
consuming more memory can be attributed probably to the bigger page size
itself. However in case of hackbench run, any significant number of
partial slabs does contribute to significant increase of memory for
64K configuration.

> 
> Re slub tuning: in general we do care about the number of objects
> in a partial list, less about the number of pages. If we can have the
> same amount of objects but on fewer pages, it's even better.

Right, but how do we achieve that when few number of inuse objects are
spread across a number of partial slabs? This specifically is the case
we see after a workload run (hackbench in this case)

> So I don't see any reasons why we shouldn't scale down these tunables
> if the PAGE_SIZE > 4K.
> Idk if it makes sense to switch to byte-sized tunables or just to hardcode
> custom default values for the 64k page case. The latter is probably
> is easier.

Right, tuning the mininum number of objects when calculating the page order
of the slab and tuning cpu_partial value show some consistent reduction
in the slab memory consumption. (I have shown this in previous mail)

Thanks for your comments.

Regards,
Bharata.
