Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05CE2F39B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406741AbhALTKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406723AbhALTKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:10:11 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42475C061795;
        Tue, 12 Jan 2021 11:09:31 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kzP2i-0007NT-Rj; Tue, 12 Jan 2021 20:09:25 +0100
To:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210110121033.130504-1-linux@leemhuis.info>
 <20210111194822.4kvl2tx24anyu23k@chatter.i7.local>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using
 bugzilla.kernel.org
Message-ID: <fba45829-cac3-9f53-c753-0b08d813aa83@leemhuis.info>
Date:   Tue, 12 Jan 2021 20:09:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111194822.4kvl2tx24anyu23k@chatter.i7.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1610478571;eef0f28c;
X-HE-SMSGID: 1kzP2i-0007NT-Rj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for your reply and sorry for forgetting to CC you; that was the
plan, but I forgot when I called git send-email :-/

Am 11.01.21 um 20:48 wrote Konstantin Ryabitsev:
> On Sun, Jan 10, 2021 at 01:10:33PM +0100, Thorsten Leemhuis wrote:
>> The front page doesn't make this aspect obvious and not even point to
>> Documentation/admin-guide/reporting-bugs.rst to help those that want to
>> properly report a bug. Only the FAQ mentions it, albeit only indirectly:
>> 'The subsystem maintainers in kernel tracker are volunteers to help
>> track bugs in an area they are interested in. Sometimes they are the
>> same person as on kernel.org sometimes they are not. There are still
>> some categories with no maintainers so more volunteers are needed.'
> My general comment on this is that bug triage sucks and nobody really wants to
> do it for any extended period of time. :) There were times in the past when
> this or that person did step up and kept an eye on all incoming new bugs,
> properly routing them to the proper product/component, but they quickly burned
> out or found a less thankless occupation. Understandably.

Yeah, I can relate to that, too.

>> It looks like those volunteers were never found; the outdated list of
>> components and products (see 'the bad' above) also shows that the
>> volunteers seem to not really take care of things.
> I want to encourage you and the rest of the developers to complain about this
> to the TAB. It is entirely in their power to come to the Linux Foundation with
> the suggestion that perhaps bug triage should be a paid position. It's not a
> given that such a position would then be created and funded, but this for sure
> won't happen if these complaints don't reach People In Charge Of Funds at the
> LF.

Hmmm, I'll have to think about that. I'm not sure yet if I'm currently
willing to enter enter such a fight^w^w^w^w go down that route – I soon
have other things on my plate and not much time to spare for this. Sure,
bringing this to TAB is not that much work, but I expect that will lead
to a longer process that will involve lots of arguments that will need
to get exchanged by mail... And I don't care that much about bugzilla,
that why I spend time wring the recently added text
Documentation/admin-guide/reporting-issues.rst



>> In the end that's the reasons why quite a few (a lot?) reports never get
>> a reply from someone. During a randomly selected 2 week window at the
>> end of November 2020(¹) there were 60 public bugs and a bit more than
>> half of them by the end of the year never got a single comment by anyone
>> except maybe the reporter.
> Well, that said, a lot of stuff sent to the _proper_ mailing lists also never
> receives a response

Good point.

> -- either because it didn't catch appropriate eyeballs or
> because those eyeballs didn't have time to spend on the required
> back-and-forth to identify the source of the problem.

Or because the bug report was obviously so bad no one dared to touch it.
But that reason and the two you mentioned are all covered in
Documentation/admin-guide/reporting-issues.rst

Sure, not everybody will read that far, but at least those that do will
find help. And yes, the text could cover those situations for
bugzilla.kernel.org as well, but that afaics would boil down to 'report
to the place that is mentioned in the MAINTAINERS file (as you better
would have right from the start)'.

> I don't think we should
> be using this metric as indication that bugzilla doesn't work.

Well, FWIW, that's why I described it as 'doesn't work that well' and
had a 'the good' section in my patch description, as it clearly is
useful sometimes. That's also why I'm not on a quest 'kill bugzilla with
fire'. ;-)

Nevertheless I think discouraging users from filing bugs there is a good
way to quickly improve the situation, as chances a good bug report will
be acted upon afaics are currently much better when they get reported to
the proper place: the one mentioned in the MAINTAINERS file.

>> But there is one aspect that should be noted here: The situation can't
>> be blamed on the kernel.org admins. They are doing a good job at keeping
>> the bugzilla.kernel.org up and the bugzilla codebase up2date. But as
>> admins it's not their job to maintain the list of products and
>> components.
> Aw, thanks. :) It's indeed hard enough just keeping all the spam off it.
> Unfortunately, there are no perfect solutions for it, but usually all spam is
> junked and hidden from public view within an hour or two of being posted.
> Sadly, this usually happens after spammy notifications have already gone out.

Ouch. Maybe that's one good reason to make bugzilla.kernel.org either
work properly or kill it, to make sure the time your spent on things
like this is actually worth it.

>> Apart from this change there is one more change planned to improve the
>> situation with bugzilla.kernel.org: discuss with the admins how to make
>> it more obvious to users when to use the bug tracker, and when to avoid
>> it; the text that does this will obviously link to
>> Documentation/admin-guide/reporting-issues.rst, which is one of the
>> reasons why it's designed to be understandable for newcomers.
> I'm not sure there's any single solution that will solve the problem. If we
> properly organize products/components, many people will just get lost in them
> and create all bug reports in "other" (or "helpdesk", as is the case lately).

Yeah, the kernel is complex and might benefit from a 1st level support
that relays good reports to the appropriate developers or maintains. But
such a solution would need time and money to set up. Until something is
happening in that direction I'd say a patch like mine is a good idea and
can easily get reverted later if the situation with bugzilla.kernel.org
improves.

> The sanest approach would be to have a simple web gateway to bug reporting:

+1

> - which distribution are you using?
> - if they choose a distribution, show them where to report bugs for that
>   distribution, because most bugs should start there, really

Agreed. Fun fact: that why the step-by-step guide in
Documentation/admin-guide/reporting-issues.rst starts with "Stop reading
this document and report the problem to your vendor instead, unless you
are running the latest mainline kernel already or are willing to install
it. " ;-)

> - on that page, also give a link:
>   "I'm a distribution maintainer and I want to report this bug upstream"
> - if they click that link, let them fill out a freeform bug report that will
>   create a new bug entry on bugzilla.kernel.org in "Other/Other"
> - creating a bug there will email the designated person in charge of initial
>   bug triage
> - that designated person or persons will then assign proper product/component,
>   or simply forward the bug report to the proper maintainer if they are able
>   to ascertain that


Well, do we really need bugzilla and a middleperson for triaging and
forwarding when it we are taking about reports filed by distribution
maintainers? They are unlikely to be newcomers to FLOSS bug reporting,
so they IMHO should be able to read the MAINTAINERS file and follow
Documentation/admin-guide/reporting-issues.rst

> This is far from perfect and still hinges on finding a person willing to do

> bug triage. However, it should hopefully improve the workflow without making

> it too complicated.

It might imrpove the workflow, but one question wasn't raised: why do we
need two places to report bugs to at all? The MAINTAINERS file is there
and the places specified there are clearly the ones maintainers prefer.
Sure, bugzilla is easier to handle, especially for for inexperienced
users. But is that worth it? Especially in its current state?

Ciao, Thorsten
