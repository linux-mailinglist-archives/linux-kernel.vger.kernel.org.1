Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D786028F4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbgJOOcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:32:10 -0400
Received: from mail.hallyn.com ([178.63.66.53]:44448 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387861AbgJOOcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:32:09 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 9C59A1105; Thu, 15 Oct 2020 09:32:07 -0500 (CDT)
Date:   Thu, 15 Oct 2020 09:32:07 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
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
        Andy Lutomirski <luto@amacapital.net>,
        Stephane Graber <stgraber@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
Message-ID: <20201015143207.GB25286@mail.hallyn.com>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
 <20201010042606.GA30062@mail.hallyn.com>
 <20201011205306.GC17441@localhost>
 <87tuuzv0hl.fsf@redhat.com>
 <20201013124650.GA19668@mail.hallyn.com>
 <87o8l6qhnz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8l6qhnz.fsf@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 05:17:36PM +0200, Giuseppe Scrivano wrote:
> "Serge E. Hallyn" <serge@hallyn.com> writes:
> 
> > On Mon, Oct 12, 2020 at 07:05:10PM +0200, Giuseppe Scrivano wrote:
> >> Josh Triplett <josh@joshtriplett.org> writes:
> >> 
> >> > On Fri, Oct 09, 2020 at 11:26:06PM -0500, Serge E. Hallyn wrote:
> >> >> > 3. Find a way to allow setgroups() in a user namespace while keeping
> >> >> >    in mind the case of groups used for negative access control.
> >> >> >    This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
> >> >> >    investigate adding a prctl() to allow setgroups() to be called in a user
> >> >> >    namespace at the cost of restricting paths to the most restrictive
> >> >> >    permission. So if something is 0707 it needs to be treated as if it's 0000
> >> >> >    even though the caller is not in its owning group which is used for negative
> >> >> >    access control (how these new semantics will interact with ACLs will also
> >> >> >    need to be looked into).
> >> >> 
> >> >> I should probably think this through more, but for this problem, would it
> >> >> not suffice to add a new prevgroups grouplist to the struct cred, maybe
> >> >> struct group_info *locked_groups, and every time an unprivileged task creates
> >> >> a new user namespace, add all its current groups to this list?
> >> >
> >> > So, effectively, you would be allowed to drop permissions, but
> >> > locked_groups would still be checked for restrictions?
> >> >
> >> > That seems like it'd introduce a new level of complexity (a new facet of
> >> > permission) to manage. Not opposed, but it does seem more complex than
> >> > just opting out of using groups for negative permissions.
> >> 
> >> I have played with something similar in the past.  At that time I've
> >> discussed it only privately with Eric and we agreed it wasn't worth the
> >> extra complexity:
> >> 
> >> https://github.com/giuseppe/linux/commit/7e0701b389c497472d11fab8570c153a414050af
> >
> > Hi, you linked the setgroups patch, but do you also have a link to the
> > attempt which you deemed was not worth it?
> 
> it was just part of a private discussion; but was 4 years ago so we can
> probably revisit and accept the additional complexity since setgroups()
> is still an issue with user namespaces.
> 
> 
> >> instead of a prctl, I've added a new mode to /proc/PID/setgroups that
> >> allows setgroups in a userns locking the current gids.
> >> 
> >> What do you think about using /proc/PID/setgroups instead of a new
> >> prctl()?
> >
> > It's better than not having it, but two concerns -
> >
> > 1. some userspace, especially testsuites, could become confused by the fact
> > that they can't drop groups no matter how hard they try, since these will all
> > still show up as regular groups.
> 
> I forgot to send a link to a second patch :-) that completes the feature:
> https://github.com/giuseppe/linux/commit/1c5fe726346b216293a527719e64f34e6297f0c2
> 
> When the new mode is used, the gids that are not known in the userns do
> not show up in userspace.

Ah, right - and of course those gids better not be mapped into the namespace :)

But so, this is the patch you said you agreed was not worth the extra
complexity?

> > 2. whereas in my lockgroups proposal, lock_groups would only be taken into account
> > for permission denial, this proposal would count for permission grants too.  This
> > means that if I have a group which is permitted to read /foo/topsecret, and I
> > start a program in a new user namespace expecting it to drop that permission,
> > I can't have that, right?  The new program, will always have that permission?
> 
> right.  The new mode I was working on cannot be used to drop granted permissions.
> 
> Giuseppe
