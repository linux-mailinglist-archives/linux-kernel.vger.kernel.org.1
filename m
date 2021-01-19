Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4E2FBCB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbhASQmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbhASQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:40:28 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3EBC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:39:41 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id q12so2932559lfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+5KQrnHXiI7OqCuos/sE3GNhfpeVWGLcvYlJ3q/gLNQ=;
        b=SAYm/oQ4w8PyWqsqATgX21dcMEFisH+jKAqzgYXuu1QVHd/bKa+saZpsKd0Ixp5kaK
         dtVPudvI5I/U+a75VmTLgGA4JLdIlmVG6G7NDd3i+0QbpglU435+x1/ZhSSPnal6m3Q7
         BZokcWSHCd/aVi/+BJGmwVfY5wL8M9nHmddJwC7hyop08FGjrY8jpf2dLj8nn5idDhCj
         zYUOf7d4hocD4nvwEysBlcl4xz3Cnf/evjf9TU0EZS3EUZvbJhBce3elVCt7M46xBT3i
         H/4oHiqUdBfqrrghrCRwecGLWnJLddQDP77wCGd+nIltcdeYFxaxQoeGdG9MqGVUh8T1
         EnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+5KQrnHXiI7OqCuos/sE3GNhfpeVWGLcvYlJ3q/gLNQ=;
        b=GW9SRZNl0wxvcto0xa3VDe5jQqBSVqgA3UKxE74sMp44KhOE5mVNv0TIw8fC8nZD29
         qRYB4WvLWIEI/wn0rFa/ASht1qTT18gz1e78P9dLaXFUZqt4Ak7COzhB2hIZt76mUftb
         JjIoelSCf8Ar2q1CWvRRvMWxaS8+0OD/slnB7ZDoRu9In/kam3usPW9UgYhRtsI1nZMU
         9wZCXuJLWu+UcMNM98uLG0eMV6tVyhRi7rGe92DhwhyTDpxKhRZ9r68Z8D+1zK5vGecc
         WLmIeztVGo7PjgYariLWk5hw47baw0rcR557UDfuCkTfdJtk7oJfkEIZoLht5JMMswG8
         svPQ==
X-Gm-Message-State: AOAM531cCEIlXjMMRhCR79myz19xWFfrRzI91Q60M4Kg4oi4uhphnld8
        +CdpOt+4n7e71VFaI7WjcXQivWUV4PqGPeWvvTRmOw==
X-Google-Smtp-Source: ABdhPJyJPE1X8NNqnvFUJKp0feCMNexDHMs9OdqGWydmBlXJHZ/MOOhnybjGdU0z68fDY5qnWRMsYScuqsXnnPBuuCo=
X-Received: by 2002:a19:644b:: with SMTP id b11mr2187416lfj.358.1611074379421;
 Tue, 19 Jan 2021 08:39:39 -0800 (PST)
MIME-Version: 1.0
References: <1611040814-33449-1-git-send-email-feng.tang@intel.com>
In-Reply-To: <1611040814-33449-1-git-send-email-feng.tang@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 Jan 2021 08:39:28 -0800
Message-ID: <CALvZod4BjRx1PRhkR0_MCF6Hnixie2t=8RHx+5s1DikSw66Dfw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: page_counter: relayout structure to reduce false sharing
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:20 PM Feng Tang <feng.tang@intel.com> wrote:
>
> When checking a memory cgroup related performance regression [1],
> from the perf c2c profiling data, we found high false sharing for
> accessing 'usage' and 'parent'.
>
> On 64 bit system, the 'usage' and 'parent' are close to each other,
> and easy to be in one cacheline (for cacheline size =3D=3D 64+ B). 'usage=
'
> is usally written, while 'parent' is usually read as the cgroup's
> hierarchical counting nature.
>
> So move the 'parent' to the end of the structure to make sure they
> are in different cache lines.
>
> Following are some performance data with the patch, against
> v5.11-rc1. [ In the data, A means a platform with 2 sockets 48C/96T,
> B is a platform of 4 sockests 72C/144T, and if a %stddev will be
> shown bigger than 2%, P100/P50 means number of test tasks equals
> to 100%/50% of nr_cpu]
>
> will-it-scale/malloc1
> ---------------------
>            v5.11-rc1                    v5.11-rc1+patch
>
> A-P100       15782 =C2=B1  2%      -0.1%      15765 =C2=B1  3%  will-it-s=
cale.per_process_ops
> A-P50        21511            +8.9%      23432        will-it-scale.per_p=
rocess_ops
> B-P100        9155            +2.2%       9357        will-it-scale.per_p=
rocess_ops
> B-P50        10967            +7.1%      11751 =C2=B1  2%  will-it-scale.=
per_process_ops
>
> will-it-scale/pagefault2
> ------------------------
>            v5.11-rc1                    v5.11-rc1+patch
>
> A-P100       79028            +3.0%      81411        will-it-scale.per_p=
rocess_ops
> A-P50       183960 =C2=B1  2%      +4.4%     192078 =C2=B1  2%  will-it-s=
cale.per_process_ops
> B-P100       85966            +9.9%      94467 =C2=B1  3%  will-it-scale.=
per_process_ops
> B-P50       198195            +9.8%     217526        will-it-scale.per_p=
rocess_ops
>
> fio (4k/1M is block size)
> -------------------------
>            v5.11-rc1                    v5.11-rc1+patch
>
> A-P50-r-4k     16881 =C2=B1  2%    +1.2%      17081 =C2=B1  2%  fio.read_=
bw_MBps
> A-P50-w-4k      3931          +4.5%       4111 =C2=B1  2%  fio.write_bw_M=
Bps
> A-P50-r-1M     15178          -0.2%      15154        fio.read_bw_MBps
> A-P50-w-1M      3924          +0.1%       3929        fio.write_bw_MBps
>
> [1].https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
