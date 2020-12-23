Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464C62E1D82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgLWOls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLWOlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:41:47 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3332CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 06:41:07 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id w79so15050916qkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 06:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TyB5HqZGghDqQHiswidE0Nhl7bc1fz9iuEH17F6HS7o=;
        b=IgDeBDPev8DvZ4oaMbBRJxjg1MAgyoPY7166NixyJvkYllxi7/p5kshNjanc9HtTq6
         sYiKXh7tNOVrkLuVBGcKEwm5x7HBcJsdcxs5yXmSJyLaVXBrqnZ9nLmMk7GaKy9goTgx
         AsV9Hjpq8Z4uM9zAfHPPwRUlc3zf5y6KvcWo1x4h/zhdryrGq3ClbRppdJBFaPuehdMn
         I8NwLTQ2quDHkqPvXp39O8XGx7SjzKTG0cka0nGhJtO8WW0ExIYDTsZM+C76kia1TXrP
         bYLX6d2SVIqaA0WSilV717axihAAEID9HoAiC3RvsVA5+4SOMjcT4T8On5QRvtCI+non
         QMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TyB5HqZGghDqQHiswidE0Nhl7bc1fz9iuEH17F6HS7o=;
        b=ikxzNlQ7dhcSA8x+u7UOgDTdu09cEh357NT5d/qkvw8vGIoPLpfVMMEBgGk4zDL2Uw
         MXKoxuiv0x159nwbeXHCcbL2fw7iEdkXN4aWGRQ3RbP7AaxV+KFgMZlv7B0jCyHk81xH
         32vLC4p5lHLo2MPV2byAxEB53sbjTXmUWr9KxrZs2Qoyg1uyNKet7HyVpK8F5uSq2iKN
         5ABqv3eaXGQuh71C8q9yi8JMpaL6GiFVSzteKKMD7mA9JOJwnzPKIKP4Dh+sncBlOlEj
         NlcKG32ZFNSDu34m/PS1pgoPh3tlfmfScFuhqh7lGr7Ggb9O+X8ClifanjoL2SQc9dSf
         f8Ng==
X-Gm-Message-State: AOAM531sjTdhNLmPU7xjbLEnV0flQ/UBgp+XUfn6mr3+RlriDXdCE+sN
        L4rl25hyUk/nLLrQp9zAjg5rcYHIupXp2GPYfRUYfg==
X-Google-Smtp-Source: ABdhPJysJd2t4COKogdQKzy4ot2WGRAvIzKHkmy7YpYmNbYXSk3vLuWgyIr4YuTWsYV57jPoX5GeEx2ZBduATggTEBs=
X-Received: by 2002:a37:a747:: with SMTP id q68mr27163288qke.352.1608734466216;
 Wed, 23 Dec 2020 06:41:06 -0800 (PST)
MIME-Version: 1.0
References: <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
 <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org> <CAG_fn=VihkHLx7nHRrzQRuHeL-UYRezcyGLDQMJY+d1O5AkJfA@mail.gmail.com>
 <601d4b1a-8526-f7ad-d0f3-305894682109@codeaurora.org> <CAG_fn=V8e8y1fbOaYUD5SfDSQ9+Tc3r7w6ZSoJ-ZNFJvvq-Aeg@mail.gmail.com>
 <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org> <CAG_fn=UXQUGiDqmChqD-xX-yF5Jp+7K+oHwKPrO9DZL-zW_4KQ@mail.gmail.com>
 <48df48fe-dc36-83a4-1c11-e9d0cf230372@codeaurora.org> <6110a26b-dc87-b6f9-e679-aa60917403de@codeaurora.org>
 <CAG_fn=VjejHtY8=cuuFkixpXd6A6q1C==6RAaUC3Vb5_4hZkcg@mail.gmail.com>
 <X+EFmQz6JKfpdswG@google.com> <d769a7b1-89a2-aabe-f274-db132f7229d1@codeaurora.org>
In-Reply-To: <d769a7b1-89a2-aabe-f274-db132f7229d1@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 23 Dec 2020 15:40:54 +0100
Message-ID: <CAG_fn=UUo3tP1XtdOntNG1krvbPV7pmE9XXwMyuhL2gMUoc4Jw@mail.gmail.com>
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Michan, We would still need config option so that we can reduce the
> memory consumption on low ram devices using config.
>
> Alex, On this,
> "I also suppose device vendors may prefer setting a fixed (maybe
> non-default) hash size for low-memory devices rather than letting the
> admins increase it."
> I see kernel param swiotlb does similar thing i.e; '0' to disable and
> set a value to configure size.
>
> I am fine with either of the approaches,
>
> 1. I can split this patch into two
>    i)  A bool variable to enable/disable stack depot.
>    ii) A config for the size.

I still believe this is a more appropriate solution.

Thanks in advance!
