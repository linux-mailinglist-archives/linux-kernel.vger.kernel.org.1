Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB3A268B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgINMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgINMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:48:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C7C06178B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:48:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f18so12531628pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Uz3YE9w1fx32lra6fotfj3/BpiuxJjONItcmFYjk970=;
        b=ta92UEnM0Ua9PKVZdAdjsi6Jcm76RRN61MVtg6ALDRhldMa+ZsFdlqJ3vjV7W78eQU
         L+mNnZT19WOv1iAntELNGU/RnT55IXLY4V1fZJk31ruqe/QWsLhn7vTI3wshmsuuW9WE
         xcXv3AmVxLJH5ZH0CPAmEgfxJNjgsRm+aVqtR9u4fHcL5QsDo2ycGJ23JvH5MVGCdwaG
         2gFRVq5A98aqjW2AC4oG5eiDcJm+cDjNRZA2i0KhknZ4KFMoPfj+Rs8soQCCFsQI90dG
         gliLXbww33mVTnbTrDO6SJ3QRT7apUD5L7qeW15VijIPPsRbh5YkpIddinm0fzkgBTwJ
         noNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Uz3YE9w1fx32lra6fotfj3/BpiuxJjONItcmFYjk970=;
        b=By3lGV2lPmTEEozMFgnvUDT8SzayIpQvc/POEp2aIaxUbuQHSVpbvNjidTaWV3QpTh
         aySBATVIJ+Y25k3uTveKzNqHlKScbKFoaKuqRY/XNvjeQIY6/B00w0bks14+NVTQy8F6
         skRwRc+EhPxZtApcAC6meDZQ1P7+Jn9Pc1pWLUFNVQxseVc3e6yvXOvPym2urhGvLire
         NS2uvAvttmRFJFx/mpEQivFv1EkF8H9p7h7yQxwe2MZXmBqDJxhs7M2g9oCktxyfZD+Y
         gdFV5eQd2XSjN/4LgQMvksKX4Sqv1VS7ZzGGGfaVDXKju1DxjP55cgcOYPn/vc6NUPNV
         MpIg==
X-Gm-Message-State: AOAM531WxyTq88wAK5vxj2IKGWPikAZbwlWRemiF33xaswoVMaLEliei
        Lo7qatrTtMFYHVr0ZfS4vUWaUA==
X-Google-Smtp-Source: ABdhPJwGlhXZUcP7IyQxtyR5M0DoHv+Edk8HQH37UA9N/AavLopTAC+f2LB/uWPLZCvLUE2zhkf3Sw==
X-Received: by 2002:a17:902:d711:b029:d1:c6b5:ae5f with SMTP id w17-20020a170902d711b02900d1c6b5ae5fmr5413664ply.38.1600087685077;
        Mon, 14 Sep 2020 05:48:05 -0700 (PDT)
Received: from [10.86.118.224] ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id ie13sm9660102pjb.5.2020.09.14.05.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 05:48:04 -0700 (PDT)
Subject: Re: [Phishing Risk] [External] Re: [PATCH] taskstats: fix
 CGROUPSTATS_CMD_GET for cgroup v2
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
References: <20200910055207.87702-1-zhouchengming@bytedance.com>
 <20200910143244.GF4295@mtj.thefacebook.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <32fa7ae0-761f-9f2b-088b-4a3a0b5448cd@bytedance.com>
Date:   Mon, 14 Sep 2020 20:48:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910143244.GF4295@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/9/10 下午10:32, Tejun Heo 写道:
> On Thu, Sep 10, 2020 at 01:52:07PM +0800, Chengming Zhou wrote:
>> We found cgroupstats_build would return -EINVAL when using netlink
>> CGROUPSTATS_CMD_GET interface to get stats on cgroup v2. Fix it by
>> supporting cgroup v2 kernfs directory in cgroupstats_build, and export
>> cgroup2_fs_type like we did for cgroup_fs_type.
>>
>> Reported-by: Daowen Luo <luodaowen.backend@bytedance.com>
>> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> The exclusion of cgroupstats from v2 interface was intentional due to the
> duplication and inconsistencies with other statistics. If you need these
> numbers, please justify and add them to the appropriate cgroupfs stat file.
>
> Thanks.
>
Thanks for your advice. The container monitor tool "cadvisor" needs
these numbers to work,

I will put them in the existing cpu.stat interface.

Thanks.

