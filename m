Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A161269AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgIOAqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgIOAp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:45:58 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A608C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:45:57 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id q13so416147vkd.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dV85Eacc1roIo+vHD48suvcriSw+9fgCYtp8+g0r3Mw=;
        b=dAMvoWOtgEPXKSBKyqewg9cq8up9VQcD/Ew8s0A+uDIcs9bgSOS8jq1teYtFyzRuRI
         EqRuo3R7BCmfpMHxrwcUtcfEtQajPdTniDGXcpGfw+MJxpAwv4TkaPCX9JXzQEjgeC6E
         e2V48o+hvAWIOLA6zTcVApW8poXgFLexOE4mUNFyoZDsZEkc9xo/PdBdH2WbWRF8r7fd
         jQAB+us7BTrOtmpFjOVNlNs1FsHl7pOFMn6qZaMIbPuglLLB05Vo58xpSkkLlIT9cxDP
         8vrgy7uo7P16TaqBPAGPWMOQckYOyKsWLM/GBYIPBa0AVNIg+D0T1gVwh5xdyHNaLSxl
         yyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=dV85Eacc1roIo+vHD48suvcriSw+9fgCYtp8+g0r3Mw=;
        b=BlDDqp7wxoBw1Nl2aIhtUFtsWnO8cJNdtEQ1c0YYfX2/qAuwzZn0TOB3gXkYhSbEEA
         blX4RQm+yTbHjJpnP+BKouvITzlLC+wAl5AwTNpmdbRt6rmSnENrbhznG6yRx9WrtCSh
         htm6nnnl9QxXvk6GCLNJ3g/jxTscHJ0io6x03RRc9u3rUgRqkr+zmIfm5Yf/BMEOAvId
         WidpQw561CqhdhPpxfNlGeo/IW1wgnY03Ebvt8AKiLhU6LJk+hOWNb5nYfP/DG0mAydC
         GaoqsLMQsFq9iO6TpyafJxkpPrMf/yIntSqpVixnuR5+AJRn31yoD0SsV1/lBnJWA8Fh
         4KmA==
X-Gm-Message-State: AOAM532dZt+91YYaXsdhhxCJwEqMf3nAV/XG5756xt8tlskQrR/T5kss
        O07anFnvCC5Vwj3hBWi9S3DXhCk4f7ImZtVLX8dbHg==
X-Google-Smtp-Source: ABdhPJwur+ZPMEXzGEBYaFZfUgKfnExHnoeiaZe2G4sGEagBISoIY642qWB3YQBsgez2XNI2Qc7OCEGgdk1dolWAUIk=
X-Received: by 2002:a1f:26cd:: with SMTP id m196mr8849886vkm.7.1600130755541;
 Mon, 14 Sep 2020 17:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 14 Sep 2020 17:45:44 -0700
Message-ID: <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
Subject: Re: [RFC]: userspace memory reaping
To:     linux-api@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 5:43 PM Suren Baghdasaryan <surenb@google.com> wrot=
e:
>
> Last year I sent an RFC about using oom-reaper while killing a
> process: https://patchwork.kernel.org/cover/10894999. During LSFMM2019
> discussion https://lwn.net/Articles/787217 a couple of alternative
> options were discussed with the most promising one (outlined in the
> last paragraph of https://lwn.net/Articles/787217) suggesting to use a
> remote version of madvise(MADV_DONTNEED) operation to force memory
> reclaim of a killed process. With process_madvise() making its way
> through reviews (https://patchwork.kernel.org/patch/11747133/), I
> would like to revive this discussion and get feedback on several
> possible options, their pros and cons.
>
> The need is similar to why oom-reaper was introduced - when a process
> is being killed to free memory we want to make sure memory is freed
> even if the victim is in uninterruptible sleep or is busy and reaction
> to SIGKILL is delayed by an unpredictable amount of time. I
> experimented with enabling process_madvise(MADV_DONTNEED) operation
> and using it to force memory reclaim of the target process after
> sending SIGKILL. Unfortunately this approach requires the caller to
> read proc/pid/maps to extract the list of VMAs to pass as an input to
> process_madvise(). This is a time consuming operation. I measured
> times similar to what Minchan indicated in
> https://lore.kernel.org/linux-mm/20190528032632.GF6879@google.com/ and
> the reason reading proc/pid/maps consumes that much time is the number
> of read syscalls required to read this file. proc/pid/maps file, being
> a seq_file, can be read in chunks of up to 4096 bytes (1 page). Even
> if userspace provides bigger buffer, only up to 4096 bytes will be
> read with one syscall. Measured on Qualcomm=C2=AE Snapdragon 855=E2=84=A2=
 using its
> Big core of 2.84GHz a single read syscall takes between 50 and 200us
> (in case there was no contention on mmap_sem or some other lock during
> the syscall). Taking one typical example from my tests, a 219232 bytes
> long proc/pid/maps file describing 1623 VMAs required 55 read
> syscalls. With mmap_sem contention proc/pid/maps read can take even
> longer. In my tests I measured typical delays of 3-7ms with occasional
> delays of up to 20ms when a read syscall was blocked and the process
> got into uninterruptible sleep.
>
> While the objective is to guarantee forward progress even when the
> victim cannot terminate, we still want this mechanism to be efficient
> because we perform these operations to relieve memory pressure before
> it affects user experience.
>
> Alternative options I would like your feedback are:
> 1. Introduce a dedicated process_madvise(MADV_DONTNEED_MM)
> specifically for this case to indicate that the whole mm can be freed.
> 2. A new syscall to efficiently obtain a vector of VMAs (start,
> length, flags) of the process instead of reading /proc/pid/maps. The
> size of the vector is still limited by UIO_MAXIOV (1024), so several
> calls might be needed to query larger number of VMAs, however it will
> still be an order of magnitude more efficient than reading
> /proc/pid/maps file in 4K or smaller chunks.
> 3. Use process_madvise() flags parameter to indicate a bulk operation
> which ignores input vectors. Sample usage: process_madvise(pidfd,
> MADV_DONTNEED, vector=3DNULL, vlen=3D0, flags=3DPMADV_FLAG_FILE |
> PMADV_FLAG_ANON);
> 4. madvise()/process_madvise() handle gaps between VMAs, so we could
> provide one vector element spanning the entire address space. There
> are technical issues with this approach (process_madvise return value
> can't handle such a large number of bytes and there is MAX_RW_COUNT
> limit on max number of bytes one process_madvise call can handle) but
> I would still like to hear opinions about it. If this option is
> preferable maybe we can deal with these limitations.
>
> We can also go back to reclaiming victim's memory asynchronously but
> synchronous method has the following advantages:
> - reaping will be performed in the caller's context and therefore with
> caller's priority, CPU affinity, CPU bandwidth, reaping workload will
> be charged to the caller and accounted for.
> - reaping is a blocking/synchronous operation for the caller, so when
> it's finished, the caller can be sure mm is freed (or almost freed
> considering lazy freeing and batching mechanisms) and it can reassess
> the memory conditions right away.
> - for very large MMs (not really my case) caller could split the VMA
> vector and perform reaping from multiple threads to make it faster.
> This would not be possible with options (1) and (3).
>
> Would really appreciate your feedback on these options for future develop=
ment.
> Thanks,
> Suren.
