Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F298D2CACBA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404319AbgLATti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389343AbgLATth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:49:37 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E026C061A48
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:48:28 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id k26so3105646oiw.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GU/a7gBkkUxdrrdBKj5i93nXRF3uXJBiU207T9STEpA=;
        b=p1A2sApHdbVLzC8djhvsu1ocumSGH/RrLteefCxvWcVC9II7eb4K+dA9ylmw0GCSil
         IdK8sStgNrAsQSfi1KnqUFQpef6Os/deuekWk34UB20tBP3kXJIDjxV2YytOg85DFx5S
         SDlQgS0aW0RcuHkStBqNvfRyhs4d+mTtm7+eIIlSnkzv0nmb2jELrm/kGEd0MjEmKa4H
         hEilThbEtbrPls3EzqOEG+fxstBvnSbW9ko0Vuk7+Srhu6SWU14iFkZ+cdL9062wd9IO
         p2BQcSfAIf2prEQ61JJysRhKwGcBcjDviAe8w/Kf6cUJsOKhx/4DrHC9wwr6nIteNECS
         U8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GU/a7gBkkUxdrrdBKj5i93nXRF3uXJBiU207T9STEpA=;
        b=Coqq6KM2iRNMOaxerD/2omRiWksFXlJNWQCcyrOcPDT0XStxEoypH+kOiac8yBnHo4
         VoTxWeg+Xidw0p9o20ovQVQIwrS6ZVz0SJVbzEKFvaSutLDr+PqoI+Xyp49uDWxsQ0x6
         Iq/3R+2hmkW1nsv6+yCMfdiGZY3bxnHrkbVwNKvcaFEtwf8oX/UJBfcmvCNFaSLgaTOa
         DZ/MKltO3vfajTh2odvxocWr01aGg+1DVFmHPuQUT3AHpyAejlxoV6zzINaRKc5myMOe
         V9HRQUP/jIHEjyc8UWwTbLBug5OM6fP0IMz/CenBh7FYXkaGHq3DGah7k8nLIsGWcsP7
         Gwlg==
X-Gm-Message-State: AOAM531qC3Kc0TvIJpsQtxr2gs+VwcK1eboVivjmvuk0Frm7p6bofcD+
        8ftEGJdHOMfuP3gB3zm8JG7KeBkkdJ18m4HpGR6KJA==
X-Google-Smtp-Source: ABdhPJwuOtbu6e0mpTX2ppq4vKVkfl1OODrkYIbcJ3YSTIHDgdruXNvVWsKxJZQMNlznGdTCU8LxdeHczxzz46q0rwM=
X-Received: by 2002:aca:c3d6:: with SMTP id t205mr2816644oif.10.1606852107373;
 Tue, 01 Dec 2020 11:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20201201175144.3996569-1-minchan@kernel.org> <20201201175144.3996569-5-minchan@kernel.org>
In-Reply-To: <20201201175144.3996569-5-minchan@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 1 Dec 2020 11:48:15 -0800
Message-ID: <CALAqxLXFeUStaJ8Mtm5v3kSxmeqnjzLTsyathkrKF0ke3fYGiQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dma-buf: heaps: add chunk heap to dmabuf heaps
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Hyesoo Yu <hyesoo.yu@samsung.com>,
        Matthew Wilcox <willy@infradead.org>, david@redhat.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        Suren Baghdasaryan <surenb@google.com>,
        KyongHo Cho <pullip.cho@samsung.com>,
        John Dias <joaodias@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 9:51 AM Minchan Kim <minchan@kernel.org> wrote:

Thanks for reworking and resending this!

...
> +static int __init chunk_heap_init(void)
> +{
> +       struct cma *default_cma = dev_get_cma_area(NULL);
> +       struct dma_heap_export_info exp_info;
> +       struct chunk_heap *chunk_heap;
> +
> +       if (!default_cma)
> +               return 0;
> +
> +       chunk_heap = kzalloc(sizeof(*chunk_heap), GFP_KERNEL);
> +       if (!chunk_heap)
> +               return -ENOMEM;
> +
> +       chunk_heap->order = CHUNK_HEAP_ORDER;
> +       chunk_heap->cma = default_cma;
> +
> +       exp_info.name = cma_get_name(default_cma);

So, this would create a chunk heap name with the default CMA name,
which would be indistinguishable from the heap name used for the plain
CMA heap.

Probably a good idea to prefix it with "chunk-" so the heap device
names are unique?

thanks
-john
