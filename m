Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F432C13D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbgKWSqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732338AbgKWSqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:46:46 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16938C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:46:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id t6so9081940lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9BHXyWFj10xWcwujIs4dXnL9WUMRwoUF5d33ZfnS3g=;
        b=mImY9iotviSUpccYlY57NxeoOjkByLCewvzY67q7V5+w5771rSl7PimMIHy2BTWA02
         mSecZCcfVYWwPKyWWSsmBHsr8TX99kbBLSdUXwlX890cEs2a77UwKmthMDcm2NY9Gwco
         AS+uEAI9ngPl2w4t18qMyhxSOTdhY+qeM7DXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9BHXyWFj10xWcwujIs4dXnL9WUMRwoUF5d33ZfnS3g=;
        b=B1gFunaf4ocxEQuk7GaWSDaBtb5EKEovEN5zi0aqoeqxdHimO61+qGj/gobZogdpds
         n2bvup8r8CTZREropHeEqSMn/6YrxtWRsRXVK1ndsdjbzt0XvNvwh6a9YIPBcDXcnWAy
         g4gAocXGXI08d5vHKPOsYD9fxNJc5GVX4Q147K9q+tOT+jP+45U+Hfihkbp2omPoC5mB
         uAEDsS340xQbE5qG5va5z/WSD7eRdoVDwV7JCraJpB6TGLTuULPKrOosLEXcQUjLKy/+
         C3pO1O9UV/FwY1XGaj+pqtRsyDyK7e8XlHk67n/atMHQOiarsUFpb88f/845OS377anp
         JjJQ==
X-Gm-Message-State: AOAM533AOGoIbC0gO0L8h7eyLP8nWqMbCDm6QM2H0dWEiN55hDMRNzPB
        DJY/0NT0itIgoF7dh5I5kEMbNFWdkqeqguwXRchqfQ==
X-Google-Smtp-Source: ABdhPJztvNCcwogoA0f2GBgX20o1qMkXIjfhJfZKvK5/zjRoiuEE7ZMUaYGFhhjf2/Tq0dxwizfKLd56uu9M6FmB+I0=
X-Received: by 2002:a19:f114:: with SMTP id p20mr204531lfh.146.1606157204393;
 Mon, 23 Nov 2020 10:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20201121005054.3467947-1-kpsingh@chromium.org>
 <20201121005054.3467947-3-kpsingh@chromium.org> <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
 <CACYkzJ4VkwRV5WKe8WZjXgd1C1erXr_NtZhgKJL3ckTmS1M5VA@mail.gmail.com>
 <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
 <CACYkzJ6VEKBJnJZ+CBvpF6C=Kft5A2O5f=Uu4rTMtUiRKN5S-g@mail.gmail.com> <cf0d94ca-b6a0-1a1a-6cf2-a641002588bf@fb.com>
In-Reply-To: <cf0d94ca-b6a0-1a1a-6cf2-a641002588bf@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 23 Nov 2020 19:46:33 +0100
Message-ID: <CACYkzJ6RK=bhdGphbK6VZoLdvEfEo9rtYKCS=-dfyt5F=AujnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
To:     Yonghong Song <yhs@fb.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 7:36 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/23/20 10:27 AM, KP Singh wrote:
> > [...]
> >
> >>>>
> >>>> Even if a custom policy has been loaded, potentially additional
> >>>> measurements unrelated to this test would be included the measurement
> >>>> list.  One way of limiting a rule to a specific test is by loopback
> >>>> mounting a file system and defining a policy rule based on the loopback
> >>>> mount unique uuid.
> >>>
> >>> Thanks Mimi!
> >>>
> >>> I wonder if we simply limit this to policy to /tmp and run an executable
> >>> from /tmp (like test_local_storage.c does).
> >>>
> >>> The only side effect would be of extra hashes being calculated on
> >>> binaries run from /tmp which is not too bad I guess?
> >>
> >> The builtin measurement policy (ima_policy=tcb") explicitly defines a
> >> rule to not measure /tmp files.  Measuring /tmp results in a lot of
> >> measurements.
> >>
> >> {.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
> >>
> >>>
> >>> We could do the loop mount too, but I am guessing the most clean way
> >>> would be to shell out to mount from the test? Are there some other examples
> >>> of IMA we could look at?
> >>
> >> LTP loopback mounts a filesystem, since /tmp is not being measured with
> >> the builtin "tcb" policy.  Defining new policy rules should be limited
> >> to the loopback mount.  This would pave the way for defining IMA-
> >> appraisal signature verification policy rules, without impacting the
> >> running system.
> >
> > +Andrii
> >
> > Do you think we can split the IMA test out,
> > have a little shell script that does the loopback mount, gets the
> > FS UUID, updates the IMA policy and then runs a C program?
> >
> > This would also allow "test_progs" to be independent of CONFIG_IMA.
> >
> > I am guessing the structure would be something similar
> > to test_xdp_redirect.sh
>
> Look at sk_assign test.
>
> sk_assign.c:    if (CHECK_FAIL(system("ip link set dev lo up")))
> sk_assign.c:    if (CHECK_FAIL(system("ip route add local default dev lo")))
> sk_assign.c:    if (CHECK_FAIL(system("ip -6 route add local default dev
> lo")))
> sk_assign.c:    if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
> sk_assign.c:    if (CHECK(system(tc_cmd), "BPF load failed;"
>
> You can use "system" to invoke some bash commands to simulate a script
> in the tests.

Heh, that's what I was trying to avoid, I need to parse the output to the get
the name of which loop device was assigned and then call a command like:

# blkid /dev/loop0
/dev/loop0: UUID="607ed7ce-3fad-4236-8faf-8ab744f23e01" TYPE="ext3"

Running simple commands with "system" seems okay but parsing output
is a bit too much :)

I read about:

https://man7.org/linux/man-pages/man4/loop.4.html

But I still need to create a backing file, format it and then get the UUID.

Any simple trick that I may be missing?

- KP

>
> >
> > - KP
> >
> >>
> >> Mimi
> >>
