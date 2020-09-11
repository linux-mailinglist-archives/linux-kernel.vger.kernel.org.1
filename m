Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F35B2664FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgIKQtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:49:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726354AbgIKPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:06:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BF0v2I136410;
        Fri, 11 Sep 2020 11:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=L9u52kqglNAlDmKFeKdTrYzGX2ERFWSzIfwYTv7pLYs=;
 b=DYFNUHxpK6xsBhFFhx1qo16oj2XcrV2C3bCpHBF6PW1uj11L72j65d6jdU0pPzj3rEXj
 83wvfjwaWB9KvqzqSFGxDBd3tAwweiM0O+0zIkKjXQCvyHriZLoFOfw0i4HWt+foyeHk
 /svF4CR2Jp3N6skx0iIRlgnkdkZB+YSJ8dcoJ1AjCVC30/oflYxVlTVEv137glzSmWC6
 hNjgfhuj1bJIoJudZ7aVm1Ea2sFCkYNqZUKBdbDCZ7NN/RKkm8YO7P2Wc4N0ytVCrbTx
 jf7vtg1/uzf2QPGgj5bj4jsvoGVoYhANNCIlySN909PrROzqRkffFWUBy1V59FTqymFD 0g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33g99bvwfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 11:06:22 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BF2qeh009881;
        Fri, 11 Sep 2020 15:06:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8fbwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 15:06:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BF6Je821954862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 15:06:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF75D4C058;
        Fri, 11 Sep 2020 15:06:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 914F54C040;
        Fri, 11 Sep 2020 15:06:18 +0000 (GMT)
Received: from [9.145.176.58] (unknown [9.145.176.58])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 15:06:18 +0000 (GMT)
Subject: Re: [PATCH -rc v1] gcov: Disable gcov build with GCC 10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
References: <20200904155808.4997-1-leon@kernel.org>
 <6fac3754-f8db-85f5-bdb1-b4c8e7ccc046@linux.ibm.com>
 <CAHk-=wg6R-yQwZBBWB8EqQ1QWJGQe5njuGwax-HJtTUGsc5LxQ@mail.gmail.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <69094ef2-4c35-32e0-9098-64713ef21cf7@linux.ibm.com>
Date:   Fri, 11 Sep 2020 17:06:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg6R-yQwZBBWB8EqQ1QWJGQe5njuGwax-HJtTUGsc5LxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_05:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=1
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding GCC's gcov maintainer Martin Liška)

On 10.09.2020 21:18, Linus Torvalds wrote:
> On Thu, Sep 10, 2020 at 5:52 AM Peter Oberparleiter
> <oberpar@linux.ibm.com> wrote:
>>
>> Fix this by updating the in-kernel GCOV_COUNTERS value. Also re-enable
>> config GCOV_KERNEL for use with GCC 10.
> 
> Lovely.
> 
> Is there some way we could see this value automatically, or at least
> have a check for it? Right now it's that _very_ magical number that
> depends on a gcc version in odd and undocumented ways..

I don't think there is, except for maybe parsing GCC debuginfo files
which I would consider an extreme prereq for compiling a kernel with
gcov support. Also GCOV_COUNTERS is only one part of the problem - any
change to struct gcov_info could have a similar effect.

> IOW - I'm assuming user space gcov infrastructure finds this number
> some way, and wondering if we couldn't do the same?
> 
> Or is the gcov tool itself just doing the same kind of thing, and
> having magic numbers?

Short answer: GCC compiles this number into GCC and the associated GCC
library and requires that only matching versions are used. The gcov_info
definition is not available outside the GCC source tree.

Longer answer:

When GCC is called to compile a program with coverage profiling support
it adds inline profiling code and data to the resulting assembler
output. This profiling code updates in-memory counters during program
execution and calls GCC library functions (libgcov) to - among other
things - register the gcov_info data and to write out the resulting data
file when the program terminates. The gcov tool consumes this data file
format, which is different from the in-memory gcov_info data.

The gcov kernel support emulates portions of libgcov - it receives the
gcov_info struct during initial registration, and creates a gcov data
file in debugfs for consumption by the gcov tool.

> I get the feeling that somebody who knows gcov would go "You are just
> doing this all completely incorrectly, you should do XYZ" when they
> see that GCOV_COUNTERS thing.

@Martin: would you care to comment from a GCC point of view?

> Maybe just a script that finds the right header file in the gcc
> installation and extracts it from there, if only to verify the magic
> number that we have?

The next best thing that comes to my mind would be a build-time script
that checks the size of the gcov_info struct generated by GCC and
compare that to the size of the kernel's gcov_info for that GCC version
(by parsing assembler output). This could catch some common classes of
changes to gcov_info, while not restricting usage of gcov kernel support
too much when gcov_info doesn't change (as was the case e.g. between GCC
7 and 9).

The "next worst thing" would be to disable CONFIG_GCOV_KERNEL for
unknown GCC versions until someone tests it and updates the associated
Kconfig file. This catches all changes, but at the cost of possibly
unnecessarily restricting GCC versions plus requiring regular
gcov-kernel updates.


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
