Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DFF2BC3E7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 06:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgKVFdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 00:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgKVFdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 00:33:42 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F7C0613CF;
        Sat, 21 Nov 2020 21:33:42 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kgi0F-0007D6-D7; Sun, 22 Nov 2020 06:33:35 +0100
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1605203187.git.linux@leemhuis.info>
 <20201113153313.68ff210c@lwn.net>
 <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
 <20201118172958.5b014a44@lwn.net>
 <2dcea97c-7b98-1ad2-d2ba-e7f7d77dc855@leemhuis.info>
 <20201120145813.76b7b326@lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and yet
 more detailed & helpful
Message-ID: <dda474a6-db81-89bb-1f9f-ccf2558d2840@leemhuis.info>
Date:   Sun, 22 Nov 2020 06:33:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201120145813.76b7b326@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1606023222;6da3c698;
X-HE-SMSGID: 1kgi0F-0007D6-D7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.11.20 um 22:58 schrieb Jonathan Corbet:
> On Fri, 20 Nov 2020 11:46:07 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>> Am 19.11.20 um 01:29 schrieb Jonathan Corbet:
>>> On Sun, 15 Nov 2020 11:13:52 +0100
>>> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>
>>>    - Collapse the whole thing down to a patch adding reporting-bugs-v2.rst
>>>      (or some suitable name).  I do wonder if it should also move to the
>>>      process manual as part of this; not only admins will report bugs.
>> After a night's sleep and Randy's comment I for now settled on
>> Documentation/admin-guide/reporting-issues.rst
> Keeping it in the admin guide is OK.  Not sure about the name, though; if
> you're really dead set against bugs, maybe reporting-problems.rst?

Well, I'm not dead set against bugs, but it somehow seems wrong to me: 
people have problems/issues they deal with, which in the end might turn 
out to not be a bug/error in the code at all. That afaics why tracker 
software for such reports is often called "issue tracker" instead of 
"bug tracker" (and nearly nobody calls them problem trackers afaics).. 
That's why I went with "issues" in the name and the text.

But in the end I'm not a native English speaker, so I guess it's better 
if I follow advice from those. Randy, what would you choose?

> I'd be a bit more straightforward:
> 
> 	This document is obsolete, and will be replaced by
> 	Documentation/admin-guide/$NAME in the near future.
> 
> Not sure that more is really needed?

Totally fine for me (I guess I tried to be less bold and was overly 
careful).

@Jonathan, one more question: when I submit this again, should I CC more 
people (Linus, Greg, ?) to give them a chance to speak up before this 
lands in your tree?

Ciao, Thorsten
