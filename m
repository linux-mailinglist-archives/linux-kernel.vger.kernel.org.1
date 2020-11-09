Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1642AC0DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgKIQ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbgKIQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:27:28 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:27:26 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u2so4963190pls.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3nZrjD1ndhIGrNkP0+j/bsTnARfkt2zQnVxA///gigE=;
        b=ngqxHvMOHZ9krz3j7E8GBdjjoeUp5kFsOrXgkfhPfUwJPXJQgvfDMOT/ovwjDJ6vS8
         FwLF41B9BfiOl3PI2iq+EwzhsrcoNpCsVKE9dVQAUHySRdSK8lrF1kGwHbUdZgAnmu7f
         WrQRNQgRNdDV4EKr/33Aqpx8E5Wfr8UqtcyzuWD6DRo/o52DWjHD2mIJ+DtIemw4fzbP
         ouojNVMDR3YoD4Khp1a5oDFiIaknxuaXwo3R8TGlb7lXP6AscFAZ6l67c50M0r/K9l2u
         /U61S2shcAFWrX23YmZYHqKrbk7exiWjIMJ0fmf4jcolG6G9pHNV7RCQ0ZMJjbgqD1aN
         OkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3nZrjD1ndhIGrNkP0+j/bsTnARfkt2zQnVxA///gigE=;
        b=eJBvQX8db+HAZSYHpDfzpoPy+nZOrQaQZ484RKCNlXpz09HMmZWy9ckS5VP3emqaWD
         2A0zyf+AwOLQpH8SA533u8RxeTtKegYAcIlOhpaNFSrZejzfbbSd4O+8PEue29KOOAnv
         4ubPhdS7oPU/llv7tE3GugiTiC/vcQzTLYh/b5umLWWSB/Rb3ULpXdNEbgl0ekGbDw7m
         YzGNjdVcyspdC1rk7QUvQ8LvsfiUvT1Z+Dur4h8DPZ5IIKxSFD7c3rasaTTTHjBVYFbj
         BezkJlwi2jr+xTrBKsa6+fP7LxdpCewY9dkVq+l5EcrKYY5I54GBuhMV86f1rDbHPTGk
         eR0w==
X-Gm-Message-State: AOAM5337eBteqJ2+5x4CwVvxUkZe+9KCZTqIkn9ctYCOzLwPuulopUyv
        Mb2ignYTp/bzgpWUc0qqfU8=
X-Google-Smtp-Source: ABdhPJyH1Wkvkd9qt1aJTLqMlqUVOGs4B6DTonVdfTyFiTlLkFO8xwN0xfzear0FyS6X6HhDCwWK+g==
X-Received: by 2002:a17:902:8508:b029:d5:af79:8b40 with SMTP id bj8-20020a1709028508b02900d5af798b40mr13116951plb.28.1604939245026;
        Mon, 09 Nov 2020 08:27:25 -0800 (PST)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net. [67.188.94.199])
        by smtp.gmail.com with ESMTPSA id w66sm12095969pfb.48.2020.11.09.08.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:27:23 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 9 Nov 2020 08:27:21 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: introduce oom_kill_disable sysctl knob
Message-ID: <20201109162721.GB449970@google.com>
References: <20201106203238.1375577-1-minchan@kernel.org>
 <20201109073706.GA12240@dhcp22.suse.cz>
 <20201109153933.GA449970@google.com>
 <20201109160618.GI12240@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109160618.GI12240@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 05:06:18PM +0100, Michal Hocko wrote:
> On Mon 09-11-20 07:39:33, Minchan Kim wrote:
> > On Mon, Nov 09, 2020 at 08:37:06AM +0100, Michal Hocko wrote:
> > > On Fri 06-11-20 12:32:38, Minchan Kim wrote:
> > > > It's hard to have some tests to be supposed to work under heavy
> > > > memory pressure(e.g., injecting some memory hogger) because
> > > > out-of-memory killer easily kicks out one of processes so system
> > > > is broken or system loses the memory pressure state since it has
> > > > plenty of free memory soon so.
> > > 
> > > I do not follow the reasoning here. So you want to test for a close to
> > > no memory available situation and the oom killer stands in the way
> > > because it puts a relief?
> > 
> > Yub, technically, I'd like to have consistent memory pressure to cause
> > direct reclaims on proesses on the system and swapping in/out.
>  
> > > 
> > > > Even though we could mark existing process's oom_adj to -1000,
> > > > it couldn't cover upcoming processes to be forked for the job.
> > > 
> > > Why?
> > 
> > Thing is the system has out-of-control processes created on demand.
> > so only option to prevent OOM is echo -1000 > `pidof the process`
> > since they are forked. However, I have no idea when they are forked
> > so should race with OOM with /proc polling and OOM is frequently
> > ahead of me.
> 
> I am still confused. Why would you want all/most processes to be hidden
> from the oom killer?

If one of processes in the system is killed, the memory pressure
disappear.

>  
> > > > This knob is handy to keep system memory pressure.
> > > 
> > > This sounds like a very dubious reason to introduce a knob to cripple
> > > the system.
> > > 
> > > I can see some reason to control the oom handling policy because the
> > > effect of the oom killer is really disruptive but a global on/off switch
> > > sounds like a too coarse interface. Really what kind of production
> > > environment would ever go with oom killer disabled completely?
> > 
> > I don't think shipping production system will use it. It would be
> > just testing only option.
> 
> Then it doesn't really belong to the kernel IMHO.
> 
> > My intention uses such heavy memory load to see various system behaviors
> > before the production launching because it usually happens in real workload
> > once we shipped but hard to generate such a corner case without artificial
> > memory pressure.
> 
> But changing the oom behavior will result in a completely different
> system behavior. So you would be testing something that doesn't really
> happen in any production system.

Since OOM is not instantly reacted, it still provides a good chance how
the system reacts on such memory pressure until someeone releases the
memory. For example, Android already gives lots of system processes to 
-1000 which could effectively disable the OOM at certain point.

> 
> > Any suggestion?
> 
> Not really because I still do not understand your objective. You can
> generate memory pressure and tune it up for specific testing scenario.
> Sure there will be a some interference from the background noise (kernel
> subsystems reacting to external events, processes created etc.) but why
> that is a problem? This is normal to any running system.

Putting more pressure from background processes is okay for the goal but
not okay for relieving th memory pressure since we lost the testing
environment.
