Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBD128E782
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgJNTqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:46:37 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44598 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNTqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:46:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kSmjE-00CGrH-J5; Wed, 14 Oct 2020 13:46:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kSmjD-0008OD-AJ; Wed, 14 Oct 2020 13:46:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Mrunal Patel <mpatel@redhat.com>, Wat Lim <watl@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        =?utf-8?Q?Micka=C3=ABl_Sal?= =?utf-8?Q?a=C3=BCn?= 
        <mic@digikod.net>, Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Stephane Graber <stgraber@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
        <20201010042606.GA30062@mail.hallyn.com>
        <20201011205306.GC17441@localhost>
        <CALCETrUZcHNwspz315KFvSPxtK8MmLUPfiN=hCBgx+wqeJe4+g@mail.gmail.com>
        <87h7r0qbqi.fsf@x220.int.ebiederm.org>
        <20201012150006.GA3503@mail.hallyn.com>
Date:   Wed, 14 Oct 2020 14:46:46 -0500
In-Reply-To: <20201012150006.GA3503@mail.hallyn.com> (Serge E. Hallyn's
        message of "Mon, 12 Oct 2020 10:00:06 -0500")
Message-ID: <87wnzsmvyx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kSmjD-0008OD-AJ;;;mid=<87wnzsmvyx.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/dzA0ojHgVFG1accwEPvk6reMlSI0NUgI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;"Serge E. Hallyn" <serge@hallyn.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 786 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.4%), b_tie_ro: 9 (1.2%), parse: 2.1 (0.3%),
        extract_message_metadata: 26 (3.3%), get_uri_detail_list: 6 (0.8%),
        tests_pri_-1000: 8 (1.0%), tests_pri_-950: 1.58 (0.2%),
        tests_pri_-900: 1.58 (0.2%), tests_pri_-90: 156 (19.9%), check_bayes:
        150 (19.1%), b_tokenize: 36 (4.6%), b_tok_get_all: 16 (2.0%),
        b_comp_prob: 7 (0.9%), b_tok_touch_all: 83 (10.6%), b_finish: 3.8
        (0.5%), tests_pri_0: 555 (70.7%), check_dkim_signature: 1.06 (0.1%),
        check_dkim_adsp: 5 (0.7%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        3.2 (0.4%), tests_pri_500: 17 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated user namespaces
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serge@hallyn.com> writes:

> On Mon, Oct 12, 2020 at 12:01:09AM -0500, Eric W. Biederman wrote:
>> Andy Lutomirski <luto@kernel.org> writes:
>> 
>> > On Sun, Oct 11, 2020 at 1:53 PM Josh Triplett <josh@joshtriplett.org> wrote:
>> >>
>> >> On Fri, Oct 09, 2020 at 11:26:06PM -0500, Serge E. Hallyn wrote:
>> >> > > 3. Find a way to allow setgroups() in a user namespace while keeping
>> >> > >    in mind the case of groups used for negative access control.
>> >> > >    This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
>> >> > >    investigate adding a prctl() to allow setgroups() to be called in a user
>> >> > >    namespace at the cost of restricting paths to the most restrictive
>> >> > >    permission. So if something is 0707 it needs to be treated as if it's 0000
>> >> > >    even though the caller is not in its owning group which is used for negative
>> >> > >    access control (how these new semantics will interact with ACLs will also
>> >> > >    need to be looked into).
>> >> >
>> >> > I should probably think this through more, but for this problem, would it
>> >> > not suffice to add a new prevgroups grouplist to the struct cred, maybe
>> >> > struct group_info *locked_groups, and every time an unprivileged task creates
>> >> > a new user namespace, add all its current groups to this list?
>> >>
>> >> So, effectively, you would be allowed to drop permissions, but
>> >> locked_groups would still be checked for restrictions?
>> >>
>> >> That seems like it'd introduce a new level of complexity (a new facet of
>> >> permission) to manage. Not opposed, but it does seem more complex than
>> >> just opting out of using groups for negative permissions.
>
> Yeah, it would, but I basically hoped that we could catch most of this at
> e.g. generic_permission(), and/or we could introduce a helper which
> automatically adds a check for permission denied from locked_groups, so
> it shouldn't be too wide-spread.  If it does end up showing up all over
> the place, then that's a good reason not to do this.
>
>> > Is there any context other than regular UNIX DAC in which groups can
>> > act as negative permissions or is this literally just an issue for
>> > files with a more restrictive group mode than other mode?
>> 
>> Just that.
>> 
>> The ideas kicked around in the conversation were some variant of having
>> a sysctl that says "This system never uses groups for negative
>> permissions".
>> 
>> It was also suggested that if the sysctl was set the the permission
>> checks would be altered such that even if someone tried to set a
>> negative permission, the more liberal permissions of other would be used
>> instead.
>
> So then this would touch all the same code points which the
> locked_groups approach would have to touch?

No locked_groups would touch in_group_p and set_groups.  Especially what
set_groups means in that context.  It would have to handle what happens
when you start accumulating locked groups (because of multiple
namespaces).  How you dedup locked groups etc.

I was not able to convince myself that not being able to clear out
groups that a user has when they create a user namespace won't cause
other problems.  Especially as user namespaces had been in use for a
while at that point.

Not supporting negative groups would touch acl_permission and modify it
like:

 static int acl_permission_check(struct inode *inode, int mask)
 {
[irrelveant code snipped]
 	/* Only RWX matters for group/other mode bits */
 	mask &= 7;
 
 	/*
 	 * Are the group permissions different from
 	 * the other permissions in the bits we care
 	 * about? Need to check group ownership if so.
 	 */
 	if (mask & (mode ^ (mode >> 3))) {
-		if (in_group_p(inode->i_gid))
+		if (in_group_p(inode->i_gid) &&
+		    (!sysctl_force_positive_groups ||
+		    (mask & ~(mode >> 3)))
 			mode >>= 3;
 	}
 
 	/* Bits in 'mode' clear that we require? */
 	return (mask & ~mode) ? -EACCES : 0;
 }


I don't know that we need to do that.  But it would might be a good way
of flushing out the issues.


>> Given that creating /etc/subgid is effectively opting out of negative
>> permissions already have a sysctl that says that upfront feels like a
>> very clean solution.
>> 
>> Eric
>
> That feels like a cop-out to me.  If some young admin at Roxxon Corp decides
> she needs to run a container, so installs subuid package and sets that sysctl,
> how does she know whether or not some previous admin, who has since retired and
> did not keep good docs, set things up so that a negative acl is keeping nginx
> from reading some supersecret doc?
>
> Now personally I'm not a great believer in the negative acls so I think the
> above is a very unlikely scenario, but if we're going to worry about it, then
> we should worry about it :)

There is a different between guaranting we don't break existing setups
when a new feature is enabled, and supporting old very rare setups when
a new feature is enabled.


> "Click this button if noone has ever used feature X on this server"

My current thinking is that if we already don't honor negative groups
when /etc/subgid exists it would not hurt to make that more explicit.


From what we could tell at the time people that know negative groups are
honored much less systems that actually use negative groups are
exceedingly rare.

Eric

