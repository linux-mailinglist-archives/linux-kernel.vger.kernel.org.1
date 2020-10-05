Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A446283946
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgJEPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgJEPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:13:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6578AC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:13:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a5so2207211ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5mMMKQazRXBuiw69rKSWjFNeXQ7ni4k4qAPZ1XO+3g=;
        b=uN9au7v6jFrynuxczUPp8JWygJ05kzcFUOGGGsLej2Q64usOPUEklYV3Jq84s9Y611
         9ZQKrUABTdCwf/LNOgdp9G/BIzFOdf/raQ3EvGqDKJErsPYNrl9Rgj7LhctJl0rEQcMP
         j64/BDeokIqiVOC8Uf5+Y2ERFkD3ysja9tolYDYmWKfGayONDYjIdKsL7nhDP4i6Nixi
         vc55bAEGE+qMHqSN0O/UceRRIVBaXhMdPIufdTejG64EOu0/Myjvj8z8I9mC3ZS9Skao
         iFg5B7owCs1q29kMNrEAnM5ks90Dcej7sLB+dQN2/4SjAC8nb8H2kyyLMCk/W9D0ZzmX
         TAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5mMMKQazRXBuiw69rKSWjFNeXQ7ni4k4qAPZ1XO+3g=;
        b=Y3Lw+jUzMuCnNaPjzmhSYo/Kh1sfO5dc5OXcks/oyKaNwDa4dbBxy+s9EbbGNtIi6h
         fuOjchpoprydEM4H2nz6pNV4RJyUs8j2GxGUy01flWrqXnG2ftm+cy1/xQgtYBhQ+NeM
         wDS4fX5etpjoPDTWi7cgtCfB4jrUNjPhK2WQOsiEeWmOcV8MTNRVAhHwmuVciOFj2ruw
         sAOWBXjqcA4OPwgDJkttTs9eFOHax5E23z2dTqEqHgtkIPIm7TrCXKpPuDWhQeixultM
         0QRADXHSLRbSHhhkbRmbHfNZFOGjJFABRc/MWlTeZ0/ft6egKC8FD22USR2oUtm/DgBz
         TX0A==
X-Gm-Message-State: AOAM530RB0m/6g9rwAvBViHgFCeDnAcWL9uOkEGJgkkP3YeBZ88jgAMP
        Ie+sfjZButnNL3wsNWITcWN9R0H7vJrDlcwS6iFyJQ==
X-Google-Smtp-Source: ABdhPJz6UYDVrlJ24vF9L5XVPqqmZT8So5ESBwUbAMJpb4LgG9A4EK9Po+XZyfaEwNRowqb9Wz8QmL89wMUq8s5I8ho=
X-Received: by 2002:a2e:241a:: with SMTP id k26mr68125ljk.58.1601910793555;
 Mon, 05 Oct 2020 08:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201002172559.4000748-1-guro@fb.com> <20201002172559.4000748-3-guro@fb.com>
In-Reply-To: <20201002172559.4000748-3-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 5 Oct 2020 08:13:02 -0700
Message-ID: <CALvZod5uFB0jysrTp6842Shx0rKmZfNfzyN1AzqEkOeAZ4gpWw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mm: memcontrol/slab: use helpers to access slab
 page's memcg_data
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 10:26 AM Roman Gushchin <guro@fb.com> wrote:
>
> To gather all direct accesses to struct page's memcg_data field
> in one place, let's introduce 3 new helpers to use in the slab
> accounting code:
>   struct obj_cgroup **page_objcgs(struct page *page);
>   struct obj_cgroup **page_objcgs_check(struct page *page);
>   bool set_page_objcgs(struct page *page, struct obj_cgroup **objcgs);
>
> They are similar to the corresponding API for generic pages, except
> that the setter can return false, indicating that the value has been
> already set from a different thread.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
