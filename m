Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B32B97B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgKSQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgKSQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:20:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7EC0613CF;
        Thu, 19 Nov 2020 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=BaLzUQ3GKRTm+Bsx275rLFBfY2cJqM7f3zzkxOvpr50=; b=UtO+zfQTHQ5c21g7eN9pefLDaU
        0UFlVxqM5t1oU9JlvnD0Cy0iKbsJPYC3spWy7ezdIKvgJgxQAQYdvLgeWa/ul1jSKmiaHHmMLx7gs
        lyqMRGynqnGGvz0EDr7dhcRU/khFp4awDT6L0/7XCsA2Fvd2L4GqYhPZHHB131psDfN1aN5JTqA83
        Jd8XtwT1vkegCroEPdGESfgGhZCGi+dgkGiQX7zh67xbqOMzF0I8v9qLut92JcHzNNTqYlNtaYmmr
        tyfZJr+TOztdwBUasO1Kt3mTLyU5fOVgg7srbpQ/+meEE46aZ5M/9wTIPvwdFCStAsndtsm4hn9ZS
        byhaK4qA==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfmfo-0003cE-PV; Thu, 19 Nov 2020 16:20:41 +0000
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and yet
 more detailed & helpful
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1605203187.git.linux@leemhuis.info>
 <20201113153313.68ff210c@lwn.net>
 <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
 <20201118172958.5b014a44@lwn.net>
 <ada5d01f-47a9-5734-2fc8-3de2d7aa86e4@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <be9d810e-a95b-9d44-09f1-19fd6bd07c4b@infradead.org>
Date:   Thu, 19 Nov 2020 08:20:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ada5d01f-47a9-5734-2fc8-3de2d7aa86e4@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 4:29 AM, Thorsten Leemhuis wrote:
> Am 19.11.20 um 01:29 schrieb Jonathan Corbet:
>> On Sun, 15 Nov 2020 11:13:52 +0100
>> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>
>>>> So I've not had a chance to try to read through the whole thing again,
>>>> will try to do so in the near future.
>>> Great, thx, looking forward to it.
>> OK, I have made a *quick* pass through the whole thing and sent a small
>> number of comments separately.
> 
> Great, thx, much appreciated.
> 
>> There are things that could be tweaked
>> (there always will be) but I'm not sure we should worry about those yet.
>> I would suggest doing this:
>>
>>   - Collapse the whole thing down to a patch adding reporting-bugs-v2.rst
>>     (or some suitable name).
> 
> Maybe just "reporting-issues.rst" or "reporting-issues-wip.rst". The text talks about issues anyway and rarely uses the word "bug".
> 
>>  I do wonder if it should also move to the
>>     process manual as part of this; not only admins will report bugs.
> 
> 
> I had wondered about this myself a few weeks ago, but I assumed someone had good reasons to put it in the admin section.
> 
> /me looks closer
> 
> Hmmm, now I'm unsure myself where to place it:
> 
>  * Documentation/admin/ is introduced as "The Linux kernel user’s and administrator’s guide" (https://www.kernel.org/doc/html/latest/admin-guide/). So maybe it's the right place that just uses a directory name that's easily misunderstood :-/
> 
>  * the process section starts with the words "So you want to be a Linux kernel developer? Welcome!" (https://www.kernel.org/doc/html/latest/process/). That might be a bit intimidating for people that just want to report a bug.
> 
> I guess it's best if you decide.
I prefer to leave it in /admin-guide/.

-- 
~Randy

