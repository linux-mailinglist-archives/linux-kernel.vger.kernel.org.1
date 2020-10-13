Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CCD28D113
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbgJMPRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387958AbgJMPRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602602268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yE0LZDX59NpDgXWDhZZ8K9ihlvUwft45zDRWDFtfpLE=;
        b=YGtPI+ixY76r6iEg7VkddRj5mcXCcqJc+IQau5x31gByEKf3Yzs7RYDQIZauHV9TmU1o5S
        OoW5q78cSy+jXfuRAFdWweVDAFq66LTW1muVVapAFyffHK8Vl6zVP78bFw//z7NPPk8IAL
        CCC59r3RmfLYd/OleISjspmSjoWDq5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-sw6vhJYANiiMPD_obAi44A-1; Tue, 13 Oct 2020 11:17:43 -0400
X-MC-Unique: sw6vhJYANiiMPD_obAi44A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64E88801FD8;
        Tue, 13 Oct 2020 15:17:40 +0000 (UTC)
Received: from localhost (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7B386EF7C;
        Tue, 13 Oct 2020 15:17:38 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Mrunal Patel <mpatel@redhat.com>, Wat Lim <watl@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephane Graber <stgraber@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
        <20201010042606.GA30062@mail.hallyn.com>
        <20201011205306.GC17441@localhost> <87tuuzv0hl.fsf@redhat.com>
        <20201013124650.GA19668@mail.hallyn.com>
Date:   Tue, 13 Oct 2020 17:17:36 +0200
In-Reply-To: <20201013124650.GA19668@mail.hallyn.com> (Serge E. Hallyn's
        message of "Tue, 13 Oct 2020 07:46:50 -0500")
Message-ID: <87o8l6qhnz.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serge@hallyn.com> writes:

> On Mon, Oct 12, 2020 at 07:05:10PM +0200, Giuseppe Scrivano wrote:
>> Josh Triplett <josh@joshtriplett.org> writes:
>> 
>> > On Fri, Oct 09, 2020 at 11:26:06PM -0500, Serge E. Hallyn wrote:
>> >> > 3. Find a way to allow setgroups() in a user namespace while keeping
>> >> >    in mind the case of groups used for negative access control.
>> >> >    This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
>> >> >    investigate adding a prctl() to allow setgroups() to be called in a user
>> >> >    namespace at the cost of restricting paths to the most restrictive
>> >> >    permission. So if something is 0707 it needs to be treated as if it's 0000
>> >> >    even though the caller is not in its owning group which is used for negative
>> >> >    access control (how these new semantics will interact with ACLs will also
>> >> >    need to be looked into).
>> >> 
>> >> I should probably think this through more, but for this problem, would it
>> >> not suffice to add a new prevgroups grouplist to the struct cred, maybe
>> >> struct group_info *locked_groups, and every time an unprivileged task creates
>> >> a new user namespace, add all its current groups to this list?
>> >
>> > So, effectively, you would be allowed to drop permissions, but
>> > locked_groups would still be checked for restrictions?
>> >
>> > That seems like it'd introduce a new level of complexity (a new facet of
>> > permission) to manage. Not opposed, but it does seem more complex than
>> > just opting out of using groups for negative permissions.
>> 
>> I have played with something similar in the past.  At that time I've
>> discussed it only privately with Eric and we agreed it wasn't worth the
>> extra complexity:
>> 
>> https://github.com/giuseppe/linux/commit/7e0701b389c497472d11fab8570c153a414050af
>
> Hi, you linked the setgroups patch, but do you also have a link to the
> attempt which you deemed was not worth it?

it was just part of a private discussion; but was 4 years ago so we can
probably revisit and accept the additional complexity since setgroups()
is still an issue with user namespaces.


>> instead of a prctl, I've added a new mode to /proc/PID/setgroups that
>> allows setgroups in a userns locking the current gids.
>> 
>> What do you think about using /proc/PID/setgroups instead of a new
>> prctl()?
>
> It's better than not having it, but two concerns -
>
> 1. some userspace, especially testsuites, could become confused by the fact
> that they can't drop groups no matter how hard they try, since these will all
> still show up as regular groups.

I forgot to send a link to a second patch :-) that completes the feature:
https://github.com/giuseppe/linux/commit/1c5fe726346b216293a527719e64f34e6297f0c2

When the new mode is used, the gids that are not known in the userns do
not show up in userspace.

> 2. whereas in my lockgroups proposal, lock_groups would only be taken into account
> for permission denial, this proposal would count for permission grants too.  This
> means that if I have a group which is permitted to read /foo/topsecret, and I
> start a program in a new user namespace expecting it to drop that permission,
> I can't have that, right?  The new program, will always have that permission?

right.  The new mode I was working on cannot be used to drop granted permissions.

Giuseppe

