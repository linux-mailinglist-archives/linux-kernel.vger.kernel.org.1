Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56532CB3FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 05:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgLBEma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 23:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgLBEm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 23:42:29 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE82C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 20:41:49 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so1277286lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 20:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odGT0RvX5AAcrJBCMT9wkKt9QjC6rMyy8QdGLZvY3r0=;
        b=CxS0vDT6Aaj83B+TkWH6A+EWAlxsHaHy/JogU2tC/P2RRxxkmUC+Pp3Baqo4jQo6m4
         EjLEXnf20hVWY6sv0xOEV0HLlO4RAgULP8cDCHzzJ4x4tNUwWB3XfoHLubtryBMkiZQD
         ZRUlJf1l0SMMM3IrbMr9dwBzO8+7lDReAGs8kyO3wTswNLUMjtiFBBX05/kb/0lb36/Q
         9Z4wjeqdN/bMuhpeFMlvnDNGPCPE1vI92au5t7Z5793kiy0zbZPW03m4hGDgoyul+d/E
         iuV7cPkKIY93AYw6bSiliJkkTytU1+9VA1pBtucO7RNmhkQks9ymrmwQBnboowznNPvs
         cHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odGT0RvX5AAcrJBCMT9wkKt9QjC6rMyy8QdGLZvY3r0=;
        b=tIoIYBh1f2vEu6OAXTwvhYQxoCAYl7b/tbg3qCvGLoyrTRH1OdHksihmG7345fIiOs
         FsvsfH9WaJ5e0jFhWcuTlOaOkYIBDk5uWd5daIkjrhQkIIPWCkHJeZg3h9yYKwNgf1Wk
         TJhFYtRQy8WUp8Sny0hnrTwIgZmbiDEKz/VWvjh3HJ+w1+ITvu9s5b265COCgv//c4Oy
         YSzL2E9YI86SK8kaFiEOS1N+IZK92pg2zTEFan0qlLhdPigKBjj6bzYDdXYOX+bm48/N
         OWLRbc0HZ2rQ9OP41U5YGLFoN+1CqtnzIP6TN6RpTajQUr35QWb3YJbcnFkDA/YJKDui
         i4sg==
X-Gm-Message-State: AOAM5319nM1ZJwWJDUYAE/IJLDKrsfgnyMMKbzwozdes17V51SFCbNnx
        cngu10LS2B5rX5Q55log+xXGY81xEinMXPzB+dm9HA==
X-Google-Smtp-Source: ABdhPJyLGoC2gwqfsd8POy9xXzLNMDB/P4TOaOjrNIlJA7Wdv7YjlVn8ouSprJJz4Jqi7j+NNpOLBrIcTCJfSNQdE1s=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr401301lfg.167.1606884107480;
 Tue, 01 Dec 2020 20:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com> <20201130233242.78413-2-dlatypov@google.com>
 <CABVgOSmX3foOr6XJhQ_goYabFEg8qNYoQ+5O7JPRW=gLmh=OQA@mail.gmail.com> <CAGS_qxpW=Q=x8WAR3WWhtYnJc+K43kpDw680x+6go1cAjW6oUQ@mail.gmail.com>
In-Reply-To: <CAGS_qxpW=Q=x8WAR3WWhtYnJc+K43kpDw680x+6go1cAjW6oUQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 2 Dec 2020 12:41:35 +0800
Message-ID: <CABVgOSnH0gz7z5JhRCGyG1wg0zDDBTLoSUCoB-gWMeXLgVTo2w@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: tool: fix unit test so it can run from
 non-root dir
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 3:00 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Nov 30, 2020 at 11:33 PM David Gow <davidgow@google.com> wrote:
> >
> > On Tue, Dec 1, 2020 at 7:33 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > get_absolute_path() makes an attempt to allow for this.
> > > But that doesn't work as soon as os.chdir() gets called.
> >
> > Can we explain why this doesn't work? It's because the test_data/
> > files are accessed with relative paths, so chdir breaks access to
> > them, right?
>
> Correct.
> Because it actually returns a relative path.
>
> (I forgot that I called out that get_absolute_path() gives relative
> paths in the last patch, and not this one. I can update the commit
> desc if we want a v2 of this)
>
> >
> > >
> > > So make it so that os.chdir() does nothing to avoid this.
> > >
> > > Note: mock.patch.object() doesn't seem to work in setUpModule(), hence
> > > the introduction of a new base class instead.
> > >
> > > Fixes: 5578d008d9e0 ("kunit: tool: fix running kunit_tool from outside kernel tree")
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> >
> > I don't like this: disabling a real system call seems like overkill to
> > work around a path issue like this.
> >
> > Wouldn't it be better to either:
> > (a) stop kunit_tool from needing to chdir entirely; or
>
> a) is doable, but would require plumbing cwd=get_kernel_root_path() to
> all the subprocess calls to make, etc.
> I'm not sure fixing a internal test-only issue necessarily justifies
> taking that path instead of the easier "just add a chdir" we opted for
> in 5578d008d9e0 ("kunit: tool: fix running kunit_tool from outside
> kernel tree").
>
> > (b) have get_absolute_path() / test_data_path() produce an absolute path.
> >
> > The latter really seems like the most sensible approach: have the
> > script read its own path and read files relative to that.
>
> b) is not that simple, sadly.
>
> Say I invoke
> $ python3 kunit_tool_test.py
> then __file__ = kunit_tool_test.py.
>
> So __file__ is a relative path, but the code assumed it was an
> absolute one and any change of directory breaks things.
> Working around that would require something like caching the result of
> os.path.abspath(__file__) somewhere.

So, to clarify, __file__ is a relative path based on the cwd when the
script is initially run, right?

In any case, caching the result of os.path.abspath(__file__) seems
like the most sensible solution to me. There's global state anyway
(the current directory), we might as well have it in an explicit
variable, IMHO.
>
> I can see the point about not mocking out something like os.chdir().
> But on the other hand, do we have any other legitimate reason to call
> it besides that one place in kunit.py?
> If we do have something that relies on doing an os.chdir(), it should
> ideally notice that it didn't work and manifest in a unit test failure
> somehow.

Certainly there doesn't seem to be any other need to chdir() in
kunit_tool at the moment, but I could see us doing so when adding
other features. More to the point, if both kunit.py and
kunit_tool_test.py rely on or manipulate the current directory as part
of their state, that seems like it's asking for some trouble down the
line.

If we use an absolute path for the test data, that's something that
seems unlikely to ever need further changes or cause issues.
>
> Alternatively, we could make get_kernel_root_path() return ""/None to
> avoid the chdir call.
> kunit.py:       if get_kernel_root_path():
> kunit.py:               os.chdir(get_kernel_root_path())
>
> There'd be no adverse affects atm for stubbing that out, and I don't forsee any.
> But if we want to be even safer, then perhaps we have
>
> def chdir_to_kernel_root():
>    ...
>
> and mock out just that func in the unit test?

I'd be okay with this, even if I'd prefer us to use an absolute path
for the test_data as well. Having something like this might even give
us the opportunity to verify that we're actually trying to change to
the kernel directory in cases where we need to, but that seems like
it's out-of-scope for a simple fix.

-- David
