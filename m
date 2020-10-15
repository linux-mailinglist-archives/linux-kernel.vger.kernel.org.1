Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08828F5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgJOPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:32:27 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49835 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbgJOPc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:32:27 -0400
Received: from [192.168.1.155] ([95.114.97.143]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N94uf-1kQf451Ty3-016Bd8; Thu, 15 Oct 2020 17:31:50 +0200
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org
Cc:     Alexander Mihalicyn <alexander@mihalicyn.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Wat Lim <watl@google.com>, Mrunal Patel <mpatel@redhat.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <cb6c6f1a-89ee-1762-3eec-4f69bd7739b1@metux.net>
Date:   Thu, 15 Oct 2020 17:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JA6LrJJtSGRZR2juLdm4r6JKn3coM8bLiyEwPxKL43OJpyW5TAK
 J+8ZvMhTAO1aRNlnib/d8GKkj/SyIGWSO01+uLmBY23inDY3ZZnH0q70b2/NO9Zj1hwde1p
 ExDmDdSBv2CzQ+KOWI4EhpneTYrbPugUhlYYpnxH8VTKaQhxy5Ie4nQ5Zy1z3uHBYXm2OjL
 dxshWEPytWFnQVucg2WNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OhtmHqpQM3U=:+wU7b6OYAGZWFy8aQu6SiR
 pO1dU14WlDReGRfJBtpL9jhfeAZ9PdStOEdyZo9v+KP4oHzrMoNGc5cP22d6DhxL+SvskPEIG
 j/f1tk4ZWuo3EyG86p91ezAspBL1FWdCNzMYNY14kkE3kg0retCLHr5ZhuGlp9cufxZsSPX3N
 V1TDmgixBceXZnM1MuSxC3ZRYPG3h+bY8e58eCRWxi2IvLohiH4s7CitL7dkp9C5ElOft2BEE
 6EDrwI7YCx/io9z8KN9DgKopIXFk0jl306iCc0yY8bGp6iYhC2pAyDXJV0jw3Wb8DkgUIrY+R
 rQC/4Z4whMTuM0e73T0uRhViJxgxjTjEC9xqZY4BXvIhY7Z1gYDlM18S8SpK/FPxIch2/+zRC
 rIXhtRls8fRSAKvP5SOOS3REAxkTsgy1s4HUFEM+5X0Xq/aeXvJctsFb22CV7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.20 16:39, Christian Brauner wrote:

Hi Christian,

> P1. Isolated id mappings can only be guaranteed to be locally isolated.
>     A container runtime/daemon can only guarantee non-overlapping id mappings
>     when no other users on the system create containers.

Indeed. But couldn't we just record the mappings in some standardized
place (eg. some file) which all engines maintain ?

I'd guess other solutions would need changes in the runtimes, too.

Please keep in mind that some scenarios actually need some overlaps, eg.
application containers that shall have direct access to home dirs.

> P2. Enforcing isolated id mappings in userspace is difficult.
>     It is always possible to create other processes with overlapping id
>     mappings. Coordinating id mappings in userspace will always remain
>     optional. Quite a few tools nowadays (including systemd) don't care about
>     /etc/sub{g,u}id and actively advise against using it. This is made even
>     more problematic since sub{g,u}iid delegation is done per-user rather than
>     per-container-runtime.

I believe subusers aren't meant for tyical containers (like docker or
lxc), but unprivileged user programs that wanna have further isolation
for subprocesses (eg. a browser's renderer or js engine).

Correct me if I'm wrong.

> P3. The range of the id mapping of a container can't be predetermined.
>     While POSIX mandates that a standard system should use a range of 65536 ids
>     reality is very different. Some programs allocate high ids for random
>     processes or for network authentication. This means, in practice it is
>     often necessary to assign a range of up to 10 million ids to a container.
>     This limits a system to less than 500 containers total.

In 25+ years, haven't seen such an application in the field. I'd
consider this a horrible and dangerous bug. Sane applications create
specific user entries (/etc/passwd) for that.

I'd say we're safe w/ max 2^16 users per container, which should give us
space for about 2^16 containers.

> P4. Isolated id mappings severely restrict the number of containers that can be
>     run on a system.
>     This ties back to the point about pre-determining the id range of a
>     container and how large range allocations tend to be on real systems. That
>     becomes even more relevant when nesting containers.

IMHO, all we need is to maintain a list of active ranges (more precisely
the 16bit prefixes, just like class B networks ;-)). As said, I'd
declare the scenario #P3 as invalid and rather fix those few broken
applications.

> P5. Container runtimes cannot reuse overlayfs lower directories if each
>     container uses isolated ID mappings, leading to either needless storage
>     overhead (LXD -- though the LXD folks don’t really mind), completely
>     ignoring the benefits of isolating containers from each other (Docker), or
>     not using them at all (Kubernetes). (This is a more general issue but bears
>     repeating since it is closely tied to most userns proposals.)

Indeed. That's IMHO the main problem. We somehow need to map the UIDs.
Maybe a synthetic filesystem that just does exactly the same uid<->kuid
translations we're already doing in other places ?

> P6. Rlimits pose a problem for containers that share the same id mapping.
>     This means containers with overlapping id mappings can DOS each other by
>     exhausting their rlimits. The reason for this lies with the current
>     implementation of rlimits -- rlimits are currently tied to users and are
>     not hierarchically limited like inotify limits are. This is a severe
>     problem in unprivileged workloads. Eric and others identified that this
>     issue can be fixed independently of the isolated user namespace proposal.

Is this really an practical isssue, when we're using uid namespaces ?

> S2. Kernel-enforced user namespace isolation.
>     This means, there is no need for different container runtimes to
>     collaborate on id ranges with immediate benefits for everyone.
>     This solves P1 and P2.

Okay, but how to support scenarios where some of the UIDs should
overlap on purpose ? (eg. mounting some of the host's user homedirs
into namespaces ?)

> S5. The owning id concept of a user namespace makes monitoring and interacting
>     with such containers way easier.

What exactly is the owning id ? How is it created and managed ?
Some magic id or an cryptographic token =

> 1. How are interactions across isolated user namespaces handled?

What kind of interaction do you have in mind ?
Data transfers ? Process manipulaton ? Namespace destruction ?

Can you please illustrate some actual use cases ?

>    Proposal 1.1 semmed prefered since it would allow an unprivileged
>    user creating an isolated user namespace to kill/ptrace all processes
>    in the isolated namespace they spawned. 

Don't we already have this if this user is mapped as root inside the
container ?

>    The first consensus reached seemed to be to decouple isolated user
>    namespaces from shiftfs. The idea is to solely rely on tmpfs and fuse
>    at the beginning as filesystems which can be mounted inside isolated
>    user namespaces and so would have proper ownership. 

So, I'd essentially have to run the whole rootfs through fuse and a
userland fileserver, which probably has to track things like ownerships
in its own db (when running under unprivileged user) ?

> For mount points
>    that originate from outside the namespace, everything will show as
>    the overflow ids and access would be restricted to the most
>    restricted permission bit for any path that can be accessed.

So, I can't just take a btrfs snapshot as rootfs anymore ?


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
