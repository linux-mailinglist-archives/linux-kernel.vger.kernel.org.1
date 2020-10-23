Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E5F2977D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbgJWToz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754847AbgJWTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:44:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DC3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:44:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s22so2072593pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SuSvlV8seX3yqN9ZTKNWShrjxHmLbUvsGEYr4wFt5I=;
        b=SKIs5rSX0DEi3DSJABGBQzXD+iGH0qK2RUG3hz6LZSCHNrhglykD1fMPC4ukT/mUGm
         NLOVPD60s5NgtGZeHLp7Mea0Yq8KMLsyK2QL/bH900Knm95TYeFur4Oixzey6aF2aekK
         uwONVcsAZJgdS4nkWYgYtnujD8xodLhqhqIWOsmM1zGM+AHoh+/UW6AQYDtQs1cQlsFm
         nehauJLrCZgaPFJU7DTD9LQK+Wy8TG8kV/ALwShj9D5j8JRdeKR9bZ7q2wY9vTtSXfr5
         U7FHbFMf2L9WMsCmiOWMfHCrHGYVKn36d+bb0QvnzmIFAvXteLi3ecIi8vmCo5lfk+DA
         E5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SuSvlV8seX3yqN9ZTKNWShrjxHmLbUvsGEYr4wFt5I=;
        b=rJ+CtoNQD5owKE6ibgUI1XZgkMVeU8vQQ1ikb30hhSu+FLtlDbvpThTDmpbQ8JSJSm
         o00fg0eLVMWbPsomjwoZpUr5mzMA30CfGLSHrA+9mwWNoDpZnZvTWRGUSYkwXKetR6lK
         AbMt1dHfgW6ChRfRMiPUDJJHiHtVOnr2n7A4BUi2yBWyqVFD5JDWLj/W8kyMg9kfTugF
         DMplO0y1YHs0ViObUfDuJg/4vKxVKvbb4vv8HjAKLZr63uEMLFJRcAWR76yxFSWZS/X2
         E9F3qPHIBG7padGD+kPogp5dNZ2Rc/1jEorLITB4/+X6CEIx1eFpZBm+vzaz4OayDzuu
         aquA==
X-Gm-Message-State: AOAM530I1v3VpieIIPMDstIdcMvqNZL9UpGY1d++ORqgwKo8HPrKzVin
        Kd2MiC68ejFDhGBEXFfEdMhvcQhEh31xaY+TmJc09w==
X-Google-Smtp-Source: ABdhPJyY97YsMGmHGEzmSG+H8ob5n1tlntgEyN7vhHK1Mt8D+m8jootKHe2OtQbsLKYxsn58/5AX1AQpWq575ZchocU=
X-Received: by 2002:a17:90a:d317:: with SMTP id p23mr4287266pju.52.1603482291864;
 Fri, 23 Oct 2020 12:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201021092417.GP11647@shao2-debian> <alpine.DEB.2.23.453.2010231226310.1686635@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.23.453.2010231226310.1686635@chino.kir.corp.google.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 23 Oct 2020 12:44:14 -0700
Message-ID: <CAJHvVcicEcMw=0SL2cF1RR7-E_5RRfXa+PnChob7K7ujL4Y_6w@mail.gmail.com>
Subject: Re: [mm/page_alloc] 7fef431be9: vm-scalability.throughput 87.8% improvement
To:     David Rientjes <rientjes@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Kevin Ko <kevko@google.com>,
        David Hildenbrand <david@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 12:29 PM David Rientjes <rientjes@google.com> wrote:
>
> On Wed, 21 Oct 2020, kernel test robot wrote:
>
> > Greeting,
> >
> > FYI, we noticed a 87.8% improvement of vm-scalability.throughput due to commit:
> >
> >
> > commit: 7fef431be9c9ac255838a9578331567b9dba4477 ("mm/page_alloc: place pages to tail in __free_pages_core()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> >
> > in testcase: vm-scalability
> > on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> > with following parameters:
> >
> >       runtime: 300s
> >       size: 512G
> >       test: anon-wx-rand-mt
> >       cpufreq_governor: performance
> >       ucode: 0x5002f01
> >
> > test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> > test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> >
>
> I'm curious why we are not able to reproduce this improvement on Skylake
> and actually see a slight performance degradation, at least for
> 300s_128G_truncate_throughput.
>
> Axel Rasmussen <axelrasmussen@google.com> can provide more details on our
> results.

Right, our results show a slight regression on a Skylake machine [1],
and a slight performance increase on a Rome machine [2]. For these
tests, I used Linus' v5.9 tag as a baseline, and then applied this
patchset onto that tag as a test kernel (the patches applied cleanly
besides one comment, I didn't have to do any code fixups). This is
running the same anon-wx-rand-mt test defined in the upstream
lkp-tests job file:
https://github.com/intel/lkp-tests/blob/master/jobs/vm-scalability.yaml

I'm happy to provide any other information that might be useful, like
the kconfig I used, or some logs from the test itself.

[1]:

[*] KERNELS
----- BASE KERNEL (A) -----
Arch: x86_64
CommitId: bbf5c979011a099af5dc76498918ed7df445635b
Describe: v5.9

----- TEST KERNEL (B) -----
Arch: x86_64
CommitId: 0eed18403b89d685c736fd41d83312bc18d1fc74
Describe: v5.9-5-g0eed18403b89


[*] TAGS
              LABEL             |      VALUE
--------------------------------+-------------------
  kernel_version                | 5.9.0-smp-DEV
  kernel_version_major          | 5
  kernel_version_minor          | 9
  machine_architecture          | x86_64
  machine_config_memory         | 393216
  machine_config_num_cores      | 112
  machine_config_num_cpus       | 2
  machine_config_num_phys_cores | 56
  machine_platform_genus        | skylake
  test_name                     | vm-scalability



[*] METRICS
                 LABEL                 | COUNT |       MIN        |
   MAX       |       MEAN        |      MEDIAN      |        STDDEV
     | DIRECTION
---------------------------------------+-------+------------------+-----------------+-------------------+------------------+-----------------------+------------
  300s_128G_truncate_throughput        |       |                  |
             |                   |                  |
     |
  (A) bbf5c979011a                     | 5     | 3.7552221368e+10 |
3.881560468e+10 | 3.83416430016e+10 | 3.8676061688e+10 |
5.123384177998683e+08 |
  (B) 0eed18403b89                     | 5     | 3.20600355e+10   |
3.862106519e+10 | 3.6402760077e+10  | 3.7563289678e+10 |
2.334955983229862e+09 |
                                       |       | -14.63%          |
-0.50%          | -5.06%            | -2.88%           | +355.74%
        | + is good
  300s_512G_anon_wx_rand_mt_throughput |       |                  |
             |                   |                  |
     |
  (A) bbf5c979011a                     | 5     | 8.127738e+06     |
8.850316e+06    | 8.4767952e+06     | 8.49689e+06      |
238015.6101665603     |
  (B) 0eed18403b89                     | 5     | 7.997802e+06     |
8.650092e+06    | 8.3851078e+06     | 8.501602e+06     |
232913.70310602157    |
                                       |       | -1.60%           |
-2.26%          | -1.08%            | +0.06%           | -2.14%
        | + is good

[2]:

[*] KERNELS
----- BASE KERNEL (A) -----
Arch: x86_64
CommitId: bbf5c979011a099af5dc76498918ed7df445635b
Describe: v5.9

----- TEST KERNEL (B) -----
Arch: x86_64
CommitId: 0eed18403b89d685c736fd41d83312bc18d1fc74
Describe: v5.9-5-g0eed18403b89


[*] TAGS
              LABEL             |      VALUE
--------------------------------+-------------------
  kernel_version                | 5.9.0-smp-DEV
  kernel_version_major          | 5
  kernel_version_minor          | 9
  machine_architecture          | x86_64
  machine_config_memory         | 1048576
  machine_config_num_cores      | 256
  machine_config_num_cpus       | 2
  machine_config_num_phys_cores | 128
  machine_platform_genus        | rome
  test_name                     | vm-scalability



[*] METRICS
                 LABEL                 | COUNT |       MIN        |
   MAX        |       MEAN        |      MEDIAN      |         STDDEV
       | DIRECTION
---------------------------------------+-------+------------------+------------------+-------------------+------------------+------------------------+------------
  300s_128G_truncate_throughput        |       |                  |
              |                   |                  |
       |
  (A) bbf5c979011a                     | 5     | 3.4145093376e+10 |
3.7176031393e+10 | 3.55926734966e+10 | 3.5521843244e+10 |
1.0127887857614994e+09 |
  (B) 0eed18403b89                     | 5     | 3.4908582472e+10 |
3.6828513899e+10 | 3.56578033004e+10 | 3.5495102793e+10 |
6.518510126266636e+08  |
                                       |       | +2.24%           |
-0.93%           | +0.18%            | -0.08%           | -35.64%
          | + is good
  300s_512G_anon_wx_rand_mt_throughput |       |                  |
              |                   |                  |
       |
  (A) bbf5c979011a                     | 5     | 5.041427e+06     |
5.27816e+06      | 5.1413284e+06     | 5.128602e+06     |
93566.28579269352      |
  (B) 0eed18403b89                     | 5     | 5.323419e+06     |
5.513787e+06     | 5.451148e+06      | 5.457595e+06     |
68242.81926767099      |
                                       |       | +5.59%           |
+4.46%           | +6.03%            | +6.41%           | -27.06%
          | + is good
