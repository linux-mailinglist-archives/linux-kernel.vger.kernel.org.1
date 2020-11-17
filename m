Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82342B56C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 03:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgKQChs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 21:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgKQChr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:37:47 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566E4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 18:37:47 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id x11so10248852vsx.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 18:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skYHocM/r8tSdHIfpgnHgbHLY0K7ADsNgp1/uZHrUAw=;
        b=tfvvnIhahAtcu2NpB66Ww5oik9hOMvHo1B1hB5c5jtAhNRfW9ETAmJG1B2NWBsaRhc
         eyYsvziLYJ9zSF+RXjBV2BNufAbR3G0G6QR74wK/smzVP+5lp7KyvsyosnkOFuga2Ejx
         DYQnE3FFXgQPd5CXsaStwGHx4uJtdwLmdllLVzkpC8OutQ/sV70J3oNeo1z5hQSnLV0P
         T6HMKVrE5SI7aXRMakFS2j9Wv3wttEwkRyBjCkiUA5OQFSS3hQGBve+guDosG3mJXMEb
         3vdOCmukYKLoDo5nzZJRED0iTgHZX0WVfF3xLYn+rJrf+NazRE+hhk+aLY+YBd4Jg4M5
         DvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skYHocM/r8tSdHIfpgnHgbHLY0K7ADsNgp1/uZHrUAw=;
        b=kmHL6DSAulpUbIEeb0EXSW/fdApS8VR/m+zXVDutoVMjUfgSoA/oDVSKNTwc128O57
         CF0i4GjTalpnfGHjkkg6NKiIr+4qQeGemyXZ0P1w2oonVJNNCjB+BlnuXu1NVjcYDzP6
         vK/tHyoIizu3Hx7ZqxvFTNQMyH0We028xsnOopacq9ux7vNATc3tQL36U0woFDywfbZO
         F39iNwzG1REwtIOWElzpii1doiqo7woA4OW+xn1ifyPnw1FbYtkJ+nuixzZYMP/5RhVn
         o6f3CIAh1/mklIEY1SQ4nu2M4urcL/sB1ypQsCYvEarDsKz4QQXXr1l3iWxpJkAvqBV4
         GvNA==
X-Gm-Message-State: AOAM5325BRz32juoBtdIAB9wvQmcknwLSA1D82rSzzGgdxDBXsLfKZHy
        QqGGRF99IOXSjULNwpduUfDsN3XLNL0V3WTOZTw=
X-Google-Smtp-Source: ABdhPJzqkQX+5Yjpn7Om9ScJ4S8VaWEpKxvz2K8fap2Ovp0oTL/agSSoa9Ja2pnY7gv/Rb8oz8o5PU9qxmi+PtEH4nM=
X-Received: by 2002:a05:6102:3c5:: with SMTP id n5mr10682563vsq.6.1605580666466;
 Mon, 16 Nov 2020 18:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20201116220033.1837-1-urezki@gmail.com> <20201116220033.1837-2-urezki@gmail.com>
In-Reply-To: <20201116220033.1837-2-urezki@gmail.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Tue, 17 Nov 2020 10:37:34 +0800
Message-ID: <CAC=cRTN77LAn-9-6rGukc2aUZQzx7oP9eKt_hJeb=wbnhGqObQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/vmalloc: rework the drain logic
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 6:00 AM Uladzislau Rezki (Sony)
<urezki@gmail.com> wrote:
>
> A current "lazy drain" model suffers from at least two issues.
>
> First one is related to the unsorted list of vmap areas, thus
> in order to identify the [min:max] range of areas to be drained,
> it requires a full list scan. What is a time consuming if the
> list is too long.
>
> Second one and as a next step is about merging all fragments
> with a free space. What is also a time consuming because it
> has to iterate over entire list which holds outstanding lazy
> areas.
>
> See below the "preemptirqsoff" tracer that illustrates a high
> latency. It is ~24 676us. Our workloads like audio and video
> are effected by such long latency:

This seems like a real problem.  But I found there's long latency
avoidance mechanism in the loop in __purge_vmap_area_lazy() as
follows,

        if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
            cond_resched_lock(&free_vmap_area_lock);

If it works properly, the latency problem can be solved.  Can you
check whether this doesn't work for you?

Best Reagrds,
Huang, Ying

<snip>
