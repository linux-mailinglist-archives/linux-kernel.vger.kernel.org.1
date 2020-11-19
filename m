Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7B02B9295
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgKSM36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgKSM35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:29:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43288C0613CF;
        Thu, 19 Nov 2020 04:29:57 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kfj4S-0001JF-0u; Thu, 19 Nov 2020 13:29:52 +0100
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1605203187.git.linux@leemhuis.info>
 <20201113153313.68ff210c@lwn.net>
 <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
 <20201118172958.5b014a44@lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and yet
 more detailed & helpful
Message-ID: <ada5d01f-47a9-5734-2fc8-3de2d7aa86e4@leemhuis.info>
Date:   Thu, 19 Nov 2020 13:29:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201118172958.5b014a44@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605788997;cd067995;
X-HE-SMSGID: 1kfj4S-0001JF-0u
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.11.20 um 01:29 schrieb Jonathan Corbet:
> On Sun, 15 Nov 2020 11:13:52 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
> 
>>> So I've not had a chance to try to read through the whole thing again,
>>> will try to do so in the near future.
>> Great, thx, looking forward to it.
> OK, I have made a *quick* pass through the whole thing and sent a small
> number of comments separately.

Great, thx, much appreciated.

> There are things that could be tweaked
> (there always will be) but I'm not sure we should worry about those yet.
> I would suggest doing this:
> 
>   - Collapse the whole thing down to a patch adding reporting-bugs-v2.rst
>     (or some suitable name).

Maybe just "reporting-issues.rst" or "reporting-issues-wip.rst". The 
text talks about issues anyway and rarely uses the word "bug".

>  I do wonder if it should also move to the
>     process manual as part of this; not only admins will report bugs.


I had wondered about this myself a few weeks ago, but I assumed someone 
had good reasons to put it in the admin section.

/me looks closer

Hmmm, now I'm unsure myself where to place it:

  * Documentation/admin/ is introduced as "The Linux kernel user’s and 
administrator’s guide" 
(https://www.kernel.org/doc/html/latest/admin-guide/). So maybe it's the 
right place that just uses a directory name that's easily misunderstood :-/

  * the process section starts with the words "So you want to be a Linux 
kernel developer? Welcome!" 
(https://www.kernel.org/doc/html/latest/process/). That might be a bit 
intimidating for people that just want to report a bug.

I guess it's best if you decide.

>   - Add a comment at the top saying it's a proposed replacement and
>     soliciting comments.  You could also put some of your other questions
>     into the text for now and see if anybody reacts.
> 
>   - In a separate patch you could add a comment to the existing document
>     pointing to the new one as the true source of wisdom.

Will do.

>   - Dual licensed CC-SA-4.0 is fine with me.  CC-BY is OK if you really
>     want to do it that way.  

I'm unsure and would appreciate options from others here.

Here are some of my thoughts about this:

What do we loose by dual-licensing it under a liberal license like 
CC-BY? It afaics makes it a lot more attractive for websites or books 
authors to use this text as a base, as they don't need to fear that 
"share alike" or the GPL might have consequences on the surroundings. 
I'd say that's a good thing for the kernel, as it increases the chances 
the texts built upon ours remain close to what we expect on this topic.

That's why I currently think using CC-BY is a good idea.

> Either way, though, you'll need to add the
>     license itself under LICENSES/preferred before it can go into the SPDX
>     tag.

Agh, yes, of course, will keep it in mind when above point is settled.

Ciao, Thorsten
