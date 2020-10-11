Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046E328A77D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbgJKN3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387876AbgJKN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 09:29:33 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC84FC0613CE;
        Sun, 11 Oct 2020 06:29:32 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kRbPd-0004Mt-DI; Sun, 11 Oct 2020 15:29:21 +0200
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <60aeaadf670271ee69a47f5eff3f6bf7b530ac5a.1601541165.git.linux@leemhuis.info>
 <57bebfe1-7f57-744c-a803-093f219cb451@infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 22/26] docs: reporting-bugs: explain what users
 should do once the report got out
Message-ID: <1e902d27-9e2a-8dab-7849-f45e22bc05ee@leemhuis.info>
Date:   Sun, 11 Oct 2020 15:29:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <57bebfe1-7f57-744c-a803-093f219cb451@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1602422972;a374b6b3;
X-HE-SMSGID: 1kRbPd-0004Mt-DI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many thx for you comments. Consider all the obvious spelling and 
grammatical mistakes you pointed out fixed, I won't mention all of them 
in this reply to keep things easier to follow.

Am 09.10.20 um 19:37 schrieb Randy Dunlap:
> On 10/1/20 1:50 AM, Thorsten Leemhuis wrote:

>> +wait a week at maximum (or just two days if it's something urgent) before
>> +sending a friendly reminder. If the maintainer is not responding in a timely
>> +manner or not handing it appropriately, mention that you are considering to
>> +escalate the issue to a higher authority and do so if there is in the end
> 
>                                              and do so if there seems to be
> no way around this.
> 
> although such a "threat" probably won't do much good.

Hmmm, yeah, I guess did not find the right tone here. But I think this 
situation needs to be mentioned in the text. And FWIW, something about 
it is even in the old text:

"""
If you suspect a maintainer is not responding to these types of bugs in 
a timely manner (especially during a merge window), escalate the bug to 
LKML and Linus Torvalds.
""""

So how about this:
```
The 'issues of high priority' (see above for an explanation) are an 
exception here: maintainers should address them as soon as possible; 
that's why you should wait a week at maximum (or just two days if it's 
something urgent) before sending a friendly reminder.

Sometimes the maintainer might not be responding in a timely manner; 
other times there might be disagreements, for example if an issue 
qualifies as regression or not. In such cases raise your concerns on the 
mailing list and ask others for public or private replies how to move 
on. If that fails, it might be appropriate to escalate the issue to a 
higher authority. In case of a WiFi driver that would be the wireless 
maintainers; if there are no higher level maintainers or all else fails, 
it might be one of those rare situations where it's okay to get Linus 
Torvalds involved.
```


Still not totally happy with it, but I better at least. Or what do other 
think about it?

Ciao, Thorsten
