Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC52B3358
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 11:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgKOKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 05:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgKOKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:14:01 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C3CC0613D1;
        Sun, 15 Nov 2020 02:13:58 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1keF2f-0000l5-Ez; Sun, 15 Nov 2020 11:13:53 +0100
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1605203187.git.linux@leemhuis.info>
 <20201113153313.68ff210c@lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and yet
 more detailed & helpful
Message-ID: <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
Date:   Sun, 15 Nov 2020 11:13:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201113153313.68ff210c@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605435238;96a056a8;
X-HE-SMSGID: 1keF2f-0000l5-Ez
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.11.20 um 23:33 schrieb Jonathan Corbet:
> On Thu, 12 Nov 2020 18:58:37 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
> 
>> This series rewrites the "how to report bugs to the Linux kernel
>> maintainers" document to make it more straight forward and its essence
>> easier to grasp. At the same time make the text provide a lot more details
>> about the process in form of a reference section, so users that want or
>> need to know them have them at hand.
>>
>> The goal of this rewrite: improve the quality of the bug reports and
>> reduce the number of reports that get ignored. This was motivated by many
>> reports of poor quality the submitter noticed while looking after Linux
>> kernel regression tracking many moons ago.
> 
> So I've not had a chance to try to read through the whole thing again,
> will try to do so in the near future.

Great, thx, looking forward to it.

> As for how to proceed...getting others to review this is going to be a bit
> of a challenge.

Yeah :-/

>  Perhaps the right approach is to just merge the new
> document under a new name - reporting-bugs-the-novel.txt

drivers/staging/Documentation/ (no, just kidding [I think…])

>  or something -
> then try to get a few people to look at specific parts of it?  Once all
> seems well we can rename it over the old document and call it done.
> 
> Make sense?

Totally fine for me. Putting it some place that makes it easier to 
collaborate and to see who writes what is better for everyone – and get 
control out of my hands and burden off my shoulders. ;-)


There is just one thing on I'm wondering: should we start with the 
version of the text start users very long lines/is unwrapped and use it 
for the reviewing and polishing phase? Together with tools like meld of 
kdiff3 that afaics makes it lot easier to see what actually changes. 
That'd why I uploaded the text in such a format:

https://gitlab.com/knurd42/linux/-/raw/reporting-bugs/Documentation/admin-guide/reporting-bugs-v1.rst
https://gitlab.com/knurd42/linux/-/raw/reporting-bugs/Documentation/admin-guide/reporting-bugs-v2.rst

These for example would have allowed an easier rereview from Randy (but 
I think he's right not doing one right now [see the other reply]!), as 
these tools are quite well at highlighting what changed and what did 
not. Yer, these tools are not as bad as a classic diff once you change 
something in a wrapped paragraph, but in my experience work quite a bit 
better with long lines. That's why I wonder if we should stick to them 
before we call the main work done. Another reasons: with long lines 
everyone can temporarily put the text in LibreOffice, Google Docs, ... 
and use their spelling and grammar checkers.


Another aspect on my mind: the split up makes it easy to just CC certain 
people on parts we want them to review. I for example planned to CC the 
members of the stable-team only on four patches (TLDR, the two patches 
with the step by step parts, the reference section for stable and 
logterm), as those are the main ones that are relevant for them:

https://lore.kernel.org/lkml/b80b1387cf09fb897f4a527bc487fff3012d1181.1605203187.git.linux@leemhuis.info/
https://lore.kernel.org/lkml/b439c3d74c541d4d7631203a52f9d697ea8c283d.1605203187.git.linux@leemhuis.info/
https://lore.kernel.org/lkml/2d840fb91b7c5d481284275dea1d4f75fd755af6.1605203187.git.linux@leemhuis.info/
https://lore.kernel.org/lkml/0bb6bf554ac1f0c2a75631e6969a50dcd34c6b51.1605203187.git.linux@leemhuis.info/

Without a split split we'd have to tell people something like "please 
took at the document <here> and the sections starting with <foo>, <bar>, 
and <baz>". Or would we at some point just simply sent those parts as 
regular text (not as diff) my mail to the people & lists that need to 
review them?


And a few more thoughts, just for completeness.

* I guess we should discuss the dual-license approach I chose soon 
before it gets complicate to change it

* Some of the reviewer might want to compare the approaches the old and 
the new text take. The current patch-series tries to makes that easy by 
removing parts from the old text when adding new text about that topic. 
That would be mostly lost afaics, but I guess it's not that much of a 
problem.

* I wonder if putting the text in some real collaborative text editor 
(google docs, a wiki, Etherpad, …) for a while would be even better. But 
even with restricted write access that might pose some problems for 
signing the changes off later. :-/ Guess finding the solution for those 
might not be worth the trouble.

Ciao, Thorsten
