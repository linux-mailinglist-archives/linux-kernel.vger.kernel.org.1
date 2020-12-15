Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068462DAAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgLOK0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgLOK0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:26:23 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C1DC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:25:43 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id m23so5156124ioy.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYwvHC1fHXXPxgQTJYlzDLgaAZWSso9gRqg6NnmZgMU=;
        b=Ej6Tf3+a/k0GN71pJhkruSgx3zKjuenT6kxe49HM5LcgswLynVKKA7iZjhYbDUgaWu
         dM/FavFAn6Lk5dTPKzYxurGA4Wxje1xu78DusJ4U0YgPb/RNw0KfnheG2FIEfgd2lOWz
         cG8Ywc+iU4LwSGgJJbny+yOuXaww1UgVEnFL9kYAMoiRcMduznHGtHfloTHVYKFhaQaS
         wj1DOJu3G57YmWGsZkDP5u0CDFlMDnxz7FUvgRAfxfsxkT3/j1hrdRzxw8i7Lr6ZEFlL
         iZg2tXoxdK/Izh/63BsCqfc2IU0ZwQOBHYAwkgJDHH7TC7dNFNvXcG+IU4q3pq/ucETo
         MLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYwvHC1fHXXPxgQTJYlzDLgaAZWSso9gRqg6NnmZgMU=;
        b=G16Be5OumrsICjZrBsXuD0TUZduT39NEhhW5gKNtsmXLoZNppqg226BwItiQ1tm6Rp
         9H2ER/gnOq9CTKhq2Ha0mY8l2lLH6hCkD9cRjHnKw6WKgvPEB6xjrTEo35WSlQifRzmZ
         pzS7dwqrRVV3yGJIhvJsUjoCRLOX5i/BuPAvkUoJ7yMC0llJKzDadaOG4o/HanG6tPxo
         DO2yqLxJ01MaNByzyAZLc11E24MsxT1lOktFscs9jqnW85+Pli44Dugzh02DYDz2e7kb
         A5NhDD6riPXUC6tdG10gYH2ptrDShH2yGRiPTXzmpIs1gB2dDhJiHIjlkubvofhOguSw
         SI7w==
X-Gm-Message-State: AOAM532KflRDQi06oFQGGPs8d9xgwumEBpTaRiPJA7BBd3MJ9eFACB+U
        9xLWLAamTFg28J/9I5Q0YcstgEUZiG8lwuL0Kr2XPw==
X-Google-Smtp-Source: ABdhPJwk3hKxRWkNXLPRXqtWttXwYAH9yfuF2x1Afy2F3Msh19zJ+74RV4RRCsOGnUfS1hciR9Bww6+cKnvQxn5WCsQ=
X-Received: by 2002:a02:488:: with SMTP id 130mr38391350jab.39.1608027942821;
 Tue, 15 Dec 2020 02:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20201214113812.305274-1-jackmanb@google.com> <f19112d6-7ee7-f685-b203-e0961a246b80@iogearbox.net>
In-Reply-To: <f19112d6-7ee7-f685-b203-e0961a246b80@iogearbox.net>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 15 Dec 2020 11:25:31 +0100
Message-ID: <CA+i-1C0zySfk-bmUcZZWpyVGH3Bt99WOXrd6fsQkx4+cbUDyZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Expose libbpf ringbufer epoll_fd
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 at 21:46, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 12/14/20 12:38 PM, Brendan Jackman wrote:
[...]
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 7c4126542e2b..7be850271be6 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -348,4 +348,5 @@ LIBBPF_0.3.0 {
> >               btf__new_split;
> >               xsk_setup_xdp_prog;
> >               xsk_socket__update_xskmap;
> > +                ring_buffer__epoll_fd;
>
> Fyi, this had a whitespace issue, Andrii fixed it up while applying.

Sorry about that.
