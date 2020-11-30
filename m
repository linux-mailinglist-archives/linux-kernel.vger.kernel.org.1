Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED82C849A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgK3NBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3NBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:01:23 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D738FC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:00:42 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id d9so10595328qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mjb8T3Nwhf083vr76li1jBuoqOkuNi+n5rzJXtAH2u8=;
        b=TSVuiV5PGVXsR0xymEShwmhUtlc3TSS4ACZxa/ckC4LkSdbrqXhgphHGyk0/OR8pfP
         MVwc1i7gjWQdXhmfjSkYBoykepOLv2S+4vD+hwW4yzC5KU05lB6tmCzVGxolIXk7kAVK
         PKKCzluVyWZVAVuYLtWEM3X+z20ExNPIAmPI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mjb8T3Nwhf083vr76li1jBuoqOkuNi+n5rzJXtAH2u8=;
        b=Ud1o9T0M2iD/Sh+hN8EyF/WYfCly0ns/5PCvjcz+IsUuqB8EspoNVjYIVPF/Wf6pza
         RQJjaGOKxOaG9FOLuq4xyBs7P9DDu9hD3rI3IwP9kjjCOxiQG9xu05aAT3pDcntziX2J
         dsjII5LuANNKL/IFO7vexUfWOJxbx501RCD/JQHi0g1duevU67F3sclvBrXpFzGmHNlh
         ZKrR7KIXX7OJ7LSjnfPzP+VXcxNtxGop0pcbayMvgI+r2oKxHbCZlya3Cn4rhuT3rgDz
         lYDVbxaCncNRF4gsQQSV4NBVSvbL1gy0d7lMrCXuoutrOZkXS1vGaiUYm8/mBnt5t39P
         Qpqg==
X-Gm-Message-State: AOAM531fOEUqf4Vn+4MYI4DdkaHe/WaQwNHVgFAJIsNQAv8U8KDF/2lr
        ltBdgvKpSe/Gk+bBxhHYD3lHYw==
X-Google-Smtp-Source: ABdhPJzByej10PhVsWeUrwwOV9AQIBW7O71fGtMQ6L2Fv02wnlhLkqWEQhbcLomDs/dqIGKwwzkNTQ==
X-Received: by 2002:a37:8ac6:: with SMTP id m189mr1466788qkd.267.1606741241505;
        Mon, 30 Nov 2020 05:00:41 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id 5sm16472459qtp.55.2020.11.30.05.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:00:40 -0800 (PST)
Date:   Mon, 30 Nov 2020 08:00:38 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] USB/PHY driver fixes for 5.10-rc6
Message-ID: <20201130130038.nhxsdfoqn2aeekzi@chatter.i7.local>
References: <X8JBIBWUEgxr1lSY@kroah.com>
 <CAHk-=wiEDfZyekjsHMvxwQGKt7BhjXuX77vaihn6SB59qyW1cg@mail.gmail.com>
 <39c8838b-b321-b91e-d29d-92cf43a09c16@infradead.org>
 <CAHk-=wghm==vakvd81ezNpz58wnKTA07f81Q8sEv7KWOza3TdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wghm==vakvd81ezNpz58wnKTA07f81Q8sEv7KWOza3TdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 03:50:28PM -0800, Linus Torvalds wrote:
> On Sat, Nov 28, 2020 at 2:07 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Could it just be a vger issue?  vger has been acting ill today...
> 
> Possible. pr-tracker-bot obviously is back, it just had a very long delay.

Correct, there was another 12-hour vger outage on Saturday, so the pull 
requests were applied even before we started tracking them.

> And yes, the delay might have been due to it not seeing the original
> pull requests due to vger slowness. I didn't think to check if the
> pull requests were visible on lore.kernel.org when I was wondering
> where the pr-tracker-bot was.

If you wanted to check, just grab the message-id of the pull request and 
run it through lore.kernel.org/r/<message-id>. If it doesn't show up, 
then we're not tracking it.

Best regards,
-K
