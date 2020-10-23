Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8272977D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754920AbgJWTq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754901AbgJWTq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603482384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oo0JalTi67g9ZbGeniubeZCk3VUuNT+Cn8+MsUJc5v8=;
        b=fSwuWWUmwucMcndUyMBk2+zwXZtpt3ajon2cbnhec4diXe9NQRUdi2JB+j/K7p68nvzuzt
        eFzuAr6iT7Rh5bjfGueS1Qyi98sRfBUlkxvtIeiChL/bqXNEa3xiM0GeFLP012ij1zyKEv
        +LxTCXS0Og4BhqO7Hr8t6guDAS0//lE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-CfJHSN4VOJGpC46kKPHYnA-1; Fri, 23 Oct 2020 15:46:21 -0400
X-MC-Unique: CfJHSN4VOJGpC46kKPHYnA-1
Received: by mail-wr1-f69.google.com with SMTP id 33so967342wrf.22
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=oo0JalTi67g9ZbGeniubeZCk3VUuNT+Cn8+MsUJc5v8=;
        b=Vt/2C80EJZxv6TlymkMeryJo36AGVoz/+Ipyf3yX8kgV4g6tPODiU/FBwLIVDVYkkB
         lvbLkrpkx1G+ZKzx4ywcChNYUhRtkURTz6fzArsmD6PsWHN5VWN0VPlGGnVHwMF39owl
         y2KJnDDTHErtKrwVxsUZ0DmaSsj/UYwbD7qaeH64lGu+UJ9zHemlhaZzIvWVRpRyMrNp
         eBbLWPvyeTFiJzAdzhEc/sbjBw52N5W2yGnL60vXCm+PrI3b8b71sllhsd4udkdhhSDZ
         c1azb2W+oU/+m7kMg91whw77V4S32vOrf/qP9Cm5xOFz2Jd2ubfsp6Z9FyjMrbox4Vfs
         bE+Q==
X-Gm-Message-State: AOAM531Ru8R2DwIw28SBmYcWq+Tf7kF8gMHtWqocmkFFEuetDqryj3kW
        H3DwmywbtmnUGepDlGFZ9CPTQbgT5hjGWBzIIO+allIckSIGbh/vYhbsLC6tR1ICMirxJ6EeT/D
        B2nky0GLiH5atpqMzkRclGkPA
X-Received: by 2002:adf:f54c:: with SMTP id j12mr4229761wrp.413.1603482380410;
        Fri, 23 Oct 2020 12:46:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFPXPryRMAbopbFh6rDX/+Y8pVivtrzItiePcRoNUjb4TB29+LPxEa54au1ZJUYrNqT4C6rw==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr4229747wrp.413.1603482380210;
        Fri, 23 Oct 2020 12:46:20 -0700 (PDT)
Received: from [192.168.3.114] (p5b0c6b29.dip0.t-ipconnect.de. [91.12.107.41])
        by smtp.gmail.com with ESMTPSA id c185sm5341371wma.44.2020.10.23.12.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 12:46:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [mm/page_alloc] 7fef431be9: vm-scalability.throughput 87.8% improvement
Date:   Fri, 23 Oct 2020 21:46:18 +0200
Message-Id: <9F5E9E0C-A367-49EE-8764-58555C742F1E@redhat.com>
References: <alpine.DEB.2.23.453.2010231226310.1686635@chino.kir.corp.google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
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
In-Reply-To: <alpine.DEB.2.23.453.2010231226310.1686635@chino.kir.corp.google.com>
To:     David Rientjes <rientjes@google.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 23.10.2020 um 21:29 schrieb David Rientjes <rientjes@google.com>:
>=20
> =EF=BB=BFOn Wed, 21 Oct 2020, kernel test robot wrote:
>=20
>> Greeting,
>>=20
>> FYI, we noticed a 87.8% improvement of vm-scalability.throughput due to c=
ommit:
>>=20
>>=20
>> commit: 7fef431be9c9ac255838a9578331567b9dba4477 ("mm/page_alloc: place p=
ages to tail in __free_pages_core()")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>=20
>>=20
>> in testcase: vm-scalability
>> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz=
 with 192G memory
>> with following parameters:
>>=20
>>    runtime: 300s
>>    size: 512G
>>    test: anon-wx-rand-mt
>>    cpufreq_governor: performance
>>    ucode: 0x5002f01
>>=20
>> test-description: The motivation behind this suite is to exercise functio=
ns and regions of the mm/ of the Linux kernel which are of interest to us.
>> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability=
.git/
>>=20
>=20
> I'm curious why we are not able to reproduce this improvement on Skylake=20=

> and actually see a slight performance degradation, at least for=20
> 300s_128G_truncate_throughput.
>=20
> Axel Rasmussen <axelrasmussen@google.com> can provide more details on our=20=

> results.
>=20

As this patch only affects how we first place pages into the freelists when b=
ooting up, I=E2=80=98d be surprised if there would be observable change in a=
ctual numbers. Run your system for long enough and it=E2=80=98s all going to=
 be random in the freelists anyway.

Looks more like random measurement anomalies to me. But maybe there are corn=
er cases where the initial state of the freelists affects a benchmark when r=
un immediately after boot?=

