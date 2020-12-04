Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763E42CEB3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbgLDJl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbgLDJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:41:58 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785DAC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 01:41:18 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so4658729wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 01:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eo6TBMS+qk+t9M6N3qC5XSs2V4IF7uYP9cX9A/8rdaQ=;
        b=sMR5PZlI4ZB+qaf6iZ55WyVSaZ0HlbSkRxQF7Yujg1nGd2BVJBKjTfcEZro4gdeTwV
         qkVVAs8qguQCB/IgBKa4q0l2uDo6u6Fd6Gt/ca/VrDrBBLqRIv267BrR19aOhBwPWQxW
         C7VGxCEiQCb9TizIm8ojjs03DpeftgzwoQaRh6ICl76aETNIoLBnfun0edwnaRZNmcYU
         pg9UjGTLitL8wN4Zzv0W8F+4U+EoH/5ZBkIoCmxyIXuBAEJmFow5UUunq9RTtyjqO8k5
         C0jGc+ZQ/7EX/PzOyEl/P6mYbsueH6mDCQO8K+H1bYRxoHPNpeC8SVHMxLRNHz0VB2B+
         OIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eo6TBMS+qk+t9M6N3qC5XSs2V4IF7uYP9cX9A/8rdaQ=;
        b=lCQiksR/Vwo6UNxL+w3v3rAqBbTzGeVtPuDlVZtgIzD2ZtjqCclO3lt/c8ZhpFGste
         TYGL2nn6qAvaUSBm/LEeN0nEvnz3sx5QEeXARcG7Yq+1YMhr30XO3NfBNCQVxpG5m3iX
         Z4++SYBbWDbo8bqLr0qwnwTUupXPHyOwAY95aUTbvaC2sy9tHR/tEMajCIe7lZjRDCD0
         hk5Uw5RE57EeoVkwqAgoLtYqOiDkTGgtOjZ0kwr1hTe61IsLppZIEKzkrtvxXgV/q5kT
         BC76/9tI/p4Ker1oqu7KBoJS4CEXYe+40YwpvMy5+LdKGLG1D8pIk/b8q+mx8atQ+NpN
         r/ug==
X-Gm-Message-State: AOAM5303eWcdMb3AUn1L+o6hPEuQIdiq50pQyTufy/uQKESzUzBG8KZy
        zEr1Hgtjr1iYItuH0T+9UgkHIA==
X-Google-Smtp-Source: ABdhPJwxfLTMFNu80EYp5tbP2osGr/ykvfAJeQKYWvN9M7puBShi2QdMZtBlBhqcPGMu8lzhZGteKA==
X-Received: by 2002:adf:8483:: with SMTP id 3mr3891625wrg.165.1607074876977;
        Fri, 04 Dec 2020 01:41:16 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id l16sm2874013wrx.5.2020.12.04.01.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:41:16 -0800 (PST)
Date:   Fri, 4 Dec 2020 09:41:12 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 12/14] bpf: Pull tools/build/feature biz into
 selftests Makefile
Message-ID: <X8oEOPViOhR8XdH6@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-13-jackmanb@google.com>
 <CAEf4BzbEfPScq_qMVJkDxfWBh-oRhY5phFr=517pam80YcpgMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbEfPScq_qMVJkDxfWBh-oRhY5phFr=517pam80YcpgMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 01:01:27PM -0800, Andrii Nakryiko wrote:
> On Thu, Dec 3, 2020 at 8:07 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > This is somewhat cargo-culted from the libbpf build. It will be used
> > in a subsequent patch to query for Clang BPF atomics support.
> >
> > Change-Id: I9318a1702170eb752acced35acbb33f45126c44c
> 
> Haven't seen this before. What's this Change-Id business?

Argh, apologies. Looks like it's time for me to adopt a less error-prone
workflow for sending patches.

(This is noise from Gerrit, which we sometimes use for internal reviews)

> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >  tools/testing/selftests/bpf/.gitignore |  1 +
> >  tools/testing/selftests/bpf/Makefile   | 38 ++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> 
> All this just to detect the support for clang atomics?... Let's not
> pull in the entire feature-detection framework unnecessarily,
> selftests Makefile is complicated enough without that.

Then the test build would break for people who haven't updated Clang.
Is that acceptable?

I'm aware of cases where you need to be on a pretty fresh Clang for
tests to _pass_ so maybe it's fine.
