Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB16253B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 03:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH0B0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 21:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgH0B0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:26:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A45FC0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:26:11 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r13so1131672ljm.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwQRmtSR03e8Z95YTtgCWBM4ls338szcbW/y+WRctMo=;
        b=PM5UARjGZl7it+68nTblaLTBd77X447PU2c/xp6hmTWdeu4ce4iJZbahk4s2Q5PFaJ
         +v+KyatAlGog4EeZ3cfesfi2mxphBlqnUJ5TOaTqtLfNPbK/tsYe51dE9r+vh8dltGPj
         VBNJl+/9uuOQawkQjvHhrIxa1q93amF+R24gTM/DDjJv7KT63B/rNovbI+fiLtTOY9og
         QlilqKXxN+DnacwnLR1hZm74Zn6LtMNCX+hk7SILdthH7AofhPk49lpUCb8NTyRlUKar
         UlBRatC9I2jMr4qpkzT8ZWALAvc+20hsVv33d1S0hF0nLPPEfOB3+C9Yo+1u1vQOn4Ui
         20DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwQRmtSR03e8Z95YTtgCWBM4ls338szcbW/y+WRctMo=;
        b=CVXKpj16dIkt7A1YLADjt+VOe2wuK2qKBVNtZIKFvkb8Aong3MMLcud3OsKKKiq6T1
         ozKZxMf1LM9tC3fwa8Bx6PEvH+iniOB9ahHsVuRCHhuXAH4842K/9jOXUmn4GnKZb9RN
         G+zchzrKn6ZmJel3VzXK07Bu5C7Apqt/eFXrtaW7pRUqoTRi57ktuJN2hgbQN64up6Fi
         FZwCi3fzVYixIBhlVUaeTT8hCmXTjU8xh8B/LriYpivjUbQwuZ3YefLLvHycOB0hn4nm
         YiW+axPHWvoIDsm4pN8qw3L+lrw8tbOMaImiM+M7azcKZyNq0IGhb43zEmx0RqODrORy
         10EA==
X-Gm-Message-State: AOAM532l9zT8yBxV53lh8hfNik2Y0JpREpvLIX7Rnn67GFJ9JMHqNz/8
        meLbPjp2sJGAfAUM0WVE6ZTUDoMdJmfKkG7qtu8UFQ==
X-Google-Smtp-Source: ABdhPJzfxeyQIyjqzngf0Ic3JmYBl8qWIcdHApqyuYYTCcRsQk5Fv6y+bLFRZIGKwYL6aolr76njLkTX27P4q7r9sUc=
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr7668037ljf.58.1598491569469;
 Wed, 26 Aug 2020 18:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-7-guro@fb.com>
In-Reply-To: <20200821150134.2581465-7-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Aug 2020 18:25:58 -0700
Message-ID: <CALvZod49nAYx5Uh1kSkTyZz98xJt9pgaLu0syZxfRb9bfyM1+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/30] bpf: memcg-based memory accounting for
 cgroup storage maps
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

On Fri, Aug 21, 2020 at 8:17 AM Roman Gushchin <guro@fb.com> wrote:
>
> Account memory used by cgroup storage maps including the percpu memory
> for the percpu flavor of cgroup storage and map metadata.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
