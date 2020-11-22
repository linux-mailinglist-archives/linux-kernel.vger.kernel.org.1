Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6457F2BC3FA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 06:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKVFm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 00:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgKVFm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 00:42:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B10C0613CF;
        Sat, 21 Nov 2020 21:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JC0o2YFP3/XK0Z+DYUzEpVTffCSvfBkCYVaE/ZBBaNE=; b=VVgHO3APzvYMuhhXiRLhCWzsuM
        vh5lklOC6Ypiici9y0PGBh7jmc8k3NZ8PltaQ0wYV6KfI2gBR1p9qxzjOxF6HnDZOjSBM5cgu0Jwh
        V2DVnQpFEgUQCknT3OQ2vNNtRGvMBce8xl3/NYowgi0vNefgjs0QK4qmTCbPS7f+AbTlhc1TkNU7J
        c4b6/WSaP+CCYjkA8ZZbyFc5qV8Xnv54eVLB1dxc2+qReKIsQZp1h1NbwyHQuLbNZNnVlReJHnkYS
        4ssLHMmstHsXFRP06d/8lnyB4KumhNlDzecNnuZ8pOJl6hEYp1FLLVfHBM8ZWvEkSgnOeIWGTRCqx
        jZrNASXw==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kgi9H-0005cA-FL; Sun, 22 Nov 2020 05:42:55 +0000
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and yet
 more detailed & helpful
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1605203187.git.linux@leemhuis.info>
 <20201113153313.68ff210c@lwn.net>
 <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
 <20201118172958.5b014a44@lwn.net>
 <2dcea97c-7b98-1ad2-d2ba-e7f7d77dc855@leemhuis.info>
 <20201120145813.76b7b326@lwn.net>
 <dda474a6-db81-89bb-1f9f-ccf2558d2840@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b5f5dfad-07bb-b518-0dff-3aa340333046@infradead.org>
Date:   Sat, 21 Nov 2020 21:42:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <dda474a6-db81-89bb-1f9f-ccf2558d2840@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/20 9:33 PM, Thorsten Leemhuis wrote:
> Am 20.11.20 um 22:58 schrieb Jonathan Corbet:
>> On Fri, 20 Nov 2020 11:46:07 +0100
>> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>> Am 19.11.20 um 01:29 schrieb Jonathan Corbet:
>>>> On Sun, 15 Nov 2020 11:13:52 +0100
>>>> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>
>>>>    - Collapse the whole thing down to a patch adding reporting-bugs-v2.rst
>>>>      (or some suitable name).  I do wonder if it should also move to the
>>>>      process manual as part of this; not only admins will report bugs.
>>> After a night's sleep and Randy's comment I for now settled on
>>> Documentation/admin-guide/reporting-issues.rst
>> Keeping it in the admin guide is OK.  Not sure about the name, though; if
>> you're really dead set against bugs, maybe reporting-problems.rst?
> 
> Well, I'm not dead set against bugs, but it somehow seems wrong to me: people have problems/issues they deal with, which in the end might turn out to not be a bug/error in the code at all. That afaics why tracker software for such reports is often called "issue tracker" instead of "bug tracker" (and nearly nobody calls them problem trackers afaics).. That's why I went with "issues" in the name and the text.
> 
> But in the end I'm not a native English speaker, so I guess it's better if I follow advice from those. Randy, what would you choose?

I'm fine with "issues."

I do recall that at my first job (that was in the previous century or
previous millennium) they were called "trouble reports."  :)

-- 
~Randy

