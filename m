Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A482F49E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbhAMLR6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Jan 2021 06:17:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:9024 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbhAMLR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:17:57 -0500
IronPort-SDR: dQvhv4w7OYKQqaC0RnKP/z6JNs3xgmiQWqW1ZNT3OZupe9h3h+z44rwrDD0Fth2NBazA33TnaF
 ik+zAUOzMMIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="262974463"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="262974463"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 03:17:15 -0800
IronPort-SDR: vAkyNvmwQgpXGVKcpFFbP3tKpfXaLMxdTvKrxkdq1LhtFI9HTsPDX1uMtm2CMoJJGcqPz8BBCl
 X81vXBhWj2Pg==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="381806881"
Received: from iklein-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 03:17:13 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using bugzilla.kernel.org
In-Reply-To: <fba45829-cac3-9f53-c753-0b08d813aa83@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210110121033.130504-1-linux@leemhuis.info> <20210111194822.4kvl2tx24anyu23k@chatter.i7.local> <fba45829-cac3-9f53-c753-0b08d813aa83@leemhuis.info>
Date:   Wed, 13 Jan 2021 13:17:10 +0200
Message-ID: <877doht7bd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> Thx for your reply and sorry for forgetting to CC you; that was the
> plan, but I forgot when I called git send-email :-/
>
> Am 11.01.21 um 20:48 wrote Konstantin Ryabitsev:
>> On Sun, Jan 10, 2021 at 01:10:33PM +0100, Thorsten Leemhuis wrote:
>>> The front page doesn't make this aspect obvious and not even point to
>>> Documentation/admin-guide/reporting-bugs.rst to help those that want to
>>> properly report a bug. Only the FAQ mentions it, albeit only indirectly:
>>> 'The subsystem maintainers in kernel tracker are volunteers to help
>>> track bugs in an area they are interested in. Sometimes they are the
>>> same person as on kernel.org sometimes they are not. There are still
>>> some categories with no maintainers so more volunteers are needed.'
>> My general comment on this is that bug triage sucks and nobody really wants to
>> do it for any extended period of time. :) There were times in the past when
>> this or that person did step up and kept an eye on all incoming new bugs,
>> properly routing them to the proper product/component, but they quickly burned
>> out or found a less thankless occupation. Understandably.
>
> Yeah, I can relate to that, too.
>
>>> It looks like those volunteers were never found; the outdated list of
>>> components and products (see 'the bad' above) also shows that the
>>> volunteers seem to not really take care of things.
>> I want to encourage you and the rest of the developers to complain about this
>> to the TAB. It is entirely in their power to come to the Linux Foundation with
>> the suggestion that perhaps bug triage should be a paid position. It's not a
>> given that such a position would then be created and funded, but this for sure
>> won't happen if these complaints don't reach People In Charge Of Funds at the
>> LF.
>
> Hmmm, I'll have to think about that. I'm not sure yet if I'm currently
> willing to enter enter such a fight^w^w^w^w go down that route – I soon
> have other things on my plate and not much time to spare for this. Sure,
> bringing this to TAB is not that much work, but I expect that will lead
> to a longer process that will involve lots of arguments that will need
> to get exchanged by mail... And I don't care that much about bugzilla,
> that why I spend time wring the recently added text
> Documentation/admin-guide/reporting-issues.rst
>
>
>
>>> In the end that's the reasons why quite a few (a lot?) reports never get
>>> a reply from someone. During a randomly selected 2 week window at the
>>> end of November 2020(¹) there were 60 public bugs and a bit more than
>>> half of them by the end of the year never got a single comment by anyone
>>> except maybe the reporter.
>> Well, that said, a lot of stuff sent to the _proper_ mailing lists also never
>> receives a response
>
> Good point.

There's a school of thought that this is actually a feature. If there's
no attention, the reports on the list will just fade away and be
forgotten. Whereas in bugzilla, someone needs to actively resolve even
the ignored and forgotten bugs. (Or it needs to be automated.)

Attending to a bug database of thousands of open bugs takes a huge
amount of effort, and if the bugs aren't being fixed, a lot of that
effort is just wasted. If a bug doesn't get fixed now (or soon-ish),
what are the chances it'll get fixed months or years down the line?

---

Just musing, has anyone else seen a shift in bug reports from "I'm part
of the community, and I want to help improve this stuff" towards "I'm a
customer and I demand support"? I don't think the kernel community can
really cater to the latter very well, and would be better directed at
distro bug trackers.

BR,
Jani.




>
>> -- either because it didn't catch appropriate eyeballs or
>> because those eyeballs didn't have time to spend on the required
>> back-and-forth to identify the source of the problem.
>
> Or because the bug report was obviously so bad no one dared to touch it.
> But that reason and the two you mentioned are all covered in
> Documentation/admin-guide/reporting-issues.rst
>
> Sure, not everybody will read that far, but at least those that do will
> find help. And yes, the text could cover those situations for
> bugzilla.kernel.org as well, but that afaics would boil down to 'report
> to the place that is mentioned in the MAINTAINERS file (as you better
> would have right from the start)'.
>
>> I don't think we should
>> be using this metric as indication that bugzilla doesn't work.
>
> Well, FWIW, that's why I described it as 'doesn't work that well' and
> had a 'the good' section in my patch description, as it clearly is
> useful sometimes. That's also why I'm not on a quest 'kill bugzilla with
> fire'. ;-)
>
> Nevertheless I think discouraging users from filing bugs there is a good
> way to quickly improve the situation, as chances a good bug report will
> be acted upon afaics are currently much better when they get reported to
> the proper place: the one mentioned in the MAINTAINERS file.
>
>>> But there is one aspect that should be noted here: The situation can't
>>> be blamed on the kernel.org admins. They are doing a good job at keeping
>>> the bugzilla.kernel.org up and the bugzilla codebase up2date. But as
>>> admins it's not their job to maintain the list of products and
>>> components.
>> Aw, thanks. :) It's indeed hard enough just keeping all the spam off it.
>> Unfortunately, there are no perfect solutions for it, but usually all spam is
>> junked and hidden from public view within an hour or two of being posted.
>> Sadly, this usually happens after spammy notifications have already gone out.
>
> Ouch. Maybe that's one good reason to make bugzilla.kernel.org either
> work properly or kill it, to make sure the time your spent on things
> like this is actually worth it.
>
>>> Apart from this change there is one more change planned to improve the
>>> situation with bugzilla.kernel.org: discuss with the admins how to make
>>> it more obvious to users when to use the bug tracker, and when to avoid
>>> it; the text that does this will obviously link to
>>> Documentation/admin-guide/reporting-issues.rst, which is one of the
>>> reasons why it's designed to be understandable for newcomers.
>> I'm not sure there's any single solution that will solve the problem. If we
>> properly organize products/components, many people will just get lost in them
>> and create all bug reports in "other" (or "helpdesk", as is the case lately).
>
> Yeah, the kernel is complex and might benefit from a 1st level support
> that relays good reports to the appropriate developers or maintains. But
> such a solution would need time and money to set up. Until something is
> happening in that direction I'd say a patch like mine is a good idea and
> can easily get reverted later if the situation with bugzilla.kernel.org
> improves.
>
>> The sanest approach would be to have a simple web gateway to bug reporting:
>
> +1
>
>> - which distribution are you using?
>> - if they choose a distribution, show them where to report bugs for that
>>   distribution, because most bugs should start there, really
>
> Agreed. Fun fact: that why the step-by-step guide in
> Documentation/admin-guide/reporting-issues.rst starts with "Stop reading
> this document and report the problem to your vendor instead, unless you
> are running the latest mainline kernel already or are willing to install
> it. " ;-)
>
>> - on that page, also give a link:
>>   "I'm a distribution maintainer and I want to report this bug upstream"
>> - if they click that link, let them fill out a freeform bug report that will
>>   create a new bug entry on bugzilla.kernel.org in "Other/Other"
>> - creating a bug there will email the designated person in charge of initial
>>   bug triage
>> - that designated person or persons will then assign proper product/component,
>>   or simply forward the bug report to the proper maintainer if they are able
>>   to ascertain that
>
>
> Well, do we really need bugzilla and a middleperson for triaging and
> forwarding when it we are taking about reports filed by distribution
> maintainers? They are unlikely to be newcomers to FLOSS bug reporting,
> so they IMHO should be able to read the MAINTAINERS file and follow
> Documentation/admin-guide/reporting-issues.rst
>
>> This is far from perfect and still hinges on finding a person willing to do
>
>> bug triage. However, it should hopefully improve the workflow without making
>
>> it too complicated.
>
> It might imrpove the workflow, but one question wasn't raised: why do we
> need two places to report bugs to at all? The MAINTAINERS file is there
> and the places specified there are clearly the ones maintainers prefer.
> Sure, bugzilla is easier to handle, especially for for inexperienced
> users. But is that worth it? Especially in its current state?
>
> Ciao, Thorsten

-- 
Jani Nikula, Intel Open Source Graphics Center
