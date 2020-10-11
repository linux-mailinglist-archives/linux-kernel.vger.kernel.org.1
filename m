Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA0128AA86
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgJKUxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:53:21 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53575 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgJKUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:53:21 -0400
X-Originating-IP: 67.5.25.97
Received: from localhost (unknown [67.5.25.97])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 499F2C0004;
        Sun, 11 Oct 2020 20:53:08 +0000 (UTC)
Date:   Sun, 11 Oct 2020 13:53:06 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Mrunal Patel <mpatel@redhat.com>, Wat Lim <watl@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephane Graber <stgraber@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
Message-ID: <20201011205306.GC17441@localhost>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
 <20201010042606.GA30062@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010042606.GA30062@mail.hallyn.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:26:06PM -0500, Serge E. Hallyn wrote:
> > 3. Find a way to allow setgroups() in a user namespace while keeping
> >    in mind the case of groups used for negative access control.
> >    This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
> >    investigate adding a prctl() to allow setgroups() to be called in a user
> >    namespace at the cost of restricting paths to the most restrictive
> >    permission. So if something is 0707 it needs to be treated as if it's 0000
> >    even though the caller is not in its owning group which is used for negative
> >    access control (how these new semantics will interact with ACLs will also
> >    need to be looked into).
> 
> I should probably think this through more, but for this problem, would it
> not suffice to add a new prevgroups grouplist to the struct cred, maybe
> struct group_info *locked_groups, and every time an unprivileged task creates
> a new user namespace, add all its current groups to this list?

So, effectively, you would be allowed to drop permissions, but
locked_groups would still be checked for restrictions?

That seems like it'd introduce a new level of complexity (a new facet of
permission) to manage. Not opposed, but it does seem more complex than
just opting out of using groups for negative permissions.
