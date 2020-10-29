Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48C29ED54
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgJ2Nof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:44:35 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37517 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgJ2Nod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:44:33 -0400
Received: from [192.168.1.155] ([77.9.65.9]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MVMJ7-1kzJYY2TOp-00SMPS; Thu, 29 Oct 2020 14:43:01 +0100
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@amacapital.net>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Wat Lim <watl@google.com>, Mrunal Patel <mpatel@redhat.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
 <cb6c6f1a-89ee-1762-3eec-4f69bd7739b1@metux.net>
 <874kmsdcdx.fsf@x220.int.ebiederm.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <1cfe5c76-f2ca-825f-9dd7-b5f090d49f95@metux.net>
Date:   Thu, 29 Oct 2020 14:42:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <874kmsdcdx.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1nj+U8HD8hqG21q/vUrZdGoS416V46sA0w8aUdmHMp/VEiHqNjd
 oxBqR+04CPyV3F7oUkBs78BON+q9y5YMTTcj4hCze/fVKUODyW6FjZbb7CMn8QfTPZvf5hI
 LJY38D62SuiJE6bHzWJarXKtAN3nRJct8be7q7T0PYgSSzf+QhQBfBYp52PRvDd/hVaj7Gz
 XmqbR+MmzkMTN5CcZt9Sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:imTZ6my1TWU=:OKQaJfr5McbsYNkrPLM3J7
 SARIxzKw2XdAMxgrzb1gDnu7tvsB9NjCXiFqfjfoJQgBZluEJskZHiaWhADBRrTnUZkBLykH9
 eKvOPcE+8ibnfNoHnyhK95R0rq651B6P/lWEpNu0+GXx0iBMHwptDslAv1cnw36bf982L646G
 hWTE1iJ5xeLkUGo3j6D4F1F/h8+uNFUCoOoynV41u2FgfAO+3DyTKtW7t8TH3HHgFgvbEfBke
 /GiG7O4O/h4HhkTi076OnuOIm9WUPKlDIFVaCVJwCWBV6ql27iQISGXTe91UnjOf4nJJzB2qu
 mL87/Dl+xnMjH7Jk9xXKXscfSTRw7VGZrHTuTMQgE4FJNl6U3r52PyjWxCX3IYkVeWP6Z1Y7I
 A/sa3N7J2BFhdXqPFKBi2UZ0xCKXyMPmePZRT50mOU25IOkwMCGTJp29oxTS2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.20 18:51, Eric W. Biederman wrote:

Hi folks,

>> I believe subusers aren't meant for tyical containers (like docker or
>> lxc), but unprivileged user programs that wanna have further isolation
>> for subprocesses (eg. a browser's renderer or js engine).
>>
>> Correct me if I'm wrong.
> 
> There is an on-going trend to make unprivileged containers typical
> containers.

Yes, that's what I hope for :)
But I'm still unsure whether these files really fit into the scenarios
we're currently discussing.

What still puzzles me: we've got several quite different scenarios
related to uid allocation and mapping. Maybe we should first work out,
what they all have in common ?

Some quick examples:

a) arbitrary user wants to run certain programs (eg. daemons) with
   limited privileges (eg. can access only certain resources, eg.
   subdir of is homedir), possibly under some different UID, but still
   have full control over them (signals, strace, ...) - without any
   special help by root.

b) arbitrary user wants to run some programs with different mounts
   (plan9 style) w/o any special help by root. (unprivileged mount_ns
   still needs user_ns, right ?)

c) arbitrary user wants to run some (docker-style) containerized
   GUI application, which needs access to certain files in his homedir,
   just if it would run directly

d) classical container workload (really being root inside it) with
   shared images and possibly shared directories w/ the calling user.

Steps to care of are eg:

* allocate new user-visible UIDs (usually w/ names assigned), either
  permanently or temporarily
* sane mapping between several namespaces (which ones exactly shall
  appear from inside vs outside ?)
* map file system permissions and fs uids

Tricky. How can we decide which mappings an unprivileged user shall be
allowed to do under which circumstances ?

Scanario a) container is running with (parts of) the host fs
            --> we need to make sure it cannot escape and access some
                sensible files
            --> different fs-UID mappings per fs ?
         b) container is running with its own fs image
            --> the image could be entirely under the unprivileged
                user's control (maybe created by him itself)
            --> uids recorded in the fs probably should be exactly those
                visible inside the container

Maybe we should put in a separate UID/permission translation layer
into VFS, which would process different policies (not just plain range
shifting, more possibly more complex translations) depending on the
namespace ?

> I forget the details but systemd has a feature where it will randomly
> allocate a uid for a service.  Calling them something like temporariy uids.

I'd consider this an horrible bug - especially from operating
perspective. As operator, I really want to know what users (uids) I've
got on the system. and what's running under them.
(I never user systemd, for tons of other reasons, anyways)

>> IMHO, all we need is to maintain a list of active ranges (more precisely
>> the 16bit prefixes, just like class B networks ;-)). As said, I'd
>> declare the scenario #P3 as invalid and rather fix those few broken
>> applications.
> 
> Which is /etc/subuid and /etc/subgid, and it was very much inspired from
> the same source.

Why not just moving this into some common daemon or access pattern ?
(outside the kernel)

>> Is this really an practical isssue, when we're using uid namespaces ?
> 
> Very much so.  There are containers who otherwise would use the same uid
> range. (AKA they have the same set of users).  But can't because there
> are cases like daemons that set their RLIMIT_NPROC to 1.  Because the
> daemon knows that user for that daemon will never run any other
> processes.

Just curious: why are these containers (smells like typical server
workloads) running with the same UIDs in the first place ?

Maybe because the lack of proper mapping of fs-uids ? (see above).
Or are there any reasons why they should run oder the same uid.

>>> S2. Kernel-enforced user namespace isolation.
>>>     This means, there is no need for different container runtimes to
>>>     collaborate on id ranges with immediate benefits for everyone.
>>>     This solves P1 and P2.
>>
>> Okay, but how to support scenarios where some of the UIDs should
>> overlap on purpose ? (eg. mounting some of the host's user homedirs
>> into namespaces ?)
> 
> Just have a limited number of mappings for the cases that actually need
> on-disk storage.  The key idea is adding uids that don't need to be
> mapped.  Everything else stays the same.

Okay, but the interesting question becomes: what does not to be mapped,
what not ? How exactly shall find that out in a generic manner ?

I guess your proposal only helps for those UIDs which are really random
allocated - or anything outside the explicitly given ranges, which
(IMHO) now is mapped to -1. Correct ?

Just a weird though: shall we introduce an 'mapping policy' object,
with callbacks for doing the actual translation ? The default one would
be the the current implementation, but we could add others as well.

>> What exactly is the owning id ? How is it created and managed ?
>> Some magic id or an cryptographic token =
> 
> Not a new thing.  Just the user that created the user namespace.
> It is suggested to refine the idea so that users that don't map
> anywhere show up as the creator of the user namespace.

So, an random UID outside the mapped ranges would map to the 'root'
inside the namespace and seen as the user that created the ns outside
it ?

> I think there were more concerns raised that I think actually exist.
> The owner/creator of a user namespace can already manage an container
> and send it signals.  That is built into the capability system call.
> Nothing needs to change there.

Can he do that with all users inside the namespace ?

> The only real question I see is which uids and gids do we show to
> processes that are outside of the user namespace, when the uids and gids
> don't map.

At least they should not overlap with other users within the parent ns,
and they should be unique. If they weren't IDs but actual names (like in
Plan9), we could just add the owning user name as prefix.

>>>    The first consensus reached seemed to be to decouple isolated user
>>>    namespaces from shiftfs. The idea is to solely rely on tmpfs and fuse
>>>    at the beginning as filesystems which can be mounted inside isolated
>>>    user namespaces and so would have proper ownership. 
>>
>> So, I'd essentially have to run the whole rootfs through fuse and a
>> userland fileserver, which probably has to track things like ownerships
>> in its own db (when running under unprivileged user) ?
> 
> The consensus was to start with what is working now.
> 
> Users that don't map outside of the user namespace will show up and work
> properly in on tmpfs.  Or a fuse implementation of ext4 on top of a
> file.

At that point, we could run everything via 9P ... ;-)


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
