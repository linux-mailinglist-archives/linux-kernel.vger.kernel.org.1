Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760B128AB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 02:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgJLAi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 20:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgJLAiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 20:38:55 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8FB621D81
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602463134;
        bh=3JjWOrrRe3Ri2Va88NyZZ9ysVmM7e7b9tXLpxqeeSRU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qu5kF8nfQfz6XNzmmbD5fUHAj71XqOtE8NDoiCzS9YXluuRnwMZ8ln+DCOneUwMXD
         rbaTlMa3Nz+1QFnrh7dA45ZYazQ+qHFbNVjSvdvXGFNeMx0WpaHlrxLZPSyb+VaZ/R
         Sv4bx+CbOMjhANhzgAVEHLGTZ5aXt4r1zj12N8B4=
Received: by mail-wr1-f53.google.com with SMTP id i1so11057961wro.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 17:38:54 -0700 (PDT)
X-Gm-Message-State: AOAM5321C8CR4jBFcYyqTgusn+lcqT25zqPWUKIiaIeBKRaOVzonIwVp
        iojSNSoGYNDTsE9u16PJk6CGfsgSPYMNGBYVt9z85Q==
X-Google-Smtp-Source: ABdhPJwlhDPIvlJzvFEhRWYttOsupRWk8TH+QE3JDpT2utboUFP6eaB1GmUggiCCsaYrZMZU7yE5I0UdrAVs4OcjT1c=
X-Received: by 2002:a5d:6744:: with SMTP id l4mr27270264wrw.18.1602463133211;
 Sun, 11 Oct 2020 17:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein> <20201010042606.GA30062@mail.hallyn.com>
 <20201011205306.GC17441@localhost>
In-Reply-To: <20201011205306.GC17441@localhost>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 11 Oct 2020 17:38:41 -0700
X-Gmail-Original-Message-ID: <CALCETrUZcHNwspz315KFvSPxtK8MmLUPfiN=hCBgx+wqeJe4+g@mail.gmail.com>
Message-ID: <CALCETrUZcHNwspz315KFvSPxtK8MmLUPfiN=hCBgx+wqeJe4+g@mail.gmail.com>
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Mrunal Patel <mpatel@redhat.com>, Wat Lim <watl@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Stephane Graber <stgraber@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 1:53 PM Josh Triplett <josh@joshtriplett.org> wrote:
>
> On Fri, Oct 09, 2020 at 11:26:06PM -0500, Serge E. Hallyn wrote:
> > > 3. Find a way to allow setgroups() in a user namespace while keeping
> > >    in mind the case of groups used for negative access control.
> > >    This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
> > >    investigate adding a prctl() to allow setgroups() to be called in a user
> > >    namespace at the cost of restricting paths to the most restrictive
> > >    permission. So if something is 0707 it needs to be treated as if it's 0000
> > >    even though the caller is not in its owning group which is used for negative
> > >    access control (how these new semantics will interact with ACLs will also
> > >    need to be looked into).
> >
> > I should probably think this through more, but for this problem, would it
> > not suffice to add a new prevgroups grouplist to the struct cred, maybe
> > struct group_info *locked_groups, and every time an unprivileged task creates
> > a new user namespace, add all its current groups to this list?
>
> So, effectively, you would be allowed to drop permissions, but
> locked_groups would still be checked for restrictions?
>
> That seems like it'd introduce a new level of complexity (a new facet of
> permission) to manage. Not opposed, but it does seem more complex than
> just opting out of using groups for negative permissions.

Is there any context other than regular UNIX DAC in which groups can
act as negative permissions or is this literally just an issue for
files with a more restrictive group mode than other mode?
