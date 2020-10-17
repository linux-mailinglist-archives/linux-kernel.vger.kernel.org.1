Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B37291346
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438674AbgJQQv1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 17 Oct 2020 12:51:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56890 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438633AbgJQQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 12:51:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kTpQB-003rsF-Oa; Sat, 17 Oct 2020 10:51:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kTpQA-0004b7-CI; Sat, 17 Oct 2020 10:51:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Enrico Weigelt\, metux IT consult" <lkml@metux.net>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
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
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
        <cb6c6f1a-89ee-1762-3eec-4f69bd7739b1@metux.net>
Date:   Sat, 17 Oct 2020 11:51:22 -0500
In-Reply-To: <cb6c6f1a-89ee-1762-3eec-4f69bd7739b1@metux.net> (Enrico
        Weigelt's message of "Thu, 15 Oct 2020 17:31:45 +0200")
Message-ID: <874kmsdcdx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1kTpQA-0004b7-CI;;;mid=<874kmsdcdx.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Tp7fo3PG+a6LIxX1FiHtlWjF8gEmudwk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,
        XMNoVowels,XMSubLong,XM_B_SpammyWords,XM_B_Unicode autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;"Enrico Weigelt\, metux IT consult" <lkml@metux.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1018 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (1.0%), b_tie_ro: 9 (0.9%), parse: 1.45 (0.1%),
         extract_message_metadata: 16 (1.6%), get_uri_detail_list: 6 (0.6%),
        tests_pri_-1000: 5 (0.5%), tests_pri_-950: 1.25 (0.1%),
        tests_pri_-900: 1.03 (0.1%), tests_pri_-90: 185 (18.1%), check_bayes:
        183 (17.9%), b_tokenize: 19 (1.9%), b_tok_get_all: 19 (1.9%),
        b_comp_prob: 6 (0.6%), b_tok_touch_all: 133 (13.1%), b_finish: 0.86
        (0.1%), tests_pri_0: 778 (76.4%), check_dkim_signature: 0.96 (0.1%),
        check_dkim_adsp: 2.8 (0.3%), poll_dns_idle: 0.72 (0.1%), tests_pri_10:
        2.5 (0.2%), tests_pri_500: 14 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated user namespaces
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Enrico Weigelt, metux IT consult" <lkml@metux.net> writes:

> On 30.08.20 16:39, Christian Brauner wrote:
>
> Hi Christian,
>
>> P1. Isolated id mappings can only be guaranteed to be locally isolated.
>>     A container runtime/daemon can only guarantee non-overlapping id mappings
>>     when no other users on the system create containers.
>
> Indeed. But couldn't we just record the mappings in some standardized
> place (eg. some file) which all engines maintain ?
>
> I'd guess other solutions would need changes in the runtimes, too.
>
> Please keep in mind that some scenarios actually need some overlaps, eg.
> application containers that shall have direct access to home dirs.
>
>> P2. Enforcing isolated id mappings in userspace is difficult.
>>     It is always possible to create other processes with overlapping id
>>     mappings. Coordinating id mappings in userspace will always remain
>>     optional. Quite a few tools nowadays (including systemd) don't care about
>>     /etc/sub{g,u}id and actively advise against using it. This is made even
>>     more problematic since sub{g,u}iid delegation is done per-user rather than
>>     per-container-runtime.
>
> I believe subusers aren't meant for tyical containers (like docker or
> lxc), but unprivileged user programs that wanna have further isolation
> for subprocesses (eg. a browser's renderer or js engine).
>
> Correct me if I'm wrong.

There is an on-going trend to make unprivileged containers typical
containers.

>> P3. The range of the id mapping of a container can't be predetermined.
>>     While POSIX mandates that a standard system should use a range of 65536 ids
>>     reality is very different. Some programs allocate high ids for random
>>     processes or for network authentication. This means, in practice it is
>>     often necessary to assign a range of up to 10 million ids to a container.
>>     This limits a system to less than 500 containers total.
>
> In 25+ years, haven't seen such an application in the field. I'd
> consider this a horrible and dangerous bug. Sane applications create
> specific user entries (/etc/passwd) for that.
>
> I'd say we're safe w/ max 2^16 users per container, which should give us
> space for about 2^16 containers.

I forget the details but systemd has a feature where it will randomly
allocate a uid for a service.  Calling them something like temporariy uids.

>> P4. Isolated id mappings severely restrict the number of containers that can be
>>     run on a system.
>>     This ties back to the point about pre-determining the id range of a
>>     container and how large range allocations tend to be on real systems. That
>>     becomes even more relevant when nesting containers.
>
> IMHO, all we need is to maintain a list of active ranges (more precisely
> the 16bit prefixes, just like class B networks ;-)). As said, I'd
> declare the scenario #P3 as invalid and rather fix those few broken
> applications.

Which is /etc/subuid and /etc/subgid, and it was very much inspired from
the same source.

>> P5. Container runtimes cannot reuse overlayfs lower directories if each
>>     container uses isolated ID mappings, leading to either needless storage
>>     overhead (LXD -- though the LXD folks don’t really mind), completely
>>     ignoring the benefits of isolating containers from each other (Docker), or
>>     not using them at all (Kubernetes). (This is a more general issue but bears
>>     repeating since it is closely tied to most userns proposals.)
>
> Indeed. That's IMHO the main problem. We somehow need to map the UIDs.
> Maybe a synthetic filesystem that just does exactly the same uid<->kuid
> translations we're already doing in other places ?
>
>> P6. Rlimits pose a problem for containers that share the same id mapping.
>>     This means containers with overlapping id mappings can DOS each other by
>>     exhausting their rlimits. The reason for this lies with the current
>>     implementation of rlimits -- rlimits are currently tied to users and are
>>     not hierarchically limited like inotify limits are. This is a severe
>>     problem in unprivileged workloads. Eric and others identified that this
>>     issue can be fixed independently of the isolated user namespace proposal.
>
> Is this really an practical isssue, when we're using uid namespaces ?

Very much so.  There are containers who otherwise would use the same uid
range. (AKA they have the same set of users).  But can't because there
are cases like daemons that set their RLIMIT_NPROC to 1.  Because the
daemon knows that user for that daemon will never run any other
processes.

Run two containers with the same mappings and that daemon DOS's itself.

>> S2. Kernel-enforced user namespace isolation.
>>     This means, there is no need for different container runtimes to
>>     collaborate on id ranges with immediate benefits for everyone.
>>     This solves P1 and P2.
>
> Okay, but how to support scenarios where some of the UIDs should
> overlap on purpose ? (eg. mounting some of the host's user homedirs
> into namespaces ?)

Just have a limited number of mappings for the cases that actually need
on-disk storage.  The key idea is adding uids that don't need to be
mapped.  Everything else stays the same.

>> S5. The owning id concept of a user namespace makes monitoring and interacting
>>     with such containers way easier.
>
> What exactly is the owning id ? How is it created and managed ?
> Some magic id or an cryptographic token =

Not a new thing.  Just the user that created the user namespace.
It is suggested to refine the idea so that users that don't map
anywhere show up as the creator of the user namespace.

>> 1. How are interactions across isolated user namespaces handled?
>
> What kind of interaction do you have in mind ?
> Data transfers ? Process manipulaton ? Namespace destruction ?
>
> Can you please illustrate some actual use cases ?
>
>>    Proposal 1.1 semmed prefered since it would allow an unprivileged
>>    user creating an isolated user namespace to kill/ptrace all processes
>>    in the isolated namespace they spawned. 
>
> Don't we already have this if this user is mapped as root inside the
> container ?

I think there were more concerns raised that I think actually exist.
The owner/creator of a user namespace can already manage an container
and send it signals.  That is built into the capability system call.
Nothing needs to change there.

The only real question I see is which uids and gids do we show to
processes that are outside of the user namespace, when the uids and gids
don't map.

>>    The first consensus reached seemed to be to decouple isolated user
>>    namespaces from shiftfs. The idea is to solely rely on tmpfs and fuse
>>    at the beginning as filesystems which can be mounted inside isolated
>>    user namespaces and so would have proper ownership. 
>
> So, I'd essentially have to run the whole rootfs through fuse and a
> userland fileserver, which probably has to track things like ownerships
> in its own db (when running under unprivileged user) ?

The consensus was to start with what is working now.

Users that don't map outside of the user namespace will show up and work
properly in on tmpfs.  Or a fuse implementation of ext4 on top of a
file.

>> For mount points
>>    that originate from outside the namespace, everything will show as
>>    the overflow ids and access would be restricted to the most
>>    restricted permission bit for any path that can be accessed.
>
> So, I can't just take a btrfs snapshot as rootfs anymore ?

Interesting until reading through your commentary I had missed the
proposal to effectively effectively change the permissions to:
((mode >> 3) & (mode >> 6) & mode & 7).

The challenge is that in a permission triple it is possible to set
lower permissions for the owner of the file, or for a specific group,
than for everyone else.

Today we require root permissions to be able to map users and groups in
/proc/<pid>/uid_map and /proc/<pid>/gid_map, and we require root
permissions to be able to drop groups with setgroups.

Now we are discussiong moving to a world where we can use users and
groups that don't map to any other user namespace in uid_map and
gid_map.  It should be completely safe to use those users and groups
except for negative permissions in filesystems.  So a big question is
how do we arrange the system so anyone can use those files without
negative permission causing problems.


I believe it is safe to not limit the owner of a file, as the
owner of a file can always chmode the file and remove any restrictions.
Which is no worse than calling setuid to a different uid.

Which leaves where we have been dealing with the ability to drop groups
with setgroups.

I guess the practical proposal is when the !in_group_p and we are
looking at the other permission.  Treat the permissions as:
((mode >> 3) & mode & 7).  Instead of just (mode & 7).

Which for systems who don't use negative group permissions is a no-op.
So this should not effect your btrfs snapshots at all (unless you use
negative group permissions).

It denies things before we get to an NFS server or other interesting
case so it should work for pretty much everything the kernel deals with.

Userspace repeating permission checks could break.  But that is just a
problem of inconsistency, and will always be a problem.

We could make it more precise as Serge was suggesting with a set of that
were dropped from setgroups, but under the assumption that negative
groups are sufficient rare we can avoid that overhead.

 static int acl_permission_check(struct inode *inode, int mask)
 {
 	unsigned int mode = inode->i_mode;
 
- [irrelevant bits of this function]        
 
 	/* Only RWX matters for group/other mode bits */
 	mask &= 7;
 
 	/*
 	 * Are the group permissions different from
 	 * the other permissions in the bits we care
 	 * about? Need to check group ownership if so.
 	 */
 	if (mask & (mode ^ (mode >> 3))) {
 		if (in_group_p(inode->i_gid))
 			mode >>= 3;
+		/* Use the most restrictive permissions? */
+		else (current->user_ns->flags & USERNS_ALWAYS_DENY_GROUPS)
+			mode &= (mode >> 3);
 	}
 
 	/* Bits in 'mode' clear that we require? */
 	return (mask & ~mode) ? -EACCES : 0;
 }

As I read posix_acl_permission all of the posix acls for groups are
positive permissions.  So I think the only other code that would need to
be updated would be the filesystems that replace generic_permission with
something that doesn't call acl_permission check.

Userspace could then activate this mode with:
	echo "safely_allow" > /proc/<pid>/setgroups

That looks very elegant and simple, and I don't think will cause
problems for anyone.  It might even make sense to make that the default
mode when creating a new user namespace.

I guess we owe this idea to Josh Triplett and Geoffrey Thomas.

Does anyone see any problems with tweaking the permissions this way so
that we can always allow setgroups in a user namespace?

Eric

