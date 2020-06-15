Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96B61F9A58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgFOOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 10:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:34:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23E4C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:34:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k6so1927327pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IX2rPyJbEoaddaAGCH0nUw/i8181BfJCP+lSnavbkzY=;
        b=ATXcarCkC9+xSjmKDB8AvCyvn9OM5sVbA6cYa4OAKaudXkHwo20jUr9mvpAsPj9NH9
         Xh/oQhKUUp3zTGBlr+cP+DumdvJ8PStbo7qCqQiX4usFhDyT+/hEB/Keylap7ruYOWUC
         VX2oTprZDDvaSygIqk8cRSmbmnMQFoE1XAV35ftykqZ2mE7Zpsn7QV+u+NQQ7GTTnTx0
         tnQtDKtI8Kswj1+Laa+Tzu5lHVTrU8YzIHuYvs3DT4yZkxjz7JOtFeiMyMD8zZTAmKQm
         r/s70yMVQDhMtMdpE9+5cSGd5RAR7uk+6o7RB/9ZAtal6ql8uZpuuXEoV1l++CisKTWU
         6RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IX2rPyJbEoaddaAGCH0nUw/i8181BfJCP+lSnavbkzY=;
        b=YdMskGUJmc3wEw2IR3ylum4hQF5cbW4oIpiihQL/bDZCDDcO5ZFdwfMoGXJPF2dG8T
         SGzkIobMLDVKMbOBgPLO8y2cAe/XGgpZNCz3a0PXID9TjoNPj7FqKV4c+5835gTxeGcm
         5d/h2zx8G6GjqBWYWusYNKN4tHwA7vN7T7sz86dQ75TEJnsaq4F3kyzyLVE05TqqZRVt
         KBB0EcvIMbGtPan6jzYqoZ9x4lgmHWHaAs+le7qHBscBDx6LEp/sTRGN1mFOLJVsOhC7
         FQ24hrW44KGYf++LyNBuNjqo87TBEvD4j7tUlR1nbIO2iEmy8/9cXQuhA7v34b7Yfzyt
         PUWg==
X-Gm-Message-State: AOAM533ExEESM0gO8d1RTrDEiumuxSnkyyJpc5RFTGI/ashTK5JoXGNl
        8i9LWp2GHIlYkiFNhcbASRerJw==
X-Google-Smtp-Source: ABdhPJweJCz4K83XMXCk0OAA1j2wz+OVWZDR1clh0cdtwXd6+cgkwO16yultgsQWctQweU6bY5pO9g==
X-Received: by 2002:a17:902:710b:: with SMTP id a11mr22517450pll.156.1592231647395;
        Mon, 15 Jun 2020 07:34:07 -0700 (PDT)
Received: from ngvpn01-160-224.dyn.scz.us.nvidia.com ([2601:646:9302:1050:b1c1:4f97:5a6a:3b73])
        by smtp.gmail.com with ESMTPSA id nl5sm14039225pjb.36.2020.06.15.07.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:34:06 -0700 (PDT)
Subject: Re: [PATCH v6] mm: Proactive compaction
To:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Nitin Gupta <nigupta@nvidia.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20200601194822.30252-1-nigupta@nvidia.com>
 <20200615082901.eccfhaklq6fz4bh6@butterfly.localdomain>
 <20200615142556.5mekzzwvratx2n2i@butterfly.localdomain>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Message-ID: <3f8e66f4-e725-c871-8d8b-0fcd3da20b36@nitingupta.dev>
Date:   Mon, 15 Jun 2020 07:34:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615142556.5mekzzwvratx2n2i@butterfly.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 7:25 AM, Oleksandr Natalenko wrote:
> On Mon, Jun 15, 2020 at 10:29:01AM +0200, Oleksandr Natalenko wrote:
>> Just to let you know, this fails to compile for me with THP disabled on
>> v5.8-rc1:
>>
>>   CC      mm/compaction.o
>> In file included from ./include/linux/dev_printk.h:14,
>>                  from ./include/linux/device.h:15,
>>                  from ./include/linux/node.h:18,
>>                  from ./include/linux/cpu.h:17,
>>                  from mm/compaction.c:11:
>> In function ‘fragmentation_score_zone’,
>>     inlined from ‘__compact_finished’ at mm/compaction.c:1982:11,
>>     inlined from ‘compact_zone’ at mm/compaction.c:2062:8:
>> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
>>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>       |                                      ^
>> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>>   373 |    prefix ## suffix();    \
>>       |    ^~~~~~
>> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>       |  ^~~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>       |                                     ^~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>       |                     ^~~~~~~~~~~~~~~~
>> ./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>>   319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>>       |                            ^~~~~~~~~
>> ./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>>   115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>>       |                          ^~~~~~~~~~~~~~~
>> mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>>    64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
>>       |                                ^~~~~~~~~~~~~~~
>> mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
>>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>>       |                            ^~~~~~~~~~~~~~~~~~~~~~
>> In function ‘fragmentation_score_zone’,
>>     inlined from ‘kcompactd’ at mm/compaction.c:1918:12:
>> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
>>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>       |                                      ^
>> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>>   373 |    prefix ## suffix();    \
>>       |    ^~~~~~
>> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>       |  ^~~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>       |                                     ^~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>       |                     ^~~~~~~~~~~~~~~~
>> ./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>>   319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>>       |                            ^~~~~~~~~
>> ./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>>   115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>>       |                          ^~~~~~~~~~~~~~~
>> mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>>    64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
>>       |                                ^~~~~~~~~~~~~~~
>> mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
>>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>>       |                            ^~~~~~~~~~~~~~~~~~~~~~
>> In function ‘fragmentation_score_zone’,
>>     inlined from ‘kcompactd’ at mm/compaction.c:1918:12:
>> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
>>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>       |                                      ^
>> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>>   373 |    prefix ## suffix();    \
>>       |    ^~~~~~
>> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>       |  ^~~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>       |                                     ^~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>       |                     ^~~~~~~~~~~~~~~~
>> ./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>>   319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>>       |                            ^~~~~~~~~
>> ./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>>   115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>>       |                          ^~~~~~~~~~~~~~~
>> mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>>    64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
>>       |                                ^~~~~~~~~~~~~~~
>> mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
>>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>>       |                            ^~~~~~~~~~~~~~~~~~~~~~
>> In function ‘fragmentation_score_zone’,
>>     inlined from ‘kcompactd’ at mm/compaction.c:1918:12:
>> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
>>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>       |                                      ^
>> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>>   373 |    prefix ## suffix();    \
>>       |    ^~~~~~
>> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>       |  ^~~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>       |                                     ^~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>       |                     ^~~~~~~~~~~~~~~~
>> ./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>>   319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>>       |                            ^~~~~~~~~
>> ./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>>   115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>>       |                          ^~~~~~~~~~~~~~~
>> mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>>    64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
>>       |                                ^~~~~~~~~~~~~~~
>> mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
>>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>>       |                            ^~~~~~~~~~~~~~~~~~~~~~
>> make[1]: *** [scripts/Makefile.build:281: mm/compaction.o] Error 1
>> make: *** [Makefile:1764: mm] Error 2
>>
> 
> What about doing this:
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 0d4f91dfb801..ac2030814edb 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -60,7 +60,7 @@ static const int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
>   * calculates external fragmentation, which is used as
>   * the "fragmentation score" of a node/zone.
>   */
> -#if defined HPAGE_PMD_ORDER
> +#if defined CONFIG_TRANSPARENT_HUGEPAGE
>  #define COMPACTION_HPAGE_ORDER	HPAGE_PMD_ORDER
>  #elif defined HUGETLB_PAGE_ORDER
>  #define COMPACTION_HPAGE_ORDER	HUGETLB_PAGE_ORDER
> 
> ?
> 

Yes, this looks good. I will send out a v7 patch soon with this change.

Thanks,
Nitin

