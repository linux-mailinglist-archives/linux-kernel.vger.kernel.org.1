Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8828F4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgJOO1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:27:13 -0400
Received: from mail.hallyn.com ([178.63.66.53]:44108 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbgJOO1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:27:12 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id A84181105; Thu, 15 Oct 2020 09:27:09 -0500 (CDT)
Date:   Thu, 15 Oct 2020 09:27:09 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
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
Message-ID: <20201015142709.GA25286@mail.hallyn.com>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
 <20201010042606.GA30062@mail.hallyn.com>
 <20201011205306.GC17441@localhost>
 <CALCETrUZcHNwspz315KFvSPxtK8MmLUPfiN=hCBgx+wqeJe4+g@mail.gmail.com>
 <87h7r0qbqi.fsf@x220.int.ebiederm.org>
 <20201012150006.GA3503@mail.hallyn.com>
 <87wnzsmvyx.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnzsmvyx.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 02:46:46PM -0500, Eric W. Biederman wrote:
> "Serge E. Hallyn" <serge@hallyn.com> writes:
> 
> > On Mon, Oct 12, 2020 at 12:01:09AM -0500, Eric W. Biederman wrote:
> >> Andy Lutomirski <luto@kernel.org> writes:
> >> 
> >> > On Sun, Oct 11, 2020 at 1:53 PM Josh Triplett <josh@joshtriplett.org> wrote:
> >> >>
> >> >> On Fri, Oct 09, 2020 at 11:26:06PM -0500, Serge E. Hallyn wrote:
> >> >> > > 3. Find a way to allow setgroups() in a user namespace while keeping
> >> >> > >    in mind the case of groups used for negative access control.
> >> >> > >    This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
> >> >> > >    investigate adding a prctl() to allow setgroups() to be called in a user
> >> >> > >    namespace at the cost of restricting paths to the most restrictive
> >> >> > >    permission. So if something is 0707 it needs to be treated as if it's 0000
> >> >> > >    even though the caller is not in its owning group which is used for negative
> >> >> > >    access control (how these new semantics will interact with ACLs will also
> >> >> > >    need to be looked into).
> >> >> >
> >> >> > I should probably think this through more, but for this problem, would it
> >> >> > not suffice to add a new prevgroups grouplist to the struct cred, maybe
> >> >> > struct group_info *locked_groups, and every time an unprivileged task creates
> >> >> > a new user namespace, add all its current groups to this list?
> >> >>
> >> >> So, effectively, you would be allowed to drop permissions, but
> >> >> locked_groups would still be checked for restrictions?
> >> >>
> >> >> That seems like it'd introduce a new level of complexity (a new facet of
> >> >> permission) to manage. Not opposed, but it does seem more complex than
> >> >> just opting out of using groups for negative permissions.
> >
> > Yeah, it would, but I basically hoped that we could catch most of this at
> > e.g. generic_permission(), and/or we could introduce a helper which
> > automatically adds a check for permission denied from locked_groups, so
> > it shouldn't be too wide-spread.  If it does end up showing up all over
> > the place, then that's a good reason not to do this.
> >
> >> > Is there any context other than regular UNIX DAC in which groups can
> >> > act as negative permissions or is this literally just an issue for
> >> > files with a more restrictive group mode than other mode?
> >> 
> >> Just that.
> >> 
> >> The ideas kicked around in the conversation were some variant of having
> >> a sysctl that says "This system never uses groups for negative
> >> permissions".
> >> 
> >> It was also suggested that if the sysctl was set the the permission
> >> checks would be altered such that even if someone tried to set a
> >> negative permission, the more liberal permissions of other would be used
> >> instead.
> >
> > So then this would touch all the same code points which the
> > locked_groups approach would have to touch?
> 
> No locked_groups would touch in_group_p and set_groups.  Especially what
> set_groups means in that context.  It would have to handle what happens
> when you start accumulating locked groups (because of multiple
> namespaces).  How you dedup locked groups etc.

Well since group_info is sorted, you should be able to do a pretty
simple and quick merge of current->locked_groups and
current->group_info.  I suppose we'd have to consider a nasty user who
is allocated 100k groups, sticks them all in groupinfo, then unshare
twice, locking the kernel up for awhile, but that user can already hurt
us.

> I was not able to convince myself that not being able to clear out
> groups that a user has when they create a user namespace won't cause
> other problems.  Especially as user namespaces had been in use for a
> while at that point.

The locked_groups would *only* be considered for negative acls, right?
You would not *grant* any perms based on them.  It seems like exactly
what you want.  If any user is denied perms on account of it, then that
was the intent, and that's the whole reason we're having this problem.
We are discussing whether it's ok to let a new user_ns be a way to
bypass that restriction - not *looking* for a way to support bypassing
it.

I could state this as a more formal proof if you like.

> Not supporting negative groups would touch acl_permission and modify it
> like:
> 
>  static int acl_permission_check(struct inode *inode, int mask)
>  {
> [irrelveant code snipped]
>  	/* Only RWX matters for group/other mode bits */
>  	mask &= 7;
>  
>  	/*
>  	 * Are the group permissions different from
>  	 * the other permissions in the bits we care
>  	 * about? Need to check group ownership if so.
>  	 */
>  	if (mask & (mode ^ (mode >> 3))) {
> -		if (in_group_p(inode->i_gid))
> +		if (in_group_p(inode->i_gid) &&
> +		    (!sysctl_force_positive_groups ||
> +		    (mask & ~(mode >> 3)))
>  			mode >>= 3;
>  	}
>  
>  	/* Bits in 'mode' clear that we require? */
>  	return (mask & ~mode) ? -EACCES : 0;
>  }
> 
> 
> I don't know that we need to do that.  But it would might be a good way
> of flushing out the issues.
> 
> 
> >> Given that creating /etc/subgid is effectively opting out of negative
> >> permissions already have a sysctl that says that upfront feels like a
> >> very clean solution.
> >> 
> >> Eric
> >
> > That feels like a cop-out to me.  If some young admin at Roxxon Corp decides
> > she needs to run a container, so installs subuid package and sets that sysctl,
> > how does she know whether or not some previous admin, who has since retired and
> > did not keep good docs, set things up so that a negative acl is keeping nginx
> > from reading some supersecret doc?
> >
> > Now personally I'm not a great believer in the negative acls so I think the
> > above is a very unlikely scenario, but if we're going to worry about it, then
> > we should worry about it :)
> 
> There is a different between guaranting we don't break existing setups
> when a new feature is enabled, and supporting old very rare setups when
> a new feature is enabled.

If the new feature is enabled by default, then no.  (I know the kernel
kconfig =n, but these users likely are using a distribution, which
probably enables it)

And I also argue that if the new feature appears unrelated and is highly
desirable, then again no.  Everyone these days wants to "enable
container support" and it seems unrelated to using file permissions the
way they appear meant to be used (I know I'm contradicting myself here
:)  It's not like we are stopping support for an old architecture.  It's
a behavior resulting from a combination of ordinary configuration pieces
spread throught a system which is hard for a new admin to know is
actually being used.  I guess let me put it this way:  I don't think
that when a new admin is hired, she is told "Now remember, we use acls
to deny file permissions to certain users based on their groupid, watch
out for that."

> > "Click this button if noone has ever used feature X on this server"
> 
> My current thinking is that if we already don't honor negative groups
> when /etc/subgid exists it would not hurt to make that more explicit.

Ok, if that's how everyone feels, then I'll step back.

It was just an idea :)

I prefer, in this case, a simple host-wide sysctl to allow setgroups.

> >From what we could tell at the time people that know negative groups are
> honored much less systems that actually use negative groups are
> exceedingly rare.

You're probably right, but again I think if you did a survey, many
people who are using it probably answered no because they either
forgot or don't think of it in those terms.

-serge
