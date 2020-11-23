Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE8A2C130E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgKWS15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgKWS14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:27:56 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A936C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:27:56 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f18so1120938ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgU9p94kvA07oQrdAsYiX/LIRMr6ln5r4nCdzUpy7o4=;
        b=ANbUWVwuYddoy3gY/bocFyh5hQNt+h3KoI3AHjcaYTZ0evyDqwLXLEvh5IHaIDYDPb
         ijvo4CAg9ebzTa4ARSGN499RtHon9GqnfrJYuy06yyb/lbQFc4e1U2t0r7waRnZQb4/f
         yAMxbAR5foJyFqxS0PsPj0FXOMJW+JBdUykTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgU9p94kvA07oQrdAsYiX/LIRMr6ln5r4nCdzUpy7o4=;
        b=uQWSsFNlvJVN+yQHurNUkuXHGz8nbzHXb9JyT4IcGS7pgg2hec1o86wxw6qAB+Hqki
         W+wfQk89e3JVcqEu0K0bNXUw2aeI0fdLD7EI2NmY0Y+LgKEVneX80xRhdAx2ykO0utTL
         LO3/f73P1NVuIh3X0B6jFUoTNqR6+MWT+awY5EA4x9m870RJOGEwNCI9qk8w6iGdvfmg
         DAM9TEwGmU1Rqmk4SdgyiJswddUXJc/zVQeDOLFESAwMgn/jJfueEnq2w19DjJzRiig2
         LrPv6Q0bzgqQKI+xWjkRE/YDZQMLPC/kbHNlDdM+4K6OIjuaVBwJggyDSn9bJq+7BFGR
         z/9Q==
X-Gm-Message-State: AOAM531fmgK4TG8+68iKTxyeTtYMmJfT5QZYCXcYhPP23y1Fl1M1sb6g
        WRbicIwAcHA/Nu5oDmQCffJMVyF6k9lEE8042Lgj6Q==
X-Google-Smtp-Source: ABdhPJwkrFSNlfqwKOFD9vRpU4Bd/UVNbWjZfjxZomwpoP6hhcrhsrMTmb08rhFJdH7XN2M+FVxvNtHTO5cjG1ItJKo=
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr303035ljo.82.1606156074562;
 Mon, 23 Nov 2020 10:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20201121005054.3467947-1-kpsingh@chromium.org>
 <20201121005054.3467947-3-kpsingh@chromium.org> <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
 <CACYkzJ4VkwRV5WKe8WZjXgd1C1erXr_NtZhgKJL3ckTmS1M5VA@mail.gmail.com> <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
In-Reply-To: <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 23 Nov 2020 19:27:43 +0100
Message-ID: <CACYkzJ6VEKBJnJZ+CBvpF6C=Kft5A2O5f=Uu4rTMtUiRKN5S-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > >
> > > Even if a custom policy has been loaded, potentially additional
> > > measurements unrelated to this test would be included the measurement
> > > list.  One way of limiting a rule to a specific test is by loopback
> > > mounting a file system and defining a policy rule based on the loopback
> > > mount unique uuid.
> >
> > Thanks Mimi!
> >
> > I wonder if we simply limit this to policy to /tmp and run an executable
> > from /tmp (like test_local_storage.c does).
> >
> > The only side effect would be of extra hashes being calculated on
> > binaries run from /tmp which is not too bad I guess?
>
> The builtin measurement policy (ima_policy=tcb") explicitly defines a
> rule to not measure /tmp files.  Measuring /tmp results in a lot of
> measurements.
>
> {.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
>
> >
> > We could do the loop mount too, but I am guessing the most clean way
> > would be to shell out to mount from the test? Are there some other examples
> > of IMA we could look at?
>
> LTP loopback mounts a filesystem, since /tmp is not being measured with
> the builtin "tcb" policy.  Defining new policy rules should be limited
> to the loopback mount.  This would pave the way for defining IMA-
> appraisal signature verification policy rules, without impacting the
> running system.

+Andrii

Do you think we can split the IMA test out,
have a little shell script that does the loopback mount, gets the
FS UUID, updates the IMA policy and then runs a C program?

This would also allow "test_progs" to be independent of CONFIG_IMA.

I am guessing the structure would be something similar
to test_xdp_redirect.sh

- KP

>
> Mimi
>
