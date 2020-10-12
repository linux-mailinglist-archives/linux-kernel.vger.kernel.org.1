Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2F28BB78
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgJLPAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:00:10 -0400
Received: from mail.hallyn.com ([178.63.66.53]:38240 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbgJLPAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:00:08 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 4A5A5CBF; Mon, 12 Oct 2020 10:00:06 -0500 (CDT)
Date:   Mon, 12 Oct 2020 10:00:06 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Mrunal Patel <mpatel@redhat.com>, Wat Lim <watl@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Stephane Graber <stgraber@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
Message-ID: <20201012150006.GA3503@mail.hallyn.com>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
 <20201010042606.GA30062@mail.hallyn.com>
 <20201011205306.GC17441@localhost>
 <CALCETrUZcHNwspz315KFvSPxtK8MmLUPfiN=hCBgx+wqeJe4+g@mail.gmail.com>
 <87h7r0qbqi.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7r0qbqi.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 12:01:09AM -0500, Eric W. Biederman wrote:
> Andy Lutomirski <luto@kernel.org> writes:
> 
> > On Sun, Oct 11, 2020 at 1:53 PM Josh Triplett <josh@joshtriplett.org> wrote:
> >>
> >> On Fri, Oct 09, 2020 at 11:26:06PM -0500, Serge E. Hallyn wrote:
> >> > > 3. Find a way to allow setgroups() in a user namespace while keeping
> >> > >    in mind the case of groups used for negative access control.
> >> > >    This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
> >> > >    investigate adding a prctl() to allow setgroups() to be called in a user
> >> > >    namespace at the cost of restricting paths to the most restrictive
> >> > >    permission. So if something is 0707 it needs to be treated as if it's 0000
> >> > >    even though the caller is not in its owning group which is used for negative
> >> > >    access control (how these new semantics will interact with ACLs will also
> >> > >    need to be looked into).
> >> >
> >> > I should probably think this through more, but for this problem, would it
> >> > not suffice to add a new prevgroups grouplist to the struct cred, maybe
> >> > struct group_info *locked_groups, and every time an unprivileged task creates
> >> > a new user namespace, add all its current groups to this list?
> >>
> >> So, effectively, you would be allowed to drop permissions, but
> >> locked_groups would still be checked for restrictions?
> >>
> >> That seems like it'd introduce a new level of complexity (a new facet of
> >> permission) to manage. Not opposed, but it does seem more complex than
> >> just opting out of using groups for negative permissions.

Yeah, it would, but I basically hoped that we could catch most of this at
e.g. generic_permission(), and/or we could introduce a helper which
automatically adds a check for permission denied from locked_groups, so
it shouldn't be too wide-spread.  If it does end up showing up all over
the place, then that's a good reason not to do this.

> > Is there any context other than regular UNIX DAC in which groups can
> > act as negative permissions or is this literally just an issue for
> > files with a more restrictive group mode than other mode?
> 
> Just that.
> 
> The ideas kicked around in the conversation were some variant of having
> a sysctl that says "This system never uses groups for negative
> permissions".
> 
> It was also suggested that if the sysctl was set the the permission
> checks would be altered such that even if someone tried to set a
> negative permission, the more liberal permissions of other would be used
> instead.

So then this would touch all the same code points which the
locked_groups approach would have to touch?

> Given that creating /etc/subgid is effectively opting out of negative
> permissions already have a sysctl that says that upfront feels like a
> very clean solution.
> 
> Eric

That feels like a cop-out to me.  If some young admin at Roxxon Corp decides
she needs to run a container, so installs subuid package and sets that sysctl,
how does she know whether or not some previous admin, who has since retired and
did not keep good docs, set things up so that a negative acl is keeping nginx
from reading some supersecret doc?

Now personally I'm not a great believer in the negative acls so I think the
above is a very unlikely scenario, but if we're going to worry about it, then
we should worry about it :)

"Click this button if noone has ever used feature X on this server"

-serge
