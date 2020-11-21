Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7662BBACA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 01:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgKUAVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 19:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgKUAVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:21:08 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CEBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:21:08 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d17so15880176lfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drZa5velgen67wbuhgWCwO4H5ccjjMv2YMhC3r+McB0=;
        b=cRoBALPFmUDu+Z0/0D5ewnX7flXktvF13PyVjt5u+qRieTP0Df9B5Q4xmQWEdFtQwz
         TJP7P8SsG14kLwr778JOBowdh/blCruw5yQw9tafpanLY7lU392StpA1oIirOPMZdBjV
         3C9V7nVaotQBG4KcuwA02LzpTjj4j5IefgW4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drZa5velgen67wbuhgWCwO4H5ccjjMv2YMhC3r+McB0=;
        b=kMiMIfTpoZgZR3MXOr7im6XfqFEJTmHo31R+OBQL/vfctykdufmJi1IRhKHb7lpgx7
         LkJdo4wuN8w9L4uP2XA4QPYXvIsfPgQnT1TStT+BuI7YzwscBaNd/onI/4f0yLXuxbJM
         JxW23PnSDpvwKWvIyUjQOZQHdZ6qAb2uxAGUmU/LR88oaIwj0puz2+9H+69UdsjLP93g
         LaGyFkvvJ1p12qZjS0oMB6lFRf2fQFiSjmRdJ2ep4t5CSSF/gaF9z5uqXte5JZPwNnE9
         MMwRO6xAnUCrCAr5Oqm7L7vRmo3eMJ+IWj2c9+uQ38HJI5gjijKl3l4WgnoauAXMxlCs
         E5hg==
X-Gm-Message-State: AOAM533K3O9Po2fkv7RLle9Ow1QxkBpTm8AAxIiZsuiP/M9UyiM+eH3Z
        vU6DxCLn/ExHMczy1M/A8KmkuROIeFEsspQ1n4UYXw==
X-Google-Smtp-Source: ABdhPJwj+FDMobw209UyLNKnz1dkYYaf/t6WrekVSol8Lb45lO3K3r2Nggoos7syItRduEXQP1UCDn97j7XbeZ0JV8c=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr9118329lfg.167.1605918066950;
 Fri, 20 Nov 2020 16:21:06 -0800 (PST)
MIME-Version: 1.0
References: <20201120131708.3237864-1-kpsingh@chromium.org>
 <20201120131708.3237864-3-kpsingh@chromium.org> <cad0ea25-8567-368a-1f99-b4adc7440a7f@fb.com>
In-Reply-To: <cad0ea25-8567-368a-1f99-b4adc7440a7f@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Sat, 21 Nov 2020 01:20:56 +0100
Message-ID: <CACYkzJ7doNURahGQn=0d8k73USH85owoZ8yDdwtG48oQLNHYaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
To:     Yonghong Song <yhs@fb.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 7:11 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/20/20 5:17 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > - Update the IMA policy before executing the test binary (this is not an
> >    override of the policy, just an append that ensures that hashes are
> >    calculated on executions).
> >
> > - Call the bpf_ima_inode_hash in the bprm_committed_creds hook and check
> >    if the call succeeded and a hash was calculated.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
>
> LGTM with a few nits below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   tools/testing/selftests/bpf/config            |  3 ++

[...]

> >   }
> >
> [...]
> > +
> >   void test_test_lsm(void)
> >   {
> >       struct lsm *skel = NULL;
> > @@ -66,6 +88,10 @@ void test_test_lsm(void)
> >       if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
> >               goto close_prog;
> >
> > +     err = update_ima_policy();
> > +     if (CHECK(err != 0, "update_ima_policy", "error = %d\n", err))
> > +             goto close_prog;
>
> "err != 0" => err?
> "error = %d" => "err %d" for consistency with other usage in this function.

Done.

>
> > +
> >       err = exec_cmd(&skel->bss->monitored_pid);
> >       if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
> >               goto close_prog;
> > @@ -83,6 +109,12 @@ void test_test_lsm(void)

[...]

> >   int mprotect_count = 0;
> >   int bprm_count = 0;
> > +int ima_hash_ret = -1;
>
> The helper returns type "long", but "int" type here should be fine too.

Changed it to long for correctness.
