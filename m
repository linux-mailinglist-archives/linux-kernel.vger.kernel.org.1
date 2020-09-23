Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAC2754EA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIWJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgIWJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:57:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A0FC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 02:57:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gf14so2893388pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ewCx0XKQ1ju6wfyj3Pz3K+HET98S+3k20JpX1ePN7aQ=;
        b=MD1ytn3xzFQiWdnsMkQCBk2hz87iEDkmmNejgl1t5v6oTcnCs3th4hp/TnrsiKBqmR
         9NDXScVlMBTL6o7guiemcfft7wumzcfUV1pppS+K/eAQnVb7mn7ffvhkJvU9TLdFlCEU
         ZpUYlgHJPiw4VLODvjkMA6m9IFhAD2KHrgxTlPqVTxSC6ud2gm6c4K+VjdnPgfZSARPx
         h4XY+rRc7UB05Jiixoj0yiTh6z51VIEtzxfCkFGQm6mp8tgdd3o9hOCoOGhwanyYXnSi
         DL3ACAV+TXF3FKUzSlkoXu/vJ5SKuoPlg911HSRmnKPQALxl/uAJbocVIP8lmu1Fo9EQ
         xJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ewCx0XKQ1ju6wfyj3Pz3K+HET98S+3k20JpX1ePN7aQ=;
        b=QdMmiiz/LGeZ4eqDmkr4dA+FTyy1fxuzMMewvcjQAmuHUhYzhsThOTkwz+SZrSpnGN
         E2Ulj0ZQcicTncG1viAcULXZgobYzxBUkioymin3c+5D83DX07IFlOSbJnDLkGx1es02
         WYUTzfhkwaaRbWytRxDCP+M3du+in0hGZ1UuoY/yXl1YUhyUl5OnM1MQi2N22EVMoLOL
         DCSBzDVKpkp6Wmt4bwaeAENhqok2cr0m/XAN3E1u4YhTmHASFtZn7QhUlRelUzO667YL
         h3SLYNmlI4u5rbbvCYpazX9RK+/Wjv6i2/CT5w3Wgf30vbEVD9Z0Qgijg6qRUJ+cNg01
         7WXw==
X-Gm-Message-State: AOAM531zfF8/CgfWupZUbpa7IvONbxivbW8dJxhAzGocAT4UDsaBasn3
        JzHifUuXRCy3j5z+IBz3GP39Rg==
X-Google-Smtp-Source: ABdhPJwFBoRQCMl8tXH9096UvZruQsORHyb2yHiM470xg1qcA1IvENGbCebmXFoi0b1E+FpVI7pgsA==
X-Received: by 2002:a17:90a:fb52:: with SMTP id iq18mr7463985pjb.207.1600855042276;
        Wed, 23 Sep 2020 02:57:22 -0700 (PDT)
Received: from [10.86.118.224] ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id n125sm13588449pfn.185.2020.09.23.02.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 02:57:21 -0700 (PDT)
Subject: Re: [Phishing Risk] [External] Re: [PATCH] cgroup: Add cgroupstats
 numbers to cgroup.stat file
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        songmuchun@bytedance.com
References: <20200915155349.15181-1-zhouchengming@bytedance.com>
 <20200921145009.GD4268@mtj.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <b2fda7f4-e7d1-9e2c-6de6-c1a8ead23568@bytedance.com>
Date:   Wed, 23 Sep 2020 17:57:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921145009.GD4268@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/9/21 下午10:50, Tejun Heo 写道:
> Hello,
>
> On Tue, Sep 15, 2020 at 11:53:49PM +0800, Chengming Zhou wrote:
>> In the cgroup v1, we can use netlink interface to get cgroupstats for
>> a cgroup. But it has been excluded from cgroup v2 interface intentionally
>> due to the duplication and inconsistencies with other statistics.
>> To make container monitor tool like "cadvisor" continue to work, we add
>> these cgroupstats numbers to the cgroup.stat file, and change the
>> admin-guide doc accordingly.
> So, we can't add O(nr_threads) operations to cgroup.stat reads. There are
> two ways forward that I can see.
>
> * Investigate how these counters are being used. If it's used for congestion
>   detection, pressure metrics are likely better indicators to use anyway. If
>   the usage frequency is low enough, maybe querying from userspace should
>   work?
>
> * If the need for these per-cgroup task state counters is really
>   justifiable, the counters should be maintained from scheduling event
>   directly and summed up using rstat like other statistics.
>
> Thanks.
>
Well, I see. These counters are being used for load monitor and debug,
pressure metrics

is good for congestion detection, but more details needed for debug when
problem happened.

And I noticed PSI has maintained these taskstats from scheduler event
already. I think we can

just export these counters gracefully.

Thanks.

