Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC5289E55
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 06:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgJJEfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 00:35:07 -0400
Received: from mail.hallyn.com ([178.63.66.53]:48294 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgJJEeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 00:34:06 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Oct 2020 00:34:06 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 9A31682C; Fri,  9 Oct 2020 23:26:06 -0500 (CDT)
Date:   Fri, 9 Oct 2020 23:26:06 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     containers@lists.linux-foundation.org,
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
        Sargun Dhillon <sargun@sargun.me>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
Message-ID: <20201010042606.GA30062@mail.hallyn.com>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 3. Find a way to allow setgroups() in a user namespace while keeping
>    in mind the case of groups used for negative access control.
>    This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
>    investigate adding a prctl() to allow setgroups() to be called in a user
>    namespace at the cost of restricting paths to the most restrictive
>    permission. So if something is 0707 it needs to be treated as if it's 0000
>    even though the caller is not in its owning group which is used for negative
>    access control (how these new semantics will interact with ACLs will also
>    need to be looked into).

I should probably think this through more, but for this problem, would it
not suffice to add a new prevgroups grouplist to the struct cred, maybe
struct group_info *locked_groups, and every time an unprivileged task creates
a new user namespace, add all its current groups to this list?
