Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE432916E8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 12:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgJRKUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 06:20:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35292 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgJRKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 06:20:47 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kU5nf-0004hT-FV; Sun, 18 Oct 2020 10:20:27 +0000
Date:   Sun, 18 Oct 2020 12:20:26 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     containers@lists.linux-foundation.org,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@amacapital.net>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Wat Lim <watl@google.com>, Mrunal Patel <mpatel@redhat.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
Message-ID: <20201018102026.34jtxfheygowgejp@wittgenstein>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
 <cb6c6f1a-89ee-1762-3eec-4f69bd7739b1@metux.net>
 <874kmsdcdx.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kmsdcdx.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 11:51:22AM -0500, Eric W. Biederman wrote:
> "Enrico Weigelt, metux IT consult" <lkml@metux.net> writes:
> 
> > On 30.08.20 16:39, Christian Brauner wrote:
> >
> > Hi Christian,
> >
> >> P1. Isolated id mappings can only be guaranteed to be locally isolated.
> >>     A container runtime/daemon can only guarantee non-overlapping id mappings
> >>     when no other users on the system create containers.
> >
> > Indeed. But couldn't we just record the mappings in some standardized
> > place (eg. some file) which all engines maintain ?
> >
> > I'd guess other solutions would need changes in the runtimes, too.
> >
> > Please keep in mind that some scenarios actually need some overlaps, eg.
> > application containers that shall have direct access to home dirs.
> >
> >> P2. Enforcing isolated id mappings in userspace is difficult.
> >>     It is always possible to create other processes with overlapping id
> >>     mappings. Coordinating id mappings in userspace will always remain
> >>     optional. Quite a few tools nowadays (including systemd) don't care about
> >>     /etc/sub{g,u}id and actively advise against using it. This is made even
> >>     more problematic since sub{g,u}iid delegation is done per-user rather than
> >>     per-container-runtime.
> >
> > I believe subusers aren't meant for tyical containers (like docker or
> > lxc), but unprivileged user programs that wanna have further isolation
> > for subprocesses (eg. a browser's renderer or js engine).
> >
> > Correct me if I'm wrong.
> 
> There is an on-going trend to make unprivileged containers typical
> containers.

In general, this is something we all have been collectively pushing on
for years. Our users running LXD run unprivileged containers by default.
The daemon requires you to explicitly request running privileged
containers. All Linux workloads on Chromebooks are LXD-based and are
thus run in fully unprivileged containers so are all workloads on
ppc/arm64/s390x on Travis.
And now we're finally also see more runC based container managers like
Podman/cri-o adopting unprivileged containers too. So this is becoming
more and more common and in the interest of security we have an
obligation to help push for more adoption.

> 
> >> P3. The range of the id mapping of a container can't be predetermined.
> >>     While POSIX mandates that a standard system should use a range of 65536 ids
> >>     reality is very different. Some programs allocate high ids for random
> >>     processes or for network authentication. This means, in practice it is
> >>     often necessary to assign a range of up to 10 million ids to a container.
> >>     This limits a system to less than 500 containers total.
> >
> > In 25+ years, haven't seen such an application in the field. I'd
> > consider this a horrible and dangerous bug. Sane applications create
> > specific user entries (/etc/passwd) for that.
> >
> > I'd say we're safe w/ max 2^16 users per container, which should give us
> > space for about 2^16 containers.
> 
> I forget the details but systemd has a feature where it will randomly
> allocate a uid for a service.  Calling them something like temporariy uids.

and things like ldap, pam, or samba. The number is growing with
applications becoming more security aware. Here's an example from a user
reported bug:

Jun 13 02:05:39 xenial-template sshd[390]: Accepted password for sokoow from 10.21.34.100 port 37532 ssh2
Jun 13 02:05:39 xenial-template sshd[390]: pam_keyinit(sshd:session): Unable to change GID to 99000 temporarily
Jun 13 02:05:39 xenial-template sshd[390]: pam_unix(sshd:session): session opened for user sokoow by (uid=0)
Jun 13 02:05:39 xenial-template sshd[390]: pam_motd(sshd:session): pam_modutil_drop_priv: change_gid failed: Success
Jun 13 02:05:39 xenial-template sshd[390]: pam_motd(sshd:session): Unable to change UID to 10003 temporarily
Jun 13 02:05:39 xenial-template sshd[390]: pam_motd(sshd:session): pam_modutil_regain_priv: called with invalid state
Jun 13 02:05:39 xenial-template sshd[390]: pam_motd(sshd:session): Unable to change UID back to -1
Jun 13 02:05:39 xenial-template sshd[390]: pam_motd(sshd:session): pam_modutil_drop_priv: change_gid failed: Success
Jun 13 02:05:39 xenial-template sshd[390]: pam_motd(sshd:session): Unable to change UID to 10003 temporarily
Jun 13 02:05:39 xenial-template sshd[390]: pam_motd(sshd:session): pam_modutil_regain_priv: called with invalid state
Jun 13 02:05:39 xenial-template sshd[390]: pam_motd(sshd:session): Unable to change UID back to -1
Jun 13 02:05:39 xenial-template sshd[390]: pam_mail(sshd:session): pam_modutil_drop_priv: change_gid failed: Success

Maybe running application containers that problem is not as pressing
immediately but for containers running full systems bug reports
involving high id allocations are pretty common
https://github.com/lxc/lxd/issues/2111

There's nothing wrong with dropping to high ids technically and we can't
really enforce userspace stick to a 65536 range.

> 
> >> P4. Isolated id mappings severely restrict the number of containers that can be
> >>     run on a system.
> >>     This ties back to the point about pre-determining the id range of a
> >>     container and how large range allocations tend to be on real systems. That
> >>     becomes even more relevant when nesting containers.
> >
> > IMHO, all we need is to maintain a list of active ranges (more precisely
> > the 16bit prefixes, just like class B networks ;-)). As said, I'd
> > declare the scenario #P3 as invalid and rather fix those few broken
> > applications.
> 
> Which is /etc/subuid and /etc/subgid, and it was very much inspired from
> the same source.
> 
> >> P5. Container runtimes cannot reuse overlayfs lower directories if each
> >>     container uses isolated ID mappings, leading to either needless storage
> >>     overhead (LXD -- though the LXD folks don’t really mind), completely
> >>     ignoring the benefits of isolating containers from each other (Docker), or
> >>     not using them at all (Kubernetes). (This is a more general issue but bears
> >>     repeating since it is closely tied to most userns proposals.)
> >
> > Indeed. That's IMHO the main problem. We somehow need to map the UIDs.
> > Maybe a synthetic filesystem that just does exactly the same uid<->kuid
> > translations we're already doing in other places ?

I have another concrete proposal that I'm working on with Tycho, Serge,
and Aleksa and input from Seth hoping to have it ready somewhat soonish
after the merge window and I hope we can have a good discussion around
this.

> >
> >> P6. Rlimits pose a problem for containers that share the same id mapping.
> >>     This means containers with overlapping id mappings can DOS each other by
> >>     exhausting their rlimits. The reason for this lies with the current
> >>     implementation of rlimits -- rlimits are currently tied to users and are
> >>     not hierarchically limited like inotify limits are. This is a severe
> >>     problem in unprivileged workloads. Eric and others identified that this
> >>     issue can be fixed independently of the isolated user namespace proposal.
> >
> > Is this really an practical isssue, when we're using uid namespaces ?
> 
> Very much so.  There are containers who otherwise would use the same uid
> range. (AKA they have the same set of users).  But can't because there
> are cases like daemons that set their RLIMIT_NPROC to 1.  Because the
> daemon knows that user for that daemon will never run any other
> processes.
> 
> Run two containers with the same mappings and that daemon DOS's itself.

We have seen this problem and received bug reports about this. It is
especially a concern on shared infrastructure such as on aforementioned
Travis workloads.

> 
> >> S2. Kernel-enforced user namespace isolation.
> >>     This means, there is no need for different container runtimes to
> >>     collaborate on id ranges with immediate benefits for everyone.
> >>     This solves P1 and P2.
> >
> > Okay, but how to support scenarios where some of the UIDs should
> > overlap on purpose ? (eg. mounting some of the host's user homedirs
> > into namespaces ?)
> 
> Just have a limited number of mappings for the cases that actually need
> on-disk storage.  The key idea is adding uids that don't need to be
> mapped.  Everything else stays the same.
> 
> >> S5. The owning id concept of a user namespace makes monitoring and interacting
> >>     with such containers way easier.
> >
> > What exactly is the owning id ? How is it created and managed ?
> > Some magic id or an cryptographic token =
> 
> Not a new thing.  Just the user that created the user namespace.
> It is suggested to refine the idea so that users that don't map
> anywhere show up as the creator of the user namespace.
> 
> >> 1. How are interactions across isolated user namespaces handled?
> >
> > What kind of interaction do you have in mind ?
> > Data transfers ? Process manipulaton ? Namespace destruction ?
> >
> > Can you please illustrate some actual use cases ?
> >
> >>    Proposal 1.1 semmed prefered since it would allow an unprivileged
> >>    user creating an isolated user namespace to kill/ptrace all processes
> >>    in the isolated namespace they spawned. 
> >
> > Don't we already have this if this user is mapped as root inside the
> > container ?
> 
> I think there were more concerns raised that I think actually exist.
> The owner/creator of a user namespace can already manage an container
> and send it signals.  That is built into the capability system call.
> Nothing needs to change there.
> 
> The only real question I see is which uids and gids do we show to
> processes that are outside of the user namespace, when the uids and gids
> don't map.

The idea was to use the overflow uid and gid and to introduce a new
sysctl that would allow an administrator to enforce that processes can't
setuid()/setgid() to the overflow uid or gid. The overflow uid and gid
are already configurable. This really does not seem that different from
seeing a bunch of extremely high-range uid and gids for unprivileged
containers in the ps output as we do today or even looking at a
filesystem from within a user namespace where the ids don't map.

> 
> >>    The first consensus reached seemed to be to decouple isolated user
> >>    namespaces from shiftfs. The idea is to solely rely on tmpfs and fuse
> >>    at the beginning as filesystems which can be mounted inside isolated
> >>    user namespaces and so would have proper ownership. 
> >
> > So, I'd essentially have to run the whole rootfs through fuse and a
> > userland fileserver, which probably has to track things like ownerships
> > in its own db (when running under unprivileged user) ?
> 
> The consensus was to start with what is working now.
> 
> Users that don't map outside of the user namespace will show up and work
> properly in on tmpfs.  Or a fuse implementation of ext4 on top of a
> file.
> 
> >> For mount points
> >>    that originate from outside the namespace, everything will show as
> >>    the overflow ids and access would be restricted to the most
> >>    restricted permission bit for any path that can be accessed.
> >
> > So, I can't just take a btrfs snapshot as rootfs anymore ?
> 
> Interesting until reading through your commentary I had missed the
> proposal to effectively effectively change the permissions to:
> ((mode >> 3) & (mode >> 6) & mode & 7).
> 
> The challenge is that in a permission triple it is possible to set
> lower permissions for the owner of the file, or for a specific group,
> than for everyone else.
> 
> Today we require root permissions to be able to map users and groups in
> /proc/<pid>/uid_map and /proc/<pid>/gid_map, and we require root
> permissions to be able to drop groups with setgroups.
> 
> Now we are discussiong moving to a world where we can use users and
> groups that don't map to any other user namespace in uid_map and
> gid_map.  It should be completely safe to use those users and groups
> except for negative permissions in filesystems.  So a big question is
> how do we arrange the system so anyone can use those files without
> negative permission causing problems.
> 
> 
> I believe it is safe to not limit the owner of a file, as the
> owner of a file can always chmode the file and remove any restrictions.
> Which is no worse than calling setuid to a different uid.
> 
> Which leaves where we have been dealing with the ability to drop groups
> with setgroups.
> 
> I guess the practical proposal is when the !in_group_p and we are
> looking at the other permission.  Treat the permissions as:
> ((mode >> 3) & mode & 7).  Instead of just (mode & 7).
> 
> Which for systems who don't use negative group permissions is a no-op.
> So this should not effect your btrfs snapshots at all (unless you use
> negative group permissions).
> 
> It denies things before we get to an NFS server or other interesting
> case so it should work for pretty much everything the kernel deals with.
> 
> Userspace repeating permission checks could break.  But that is just a
> problem of inconsistency, and will always be a problem.
> 
> We could make it more precise as Serge was suggesting with a set of that
> were dropped from setgroups, but under the assumption that negative
> groups are sufficient rare we can avoid that overhead.

I'm tempted to agree and say that it's safe to assume that they are used
very much. Negative acls have been brought up a couple of times in
related contexts though. One being a potential bug in newgidmap which we
discussed back in
https://bugs.launchpad.net/ubuntu/+source/shadow/+bug/1729357
But I think if we have this under a sysctl as proposed earlier is good
enough.

> 
>  static int acl_permission_check(struct inode *inode, int mask)
>  {
>  	unsigned int mode = inode->i_mode;
>  
> - [irrelevant bits of this function]        
>  
>  	/* Only RWX matters for group/other mode bits */
>  	mask &= 7;
>  
>  	/*
>  	 * Are the group permissions different from
>  	 * the other permissions in the bits we care
>  	 * about? Need to check group ownership if so.
>  	 */
>  	if (mask & (mode ^ (mode >> 3))) {
>  		if (in_group_p(inode->i_gid))
>  			mode >>= 3;
> +		/* Use the most restrictive permissions? */
> +		else (current->user_ns->flags & USERNS_ALWAYS_DENY_GROUPS)
> +			mode &= (mode >> 3);
>  	}
>  
>  	/* Bits in 'mode' clear that we require? */
>  	return (mask & ~mode) ? -EACCES : 0;
>  }
> 
> As I read posix_acl_permission all of the posix acls for groups are
> positive permissions.  So I think the only other code that would need to
> be updated would be the filesystems that replace generic_permission with
> something that doesn't call acl_permission check.
> 
> Userspace could then activate this mode with:
> 	echo "safely_allow" > /proc/<pid>/setgroups
> 
> That looks very elegant and simple, and I don't think will cause
> problems for anyone.  It might even make sense to make that the default
> mode when creating a new user namespace.
> 
> I guess we owe this idea to Josh Triplett and Geoffrey Thomas.
> 
> Does anyone see any problems with tweaking the permissions this way so
> that we can always allow setgroups in a user namespace?

This looks sane and simple. I would still think that making it opt-in
for a few kernel releases might be preferable to just making it the new
default. We can then revisit flipping the default. Advanced enough
container runtimes will quickly pick up on this and can make it the
default for their unprivileged containers if they want to.

Christian
