Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF028A7E7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 17:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbgJKPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 11:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388074AbgJKPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 11:06:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11EAC0613CE;
        Sun, 11 Oct 2020 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mn7mw5xxc4zpmIpLQTMI/KCEK9pYqdMfFl2NSSEiSxU=; b=G03mAjDxQyciJcVwsInoXd6DVM
        F5MouasjuzAqO4yJofHV1JuBgeOgchL7BoJhqUosnrsnbKwmWWxzudOT76ciSbsp8agkHmw1p59jd
        X72+5ruicyiZNuSn9HZEfNHuPHgH4U7F/X27fL8tU5lFemJJXD99mmJJyMBofgh93AyA398aLEJSn
        jKsgfhiWxWfLBOmn5+TQGl5Vw/meU1L4bDNxUJul4dlbPaxqmpp47pWJIu6uDRjlYDbjaZJJqtnYu
        wKEnle+GoYjBiwWiLtxYAHWAzpPcUCWZCnMpCTV8GmoJ0UNaUKL7a/zZARqblHRNOIsSLwxefiMrC
        uSzPlsPw==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRcvn-000221-TJ; Sun, 11 Oct 2020 15:06:40 +0000
Subject: Re: [RFC PATCH v1 22/26] docs: reporting-bugs: explain what users
 should do once the report got out
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <60aeaadf670271ee69a47f5eff3f6bf7b530ac5a.1601541165.git.linux@leemhuis.info>
 <57bebfe1-7f57-744c-a803-093f219cb451@infradead.org>
 <1e902d27-9e2a-8dab-7849-f45e22bc05ee@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5ec324fd-e9e4-f913-1929-154035e8b3e8@infradead.org>
Date:   Sun, 11 Oct 2020 08:06:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1e902d27-9e2a-8dab-7849-f45e22bc05ee@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/20 6:29 AM, Thorsten Leemhuis wrote:
> Many thx for you comments. Consider all the obvious spelling and grammatical mistakes you pointed out fixed, I won't mention all of them in this reply to keep things easier to follow.
> 
> Am 09.10.20 um 19:37 schrieb Randy Dunlap:
>> On 10/1/20 1:50 AM, Thorsten Leemhuis wrote:
> 
>>> +wait a week at maximum (or just two days if it's something urgent) before
>>> +sending a friendly reminder. If the maintainer is not responding in a timely
>>> +manner or not handing it appropriately, mention that you are considering to
>>> +escalate the issue to a higher authority and do so if there is in the end
>>
>>                                              and do so if there seems to be
>> no way around this.
>>
>> although such a "threat" probably won't do much good.
> 
> Hmmm, yeah, I guess did not find the right tone here. But I think this situation needs to be mentioned in the text. And FWIW, something about it is even in the old text:
> 
> """
> If you suspect a maintainer is not responding to these types of bugs in a timely manner (especially during a merge window), escalate the bug to LKML and Linus Torvalds.
> """"
> 
> So how about this:
> ```
> The 'issues of high priority' (see above for an explanation) are an exception here: maintainers should address them as soon as possible; that's why you should wait a week at maximum (or just two days if it's something urgent) before sending a friendly reminder.
> 
> Sometimes the maintainer might not be responding in a timely manner; other times there might be disagreements, for example if an issue qualifies as regression or not. In such cases raise your concerns on the mailing list and ask others for public or private replies how to move on. If that fails, it might be appropriate to escalate the issue to a higher authority. In case of a WiFi driver that would be the wireless maintainers; if there are no higher level maintainers or all else fails, it might be one of those rare situations where it's okay to get Linus Torvalds involved.
> ```
> 
> 
> Still not totally happy with it, but I better at least. Or what do other think about it?

Thanks, it's better.

-- 
~Randy

