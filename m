Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196EB282262
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgJCIF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 04:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJCIF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 04:05:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0BDC0613D0;
        Sat,  3 Oct 2020 01:05:27 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kOcXl-0001ZJ-0l; Sat, 03 Oct 2020 10:05:25 +0200
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1601541165.git.linux@leemhuis.info>
 <0c647add40e56b403bc17e9de1430917aa88bacb.1601541165.git.linux@leemhuis.info>
 <3f8a3a67-9e04-80a6-e540-c4c511dc4546@infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; prefer-encrypt=mutual; keydata=
 mQINBFJ4AQ0BEADCz16x4kl/YGBegAsYXJMjFRi3QOr2YMmcNuu1fdsi3XnM+xMRaukWby47
 JcsZYLDKRHTQ/Lalw9L1HI3NRwK+9ayjg31wFdekgsuPbu4x5RGDIfyNpd378Upa8SUmvHik
 apCnzsxPTEE4Z2KUxBIwTvg+snEjgZ03EIQEi5cKmnlaUynNqv3xaGstx5jMCEnR2X54rH8j
 QPvo2l5/79Po58f6DhxV2RrOrOjQIQcPZ6kUqwLi6EQOi92NS9Uy6jbZcrMqPIRqJZ/tTKIR
 OLWsEjNrc3PMcve+NmORiEgLFclN8kHbPl1tLo4M5jN9xmsa0OZv3M0katqW8kC1hzR7mhz+
 Rv4MgnbkPDDO086HjQBlS6Zzo49fQB2JErs5nZ0mwkqlETu6emhxneAMcc67+ZtTeUj54K2y
 Iu8kk6ghaUAfgMqkdIzeSfhO8eURMhvwzSpsqhUs7pIj4u0TPN8OFAvxE/3adoUwMaB+/plk
 sNe9RsHHPV+7LGADZ6OzOWWftk34QLTVTcz02bGyxLNIkhY+vIJpZWX9UrfGdHSiyYThHCIy
 /dLz95b9EG+1tbCIyNynr9TjIOmtLOk7ssB3kL3XQGgmdQ+rJ3zckJUQapLKP2YfBi+8P1iP
 rKkYtbWk0u/FmCbxcBA31KqXQZoR4cd1PJ1PDCe7/DxeoYMVuwARAQABtCdUaG9yc3RlbiBM
 ZWVtaHVpcyA8bGludXhAbGVlbWh1aXMuaW5mbz6JAj0EEwEKACcFAlJ4A3UCGwMFCQ0oaIAF
 CwkIBwMFFQoJCAsFFgIDAQACHgECF4AACgkQcrbm70xYPS0OOw/+OM+pakOz+MDn9vAgc5Xj
 dVqxjH1+cg7UWkW6UrkniT3i+THv535lGwwB93iQpG0eaLqIPcfFqWGHCJDY4ys8AdCiGA55
 D8eX/A/94Dboz6hzxfu2M4KvpiV2FQrklIZXGiLfr0+ybBUu+PoiS4OA8UzNc/rtAZivb6qm
 T62uUGtmWoj86hDSual9Syi1dn4ff9PVJcGMFk4URkg83qZpVeU/iOnPO7mfhV5l9yfuvP9h
 zhHQOTDrcOm8vJVgcs3TAd8WKke7ueBxuwlDS4a9X0ohT3MycO1sUSx5VpnHsZynvvyITEOW
 njjuBhIJrbjt+c/9HWz+5cJJ7QZOE1KrOAN+u6N4yFZrMFFKKug/s/z9wy7Cg5ANphJ/35to
 nZDV9MCw96sDONEdwEl2u4ZwN5oNJGdFm93odoGSvzu0LNgGi1AWE38pOKmq8EVDYJNMhsv+
 V0oj9vJJso22F5LBJjg233PIdvkF6KwihTiryVZUi3rX1RSwH8HFzVDCETW7bp3EAyUPuoTD
 f8vb7/5RZpNFzy/WtAt80hqp773+PAgPJuXGliI2uJol3nz9PWRhf6yn3U2VSkbiIG3MjwpJ
 vJL/dbiiKWn932U/JV8OKA4m7GKy44ZnTL0nYf/30/5gEVMM8FiPiY1Cybw907WYUxW+dboi
 eu8fdvHIi0xIBWu5Ag0EUngBDQEQAM7v97GrVs5cuvi6ouXUxUvfoSrxTLXUW/71uKPQkLDK
 i9gSRqBOLl78t3Gp3L3MqHc01wlMW3rDT++/Sanh8rO1pBdprS1V9pZ8l0lAZvzjcGrLiuyi
 8/KrrLHlLLL4yTw3cPJkSwFr43LGLGdKoCFOpAW72HJFFpGyY/9JLkApprpUTHGkEa0WK5O2
 XVDo2mJoykflCR5Y8S4Hq3oMol7pUScQqYT+ZooKMoqGtXrHrfIhfX4W/mFmNel9SN057nFQ
 ol4sc8cJ97sIlRoNvJ/r3X2eZWnJAjo+oiuPpX85Xc+DXyFyvvP0dcA/cjo9a69zrIw6jmro
 KDMYBBTosIUA4iZUSlWg235gtRuTdWH0CJ/dM5xGHDO/kqfEXOUVIDecn7sMonInyCUArYlo
 IxfLbXCBLioNE5hm+h0BwLRmgVyslxkLpQ9QpgRyFs4O2xoHuUeuoXW6tQYjF+UHZP6N0q9j
 iwq8VoajHa3iRS826BHNEtdwQsVYJZz6nb+bHe73m9Gs+Sxkus8lU3U27j1LuAtWW7LT27gg
 cEsHtxEab6ZnSMx7SCuBvYhiEd0nqNKFjs0L5BZ/JtpOh9vw3pc/SHBxHn0nubtBoyANfG2R
 Le0dpPAjGfOL6cljnIYMFytgzVwDs6uM8FfFuE4mIhYiFV30o9fObwqbhO49LoKdABEBAAGJ
 AiUEGAEKAA8FAlJ4AQ0CGwwFCQ0oaIAACgkQcrbm70xYPS2OxxAAr8OqW+bEjQV2PLLAHIh6
 fmhajXtSn9bzULofgyD4PsgMsG25di74GbegGyTIwt7cS7Z5ZR5KL7ZkN1GTDFGlWyiZ+6NC
 VsWR62+eujnYvtHsQPaTo8A/uFV+Too4v4ikS4ZD0ondWa1FimLouem9QwOSnyn4yErxUQcU
 yUXHLhUtYs7MO5R4G++Ev+9eK7rRqPeUOqTjQV6Eigi5Ny4536fKMJDNp+YhlRopWBA0fVjf
 tF0MJTV0ShFK1YWLOADJYo9NG+KOeyUqesOvRSxtpQcdcrwPFjkJ3JcknxZstvWid4goqMY7
 l/vGoG7zQDSxUDpXcG9X70yHrmVK/w0dn/PHalfUnOsQpvQYTjGhZ4UnXAVaBsouYLGFo9AL
 lLNERHY4eRR4MEYvk6ABZ1AEaJwiwyZuPRt/iN1EIMM7fnQQcdBYHGJzaV8a3jwHeLAPY1e/
 hS1OsrR9pqGvqQsagYkiZFOCjZxx0IQhokMSIxbFvNfLHTqXXpJzlCv9QGj3s2ZG6o36u42k
 yc+mP1ya8uxIFEwcp6C1h4TTisVFC2DXxDi7pqUd9oTuI4Hg19/i07cdYUHDiraDXSXW5zH9
 5ZDV+rSqDU3ercoRd2qjGUOIXWOytHTeJhVOWqM0vOmXDUwwYHuEb0HFn3d/tz+idSrXUSXZ
 5iv6NKaV29GWHbY=
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 03/26] docs: reporting-bugs: step-by-step guide on
 how to report issues
Message-ID: <6ae431a8-f181-6de9-b5cb-bbab80c0566a@leemhuis.info>
Date:   Sat, 3 Oct 2020 10:05:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3f8a3a67-9e04-80a6-e540-c4c511dc4546@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601712327;934a7a25;
X-HE-SMSGID: 1kOcXl-0001ZJ-0l
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many thx for you comments. Consider all the obvious spelling and
grammatical mistakes you pointed out fixed, I won't mention all of them
in this reply to keep things easier to follow.

Am 02.10.20 um 05:02 schrieb Randy Dunlap:
> On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> […]
>> +brief for you, look up the details in the reference section below, where each
>> +of the steps is explained in more detail.
>> +
>> +Note, this section covers a few more aspects than the TL;DR and does things in a
>    Note:

Ohh, really? LanguageTool suggested to use the comma once when I forgot
a colon, so I assumed it was okay. Uhhps.


>> + * Reproduce the issue with the kernel you just installed. If it doesn't show up
>> +   there, head over to the instructions for issues only happening with stable
>> +   and longterm kernels if you want to see it fixed there.
> Can you link (reference) to that section?

I raised that problem in the cover letter, as this is not the only place
where it would make sense. Hoping for input from Jonathan here how to do
that without adding lots of anchors...

>> + * Optimize your notes: try to find and write the most straightforward way to
>> +   reproduce your issue. Make sure the end result has all the important details,
>> +   and at the same time is easy to read and understand for others that hear
>> +   about it for the first time. And if you learned something in this process,
>> +   consider searching again for existing reports about the issue.
>> +
>> + * If the failure includes a stack dump, like an Oops does, consider decoding it
>> +   to find the offending line of code.
> Refer to scripts/decodecode ?
> or is that done elsewhere?

Elsewhere and this step and that document likely needs to be heavily
updated anyway, as pointed out in a later patch :-/

>> +
>> + * If your problem is a regression, try to narrow down when the issue was
>> +   introduced as much as possible.
>> +
>> + * Start to compile the report by writing a detailed description about the
>> +   issue. Always mentions a few things: the latest kernel version you installed
>> +   for reproducing, the Linux Distribution used, and your notes how to
> 
> I would say:                                                 notes on how to
> Maybe it's just me.

Googled a bit and to me as a non-native English speaker looks like
you're correct.

>> +   reproduce the issue. Ideally, make the kernels build configuration (.config)
>                                              kernel's

Uggh, sorry, this mistake will show up a few more times, looks like I
applied German grammar rules to English. :-/

>> +   the issue and the impact quickly. On top of this add one sentence that
>> +   briefly describes the problem and gets people to read on. Now give the thing
>> +   a descriptive title or subject that yet again is shorter. Then you're ready
>> +   to send or file the report like the `MAINTAINERS file
>> +   <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_
>> +   told you, unless you are dealing with one of those 'issues of high priority':
>       tells you,
> OK, I like present tense as much as possible.

Hmmm. Normally I'd agree, but I used past tense here because it refers
to something the reader did in an earlier step.

>> + * Wait for reactions and keep the thing rolling until you can accept the
>> +   outcome in one way or the other. Thus react publicly and in a timely manner
>> +   to any inquiries. Test proposed fixes. Do proactive testing when a new rc1
>                                                                   when a new -rc
> (release candidate) is released. Send

I only meant "rc1" here, not every rc. More about this in a later patch.

Regarding explaining "rc" as "release candidate": my stupid brain has a
really hard time following that suggestion, as it still remembers some
words someone named Linus Torvalds wrote many many years ago:
```
I'll just use "-rc", and we can all agree that it stands for "Ridiculous
Count" rather than "Release Candidate".
```
https://lore.kernel.org/lkml/Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org/


I'll go and try to find some pills to force my brain into compliance.
;-) Once they start to work it hopefully can agree to this:

Do proactive testing: retest with at least every first release candidate
(RC) of a new mainline version and report your results.

Ciao, Thorsten
