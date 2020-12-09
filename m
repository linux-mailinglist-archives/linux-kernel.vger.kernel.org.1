Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA32D4863
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgLIRyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgLIRyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:54:24 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6B8C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 09:53:44 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b5so1389660pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 09:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oypYqtmmfAQKXIAIKlvi8aIHa9KrgXEjuj0uSMK8eTE=;
        b=H94fLO0T1v2pzVlcrnrlM601IW+UuXFgs498ZoAXRkrABysfJPtspffw2FH8cNuLJF
         uXPN/XXmzSzPjwJQ8cA11m4XoOZU3D5QltQI9Vb5Cl3/iKsBqM2OR5Ue9EHKIu52KM/a
         PaYFGzU72W5Noc3q3BrjPgLWlOKVn6I7RpMvYa/3158ch1cCkJOIe4xXiN2V6kiA0G4n
         Xi2a12gYHEb8uS8CeupA4CM9LvWwFGji01iwbDExcmVnNIUBuO9rMCD3OG+Kz3wDasjq
         dBpv8L//u+pgwWXvHm9SRnbv7FhbHw5wtLP01YZo/Pnh6mJjHHpO9PZUizWGVlrbB8sJ
         iobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oypYqtmmfAQKXIAIKlvi8aIHa9KrgXEjuj0uSMK8eTE=;
        b=ZXjE/pccP6yshTeVENUHrYG9xtKNFgasH2Imi/CXhJ/BLFAPoPhHNK4Kvs7wpwI/YT
         IENtLF2MJmVAAkwmwUuPAZRUpzr/SLsqSRjiz4qFRnJQI9FuuJEzHo3LpqTPW9kuelTm
         2PWEWljAV03ngfU7bwtPlw0EKojHdOoXM5G8z+8kgqGIpUnbyHRr6drYPKKzcrAh6uNx
         aEc3jWYx+lMceU3AMTXOLx996fY0AO99QpbU3MGd2wupM2s4CGt23lWwQIWWL9EplGoJ
         4B+QZzxCddx32t9vQS1hTi/8l1ZtevRtFLzX/0UFay7FGN3abLflbW76lkF9zbnqfy8E
         RIow==
X-Gm-Message-State: AOAM533HZp8DF3AqdJm0tx7r0XuoZttHf75imFQf+pcS196jcOtjdNkP
        33J5pV0mwXAF7dMgJBggS6g=
X-Google-Smtp-Source: ABdhPJxqAu89ennYqZJEiGqGuXnokTRJXKpGJXDrzXx7StJCecYhLzH/ttyycHTddKNG+dzkmgzz2A==
X-Received: by 2002:a17:90b:253:: with SMTP id fz19mr3186902pjb.195.1607536423542;
        Wed, 09 Dec 2020 09:53:43 -0800 (PST)
Received: from [192.168.0.104] ([49.207.201.111])
        by smtp.gmail.com with ESMTPSA id f7sm3190743pfe.30.2020.12.09.09.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 09:53:42 -0800 (PST)
Subject: Re: [PATCH] fs: quota: fix array-index-out-of-bounds bug by passing
 correct argument to vfs_cleanup_quota_inode()
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com,
        dvyukov@google.com
References: <20201208194338.7064-1-anant.thazhemadam@gmail.com>
 <20201209090700.GA18595@quack2.suse.cz>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <57b4438c-4d84-d17f-17bc-cbd00995f5ac@gmail.com>
Date:   Wed, 9 Dec 2020 23:23:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209090700.GA18595@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/20 2:37 pm, Jan Kara wrote:
> On Wed 09-12-20 01:13:38, Anant Thazhemadam wrote:
>> When dquot_resume() was last updated, the argument that got passed
>> to vfs_cleanup_quota_inode was incorrectly set.
>>
>> If type = -1 and dquot_load_quota_sb() returns a negative value,
>> then vfs_cleanup_quota_inode() gets called with -1 passed as an
>> argument, and this leads to an array-index-out-of-bounds bug.
>>
>> Fix this issue by correctly passing the arguments.
>>
>> Fixes: ae45f07d47cc ("quota: Simplify dquot_resume()")
>> Reported-by: syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com
>> Tested-by: syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com
>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> Thanks for the fix! I've just queued the very same fix I wrote yesterday to
> my tree. But yours has better changelog so let me pick your patch instead
> ;)

Glad to hear that. Thank you! :D

> For next time, how can we avoid collisions like this? Did you work on the fix
> based on the syzbot email sent to the list so if I actually reply to the
> syzbot email that I'm working on / already have a fix you'd see it?

I came across the bug on the syzbot dashboard, and not through the mailing list.
But even if I did come across this on the mailing list, there is the still a fair chance
that I could've come across this bug, and started working on it before replied to
the syzbot email, right?
I can't speak for everyone, but even if I see a bug on the mailing list, I go over to
the dashboard, and get the apt .config and reproducer from there, and try to work
on it; almost never checking that initial syzbot mail again.

However, iirc there have been previous discussions regarding this on
the mailing lists (although I'm not sure where I came across them :/ ).
For this reason I've Cc-ed Dmitry onto this reply, and hopefully he'll be able to direct
you to those conversations, and also validate any new ideas you might have.
I'd be more than happy to contribute too if I can add any value to the discussion
around that, and to whatever ideas you may have, since this is a issue that has
been around for quite a while now. :)

Hope this helps,
Anant
