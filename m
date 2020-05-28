Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132081E6C13
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 22:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406915AbgE1ULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406777AbgE1ULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:11:46 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAA6C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:11:46 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id e20so7099qvu.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=83zLTVKdvpR2KxKh88qE1mTweOG1k93RYAEKbnweuYU=;
        b=OgFfHLjM0xzOmXUQpzcCAMMrfpbK7MxIECNfhMYFKDunkqaArhuEzxRhhBna2RhZWt
         dI5uXxPB91bBATybc4BO6D/IZ9XFYihdh4Ww2J/zjZAOcfJs0Ywxe5XpkYtsbPVHcnN+
         dQNWfQWnFUJqwapSBddU8wJ3Jf+P0hmGbx79Gxlz8Mz4JxS/hOUQnsrgbwoTF/C2J9CY
         +ldcrCBHzBD9/d/fM7E+irtE/rIfpQJ/awZqWcpJtHj+TuXt7Gelc9gpi1v4YwSvup+R
         R95gCm5EwJnymHuv8GMnue0qTo/SUO2lAO0OvH4i1mBJbpu5cvs8jyDX5m3VeVsb1HgI
         xeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=83zLTVKdvpR2KxKh88qE1mTweOG1k93RYAEKbnweuYU=;
        b=JihZTfPImkgKIvHpR2kksXz31hv7KKtzP5x87HJYdjlBtAyOELZzT3He/snC8V4WDf
         dTo5reLK8pOHU/qUmnHZ34yEPXJ0AzcgngGmeMN3rpe1UsTXjCkhWYuY9YOSk9ilJu9f
         PiY7VkBBHllTC41gGXa4UHbfZ5DXebbxdHeGGCqEKMOnaf8HQrMPhn/KROYJHSL4hVae
         zEhPrAl3CFyqoyg06Vk3EwsutJSCeOimNJ1vhkaJq+qbuHOx6m8MzS2zG8Urb1lOM5wS
         nFNCVGz6njitfYu8O1GhzUn2scCb1teVmW6DJwD/fIfBD5h3NDjgsCS6byfdZgnYhAmP
         lVBw==
X-Gm-Message-State: AOAM530024mIS+zPjwC4IfbQHxiCjRv8KDDmj8iHD70MOyRpv/j804dB
        fWQs5q58veJrdBjQAIuQCJ3Izg==
X-Google-Smtp-Source: ABdhPJwVzQ41nOq3YlszafKQOCiQXl6KehufAtMo9uhqbuy6HXJ3L5Rb6re1G77IVPDUCvMjAIhTgA==
X-Received: by 2002:a0c:a9c6:: with SMTP id c6mr4986010qvb.224.1590696705375;
        Thu, 28 May 2020 13:11:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id v2sm5889705qtq.8.2020.05.28.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:11:44 -0700 (PDT)
Date:   Thu, 28 May 2020 16:11:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200528201117.GD69521@cmpxchg.org>
References: <20200520165131.GB630613@cmpxchg.org>
 <20200520170430.GG6462@dhcp22.suse.cz>
 <20200520175135.GA793901@cmpxchg.org>
 <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
 <20200521143515.GU6462@dhcp22.suse.cz>
 <20200521163833.GA813446@cmpxchg.org>
 <20200521173701.GX6462@dhcp22.suse.cz>
 <20200521184505.GA815980@cmpxchg.org>
 <20200528163101.GJ27484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528163101.GJ27484@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 06:31:01PM +0200, Michal Hocko wrote:
> On Thu 21-05-20 14:45:05, Johannes Weiner wrote:
> > After analyzing this problem, it's clear that we had an oversight
> > here: all other reclaimers are already familiar with the fact that
> > reclaim may not be able to complete the reclaim target in one call, or
> > that page reclaim is inherently racy and reclaim work can be stolen.
> 
> There is no disagreement here.
> 
> > We send a simple bug fix: bring this instance of reclaim in line with
> > how everybody else is using the reclaim API, to meet the semantics as
> > they are intendend and documented.
> 
> Here is where we are not on the same page though. Once you have identified
> that the main problem is that the reclaim fails too early to meet the
> target then the fix would be to enforce that target. I have asked why
> this hasn't been done and haven't got any real answer for that.

Then I encourage you to re-read the thread.

I have explained that reclaim invocations can fail to meet the
requested target for a variety of reasons, including dirty state or
other states that make memory temporarily unreclaimable, race
conditions between reclaimers and so forth.

I have also pointed out that this is widely acknowledged by the fact
that all other reclaimers retry in the exact same manner. If you want
to question that VM-wide precedence, please do so in your own patches.

As to the question around fairness, I have explained that fairness is
a best effort and that if push comes to shove, preventing premature
OOM situations or failing cgroup containment and causing system-wide
OOMs is more important.

> Instead what you call "a simple bug fix" has larger consequences
> which are not really explained in the changelog and they are also
> not really trivial to see. If the changelog explicitly stated that
> the proportional memory reclaim is not sufficient because XYZ and
> the implementation has been changed to instead meet the high limit
> target then this would be a completely different story and I believe
> we could have saved some discussion.

The point of memory.high reclaim is to meet the memory.high memory
limit. That, too, has been addressed - although it's astounding that
it needed to be pointed out. The proportionality is an attempt at
fairness that doesn't override the primary purpose.

I appreciate your concerns, but your questions have been addressed.

And you're not contributing anything of value to the conversation
until you familiarize yourself with the purpose of the memory.high
interface.

Thanks
