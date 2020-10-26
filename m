Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E83229969B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792682AbgJZTOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1737870AbgJZTJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603739388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRCWYmAWusObW3DmkzU8vx+MJL5tF/gHRsDlDMiPyg4=;
        b=ekmGaHbfCbHEUfIrsRa9b71sRk0ToC7eTt/XW+ok1Hz09Y6tDYia+2VvE3WSMRjfB7ssuT
        e0Oj9pgeQms1eWvtPMZsYVjiw0fkneg0tTaptufhhOL0Z5kSaxEmLllcCcKzDWKZ78bdeV
        tZoSh2t3KWLx6qufpXJcNnMwbOT1Ceg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-jBf1HKB-Oamf1jy_jvpfvg-1; Mon, 26 Oct 2020 15:09:47 -0400
X-MC-Unique: jBf1HKB-Oamf1jy_jvpfvg-1
Received: by mail-ej1-f70.google.com with SMTP id lf18so5869801ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=GRCWYmAWusObW3DmkzU8vx+MJL5tF/gHRsDlDMiPyg4=;
        b=F6JLgrUkD+YTmFOOmYni2v9tX7ELQ4Gh5ZBGgBV3lgCzkhy14NbiqjDvbFV1KkW5p5
         RQUUxu7UAAeOcM1S4Qh+pIAnunTSjaBpyHbLKFg+5W8Gzxwg+zfc4lzlvV65y5+oL3bf
         WzVLtsXiqLOndC8zKzoMHEniTCEX5jCL9dbmche8OkSpucakEM6lLRUEcJFT9SueHvWq
         YNtW9uYMQLEIOthe+F7YldFxLXT1poYsA3AxktPsPLT2ObRktxqH23r8ij9VcaPRKC3q
         a+rMZutOmIDZwr7brLXFgupEun+rCmdEBqKlnwZvb3gK8r3VEP3PIsoQ7ioYY6RJe9TM
         c2ig==
X-Gm-Message-State: AOAM530Qcnf03kxoqpQe3a3PrfNVawgE7MyNVHF2hqL6gin/1tEUUYNl
        smUmmq+gTAcL57pbv6my2q+bmoKD2e7FaRdDaymKDSFU5EMlCp4jOFESc5+2pcA4Dbvw9yxhdN2
        Ejf5eFTGY/aczaSH+f0+jAqhD
X-Received: by 2002:a17:906:354e:: with SMTP id s14mr16798389eja.192.1603739385287;
        Mon, 26 Oct 2020 12:09:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznkiGK/Teq401W0nYH6JzAXZopru82dXZyVaTY6B+fMBJZqPrTlL20E6eCMzLCLBggU7oWzQ==
X-Received: by 2002:a17:906:354e:: with SMTP id s14mr16798339eja.192.1603739384950;
        Mon, 26 Oct 2020 12:09:44 -0700 (PDT)
Received: from [192.168.3.114] (p5b0c6a8b.dip0.t-ipconnect.de. [91.12.106.139])
        by smtp.gmail.com with ESMTPSA id 11sm6384639ejy.19.2020.10.26.12.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 12:09:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [mm/page_alloc] 7fef431be9: vm-scalability.throughput 87.8% improvement
Date:   Mon, 26 Oct 2020 20:09:43 +0100
Message-Id: <494C73E0-452D-4503-8ED6-DAE11A8471E5@redhat.com>
References: <CAJHvVcj1NToZO9ZoyWZKWzCe2jMOrLjLAxESiD84Q_V+8er9Ag@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Kevin Ko <kevko@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
In-Reply-To: <CAJHvVcj1NToZO9ZoyWZKWzCe2jMOrLjLAxESiD84Q_V+8er9Ag@mail.gmail.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 26.10.2020 um 19:11 schrieb Axel Rasmussen <axelrasmussen@google.com>:
>=20
> =EF=BB=BFOn Mon, Oct 26, 2020 at 1:31 AM David Hildenbrand <david@redhat.c=
om> wrote:
>>=20
>>> On 23.10.20 21:44, Axel Rasmussen wrote:
>>> On Fri, Oct 23, 2020 at 12:29 PM David Rientjes <rientjes@google.com> wr=
ote:
>>>>=20
>>>> On Wed, 21 Oct 2020, kernel test robot wrote:
>>>>=20
>>>>> Greeting,
>>>>>=20
>>>>> FYI, we noticed a 87.8% improvement of vm-scalability.throughput due t=
o commit:
>>>>>=20
>>>>>=20
>>>>> commit: 7fef431be9c9ac255838a9578331567b9dba4477 ("mm/page_alloc: plac=
e pages to tail in __free_pages_core()")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master=

>>>>>=20
>>>>>=20
>>>>> in testcase: vm-scalability
>>>>> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30=
GHz with 192G memory
>>>>> with following parameters:
>>>>>=20
>>>>>      runtime: 300s
>>>>>      size: 512G
>>>>>      test: anon-wx-rand-mt
>>>>>      cpufreq_governor: performance
>>>>>      ucode: 0x5002f01
>>>>>=20
>>>>> test-description: The motivation behind this suite is to exercise func=
tions and regions of the mm/ of the Linux kernel which are of interest to us=
.
>>>>> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalabil=
ity.git/
>>>>>=20
>>>>=20
>>>> I'm curious why we are not able to reproduce this improvement on Skylak=
e
>>>> and actually see a slight performance degradation, at least for
>>>> 300s_128G_truncate_throughput.
>>>>=20
>>>> Axel Rasmussen <axelrasmussen@google.com> can provide more details on o=
ur
>>>> results.
>>>=20
>>> Right, our results show a slight regression on a Skylake machine [1],
>>> and a slight performance increase on a Rome machine [2]. For these
>>> tests, I used Linus' v5.9 tag as a baseline, and then applied this
>>> patchset onto that tag as a test kernel (the patches applied cleanly
>>> besides one comment, I didn't have to do any code fixups). This is
>>> running the same anon-wx-rand-mt test defined in the upstream
>>> lkp-tests job file:
>>> https://github.com/intel/lkp-tests/blob/master/jobs/vm-scalability.yaml
>>=20
>> Hi,
>>=20
>> looking at the yaml, am I right that each test is run after a fresh boot?=

>=20
> Yes-ish. For the results I posted, the larger context would have been
> something like:
>=20
> - Kernel installed, machine freshly rebooted.
> - Various machine management daemons start by default, some are
> stopped so as not to interfere with the test.
> - Some packages are installed on the machine (the thing which
> orchestrates the testing in particular).
> - The test is run.
>=20
> So, the machine is somewhat fresh in the sense that it hasn't been
> e.g. serving production traffic just before running the test, but it's
> also not as clean as it could be. It seems plausible this difference
> explains the difference in the results (I'm not too familiar with how
> the Intel kernel test robot is implemented).

Ah, okay. So most memory in the system is indeed untouched. Thanks!


>=20
>>=20
>> As I already replied to David, this patch merely changes the initial
>> order of the freelists. The general end result is that lower memory
>> addresses will be allocated before higher memory addresses will be
>> allocated - within a zone, the first time memory is getting allocated.
>> Before, it was the other way around. Once a system ran for some time,
>> freelists are randomized.
>>=20
>> There might be benchmarks/systems where this initial system state might
>> now be better suited - or worse. It doesn't really tell you that core-mm
>> is behaving better/worse now - it merely means that the initial system
>> state under which the benchmark was started affected the benchmark.
>>=20
>> Looks like so far there is one benchmark+system where it's really
>> beneficial, there is one benchmark+system where it's slightly
>> beneficial, and one benchmark+system where there is a slight regression.
>>=20
>>=20
>> Something like the following would revert to the previous behavior:
>>=20
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 23f5066bd4a5..fac82420cc3d 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1553,7 +1553,9 @@ void __free_pages_core(struct page *page, unsigned
>> int order)
>>         * Bypass PCP and place fresh pages right to the tail, primarily
>>         * relevant for memory onlining.
>>         */
>> -       __free_pages_ok(page, order, FPI_TO_TAIL);
>> +       __free_pages_ok(page, order,
>> +                       system_state < SYSTEM_RUNNING ? FPI_NONE :
>> +                                                       FPI_TO_TAIL);
>> }
>>=20
>> #ifdef CONFIG_NEED_MULTIPLE_NODES
>>=20
>>=20
>> (Or better, passing the expected behavior via MEMINIT_EARLY/... to
>> __free_pages_core().)
>>=20
>>=20
>> But then, I am not convinced we should perform that change: having a
>> clean (initial) state might be true for these benchmarks, but it's far
>> from reality. The change in numbers doesn't show you that core-mm is
>> operating better/worse, just that the baseline for you tests changed due
>> to a changed initial system state.
>=20
> Not to put words in David's mouth :) but at least from my perspective,
> our original interest was "wow, an 87% improvement! maybe we should
> deploy this patch to production!", and I'm mostly sharing my results
> just to say "it actually doesn't seem to be a huge *general*
> improvement", rather than to advocate for further changes / fixes.

Ah, yes, I saw the +87% and thought =E2=80=9Ethat can=E2=80=98t be right=E2=80=
=9C.

> IIUC the original motivation for this patch was to fix somewhat of an
> edge case, not to make a very general improvement, so this seems fine.
>=20

Exactly.=

