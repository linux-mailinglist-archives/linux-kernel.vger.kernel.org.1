Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3735428BEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403979AbgJLRFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403931AbgJLRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602522321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=48/p/swHiO9g9EftOv4fYGSl8TGG6SINHcN0wha0CCE=;
        b=GJGhHjLr1bv8wtcQ82Ho+G+WFB2gHcACTXohCMdYjeW3RysZd10UVay7h6XMcl5+HCJt/F
        y4GDPRqnA8o7CMU6EkDxM7OV8SzYOUay1KAx+uWDOV6LCli0FuymM3tNCMfKdps+SLHRj8
        Ytb4aS2sy1fBXjl52OIivMK9SANncRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-l02HyH2QMNmHeMm_ZtZX9A-1; Mon, 12 Oct 2020 13:05:16 -0400
X-MC-Unique: l02HyH2QMNmHeMm_ZtZX9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FEC3ADC26;
        Mon, 12 Oct 2020 17:05:13 +0000 (UTC)
Received: from localhost (ovpn-114-124.ams2.redhat.com [10.36.114.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B322C31E;
        Mon, 12 Oct 2020 17:05:11 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
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
        <20201011205306.GC17441@localhost>
Date:   Mon, 12 Oct 2020 19:05:10 +0200
In-Reply-To: <20201011205306.GC17441@localhost> (Josh Triplett's message of
        "Sun, 11 Oct 2020 13:53:06 -0700")
Message-ID: <87tuuzv0hl.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> On Fri, Oct 09, 2020 at 11:26:06PM -0500, Serge E. Hallyn wrote:
>> > 3. Find a way to allow setgroups() in a user namespace while keeping
>> >    in mind the case of groups used for negative access control.
>> >    This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
>> >    investigate adding a prctl() to allow setgroups() to be called in a user
>> >    namespace at the cost of restricting paths to the most restrictive
>> >    permission. So if something is 0707 it needs to be treated as if it's 0000
>> >    even though the caller is not in its owning group which is used for negative
>> >    access control (how these new semantics will interact with ACLs will also
>> >    need to be looked into).
>> 
>> I should probably think this through more, but for this problem, would it
>> not suffice to add a new prevgroups grouplist to the struct cred, maybe
>> struct group_info *locked_groups, and every time an unprivileged task creates
>> a new user namespace, add all its current groups to this list?
>
> So, effectively, you would be allowed to drop permissions, but
> locked_groups would still be checked for restrictions?
>
> That seems like it'd introduce a new level of complexity (a new facet of
> permission) to manage. Not opposed, but it does seem more complex than
> just opting out of using groups for negative permissions.

I have played with something similar in the past.  At that time I've
discussed it only privately with Eric and we agreed it wasn't worth the
extra complexity:

https://github.com/giuseppe/linux/commit/7e0701b389c497472d11fab8570c153a414050af

instead of a prctl, I've added a new mode to /proc/PID/setgroups that
allows setgroups in a userns locking the current gids.

What do you think about using /proc/PID/setgroups instead of a new
prctl()?

Giuseppe

