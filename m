Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB4253B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 03:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgH0BY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 21:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgH0BYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:24:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F71BC0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:24:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so4517005ljo.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaAhVe9NZ1R5g2YS2CTJE0/6e8EYtB7aMqdHknvKesA=;
        b=SJwPhgwUnUn2mBarnoa9bYz42e0tKRZQflSAKfXVW+1WuaJWh+0RePI1uNHutnyd2A
         YtVQxlK3Ffu4N1UF5nmbSAY8tUkVP/fRLD1G6u72jYG2ksFuQncrACVRRuOt6NpKvUPv
         fFXWzySHC85dONXfxUUAVinyHVrTxzc1msjDoirhDLNmiEGqoml2RaLfP/5L37cUSmEF
         2x+SKK69lCzSR0Uv2KNHpby9FLNCjb7H8RSlrh0dQvGgW+FHpK2t/Ozqil8Gfn1CgePU
         jjPFsyRGDg6X5bOe51QDiLaAWrD4UjhlZUsnCBSu2IvNakzMXZJxI7xDxSFVtk9hclHh
         Ey+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaAhVe9NZ1R5g2YS2CTJE0/6e8EYtB7aMqdHknvKesA=;
        b=d0lJrPEvKY0pw7+Y+QEXEfbBuKBE5GUlag9rqMvFbhSafuCEHaR4OXMJWtNYLfLoGI
         QVJSP9x1tRlpdR2Ki9WBLGgfBpSrWcqWZ21wkeV86La+NGxnoP5k8GTo7BTPrT3fKk19
         xuJgvZ/9OYEs+D16nX0nQ3IGQ4A8xY6iUJVgG5KIR9ecvgIyLBh23yEfyiKhS6QG26TI
         k7NVZqtwl/dwYMqxSSo1i73xqmBOsNlKJz8yG0DVgD6D+x3WEzj84KUYnfLTaJ8H4ZAT
         0Zn4wDx5Cvf8FwcjbEJd2zEzFtenCFjWGCU2w6NgbC7bo06KVzAoEIHUUGnqsuz+CO3t
         4zfw==
X-Gm-Message-State: AOAM532iFCsNGkF9Pza19jYSluzp4q13QLJmysNd3/DpZ/4UKoSX2xeY
        4GwIU6uH90rbr+pCokj1CQEx/2R+dKn0AXkCX6iKmg==
X-Google-Smtp-Source: ABdhPJxgDGcNP9DxOQTWxsXv8cwD05YmMvT1hmUzl2euif9r0/9glXhCkah+fd374MAxguSaIYX9w6tni5KTkeihFKQ=
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr7665336ljf.58.1598491458086;
 Wed, 26 Aug 2020 18:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-6-guro@fb.com>
In-Reply-To: <20200821150134.2581465-6-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Aug 2020 18:24:07 -0700
Message-ID: <CALvZod5Fb50fVSC9XaYyQ3awjYU8sc4-VYh66z4U__v5Pfxd8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/30] bpf: refine memcg-based memory
 accounting for cpumap maps
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:11 AM Roman Gushchin <guro@fb.com> wrote:
>
> Include metadata and percpu data into the memcg-based memory accounting.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
