Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4304427216E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgIUKnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgIUKnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:43:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12260C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:43:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t10so12204195wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mzDmB01mMTFr74qOHeLrNegprGQDAJ8oYYgiRLXCsfc=;
        b=O11nMckorO8RMfFQjnz4Yfr97uv13nR1YIQqRQMKzLSmqJpsduBq1wuChdnYF707Mt
         f/+wj7eFGyW12GAkCjm1muhOnRzjr3f5wjz14zI1gA1i+jm88cGKWNawNgUyFfmCT2kU
         8fNAJ+9t7L+udORk1K93NKpZp7DBuwsh4+SiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mzDmB01mMTFr74qOHeLrNegprGQDAJ8oYYgiRLXCsfc=;
        b=hLfzdyWOyTbUzKCd1ec+P0MeCgWhcGHMf8h1uvC4DlpbYCym0FM3o/bLkYsbiFUSLY
         wLeny2pnKTLXQIt57oFdBLgoq37OKwJC4qndPqsqObMhuCzmtzUrS17HCRU7VlUZiUfV
         h6NfhXZ8DQ3kKxupg0XYzQjz//mE8BuRHYkqG4FHIIrwvX8K3ktt3RYcPKgACmTKtUjA
         2xJq92CgvxTRvFwmk3Z5Ct2hF/DQe1PyOFtTSkAVBjyHVDuUL3FNCnD/JjF2PLQ7vmzK
         4HH0/EN4BujSlenBsw2+vWQuRsC7EBATmlHrDchFfkPP7cP9x4NncRQm58gp2ZKJ/12M
         apmQ==
X-Gm-Message-State: AOAM530ZIOhTjXgcdnAMLpE8BHPxYunVATCAhLy6TfS5yUjUGD1OSGA6
        cqKNXXx1Q1ew8iq5Hj14V1XTbA==
X-Google-Smtp-Source: ABdhPJwiFnqrJc0lvNPEfKhVyaRyAOigEBoDGEEBcLdtcns0TD0AiK7aaXUyjI+kL+G3Jmo+frNDCQ==
X-Received: by 2002:a5d:61c2:: with SMTP id q2mr55645381wrv.25.1600684978631;
        Mon, 21 Sep 2020 03:42:58 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id g12sm19938335wro.89.2020.09.21.03.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:42:58 -0700 (PDT)
Date:   Mon, 21 Sep 2020 11:42:57 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@suse.com>
Cc:     zangchunxin@bytedance.com, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org, tj@kernel.org,
        lizefan@huawei.com, corbet@lwn.net, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: Add the drop_cache interface for cgroup v2
Message-ID: <20200921104257.GA632859@chrisdown.name>
References: <20200921080255.15505-1-zangchunxin@bytedance.com>
 <20200921081200.GE12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200921081200.GE12990@dhcp22.suse.cz>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>On Mon 21-09-20 16:02:55, zangchunxin@bytedance.com wrote:
>> From: Chunxin Zang <zangchunxin@bytedance.com>
>>
>> In the cgroup v1, we have 'force_mepty' interface. This is very
>> useful for userspace to actively release memory. But the cgroup
>> v2 does not.
>>
>> This patch reuse cgroup v1's function, but have a new name for
>> the interface. Because I think 'drop_cache' may be is easier to
>> understand :)
>
>This should really explain a usecase. Global drop_caches is a terrible
>interface and it has caused many problems in the past. People have
>learned to use it as a remedy to any problem they might see and cause
>other problems without realizing that. This is the reason why we even
>log each attempt to drop caches.
>
>I would rather not repeat the same mistake on the memcg level unless
>there is a very strong reason for it.

I agree with Michal. We already have ways to do best-effort memory release on 
cgroup v2, primarily with memory.high. Singling out a category of memory for 
reclaim has historically proved to be a fool's errand.
