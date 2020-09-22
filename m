Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC079273EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgIVJvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgIVJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:51:39 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB5FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:51:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p9so21935026ejf.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vLhN/ucVLfE69Dl/WKI0HEpcS5fMQFDATogS8fruK+Y=;
        b=kWC+smJjtT0c9St6jcuRKFe+iC/3MNGMO2hzLmI4h3ukWa//TYGeZk5SPv1bkUzYpe
         Piq5Gfchg23WCZ9wQAwQMGNwS3SbNdcaDAC2Az/+yjW8h+MjYeKt2dW1g/mome8M5EMI
         iHbdhnfc6dBx+c0BNKdqAlSk0ap/1jplkFecY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vLhN/ucVLfE69Dl/WKI0HEpcS5fMQFDATogS8fruK+Y=;
        b=iZL+GyBDABRQmGau0rP9vJIQuLzbRLqg94kAWKofH5R5aZ3Bwf3jmM0ii0SfANM70z
         3WCJLS/bqKxOFgDPdlGpZovwpthpi1abLRe/7Y6zHZ1dFXCECco2DhxVaAQHBDXWQgoO
         4BoRD72pBtsPbuEYt9Bu544eG9/ssalFNlXpCJW2BpJI27+8qehY6vK8Ww8uswQLWEmm
         RDVcJzjktQ5ONtFYSQ/+UjPtred4zP6f4QcLv/hYn2hwE5Kn/Iu+xl2LN5jcJnDlfjKQ
         WemjwmYUI4fIRG9OmqC20MraytufVAU/7BLIY57PidJ7+LDCQtX89mCFuWioqhB48oQq
         41zw==
X-Gm-Message-State: AOAM531sOsxgZL/RIGWNuPUra/gMsfywT5JQWWFBOyXkABv/b9XlmtRA
        NqnWberrxKiZuVVs3xiAX2EB9Q==
X-Google-Smtp-Source: ABdhPJz0OsMdgyayNctU/Uicxzh0FHbqFj8fYde2wyp0iYG7bitVMgqzdrly9+4XgRu7N/ARK6LFpw==
X-Received: by 2002:a17:906:af53:: with SMTP id ly19mr3778973ejb.503.1600768297333;
        Tue, 22 Sep 2020 02:51:37 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:7783])
        by smtp.gmail.com with ESMTPSA id y14sm10723374eje.10.2020.09.22.02.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 02:51:36 -0700 (PDT)
Date:   Tue, 22 Sep 2020 10:51:36 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Chunxin Zang <zangchunxin@bytedance.com>
Cc:     Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        andriin@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [External] Re: [PATCH] mm/memcontrol: Add the drop_cache
 interface for cgroup v2
Message-ID: <20200922095136.GA9682@chrisdown.name>
References: <20200921080255.15505-1-zangchunxin@bytedance.com>
 <20200921081200.GE12990@dhcp22.suse.cz>
 <CALOAHbDKvT58UFjxy770VDxO0VWABRYb7GVwgw+NiJp62mB06w@mail.gmail.com>
 <20200921110505.GH12990@dhcp22.suse.cz>
 <CAKRVAeN5U6S78jF1n8nCs5ioAdqvVn5f6GGTAnA93g_J0daOLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKRVAeN5U6S78jF1n8nCs5ioAdqvVn5f6GGTAnA93g_J0daOLw@mail.gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chunxin Zang writes:
>My usecase is that there are two types of services in one server. They
>have difference
>priorities. Type_A has the highest priority, we need to ensure it's
>schedule latency、I/O
>latency、memory enough. Type_B has the lowest priority, we expect it
>will not affect
>Type_A when executed.
>So Type_A could use memory without any limit. Type_B could use memory
>only when the
>memory is absolutely sufficient. But we cannot estimate how much
>memory Type_B should
>use. Because everything is dynamic. So we can't set Type_B's memory.high.
>
>So we want to release the memory of Type_B when global memory is
>insufficient in order
>to ensure the quality of service of Type_A . In the past, we used the
>'force_empty' interface
>of cgroup v1.

This sounds like a perfect use case for memory.low on Type_A, and it's pretty 
much exactly what we invented it for. What's the problem with that?
