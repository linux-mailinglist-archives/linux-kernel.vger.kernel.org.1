Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A1E2419E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgHKKqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 06:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgHKKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:46:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A35BC06174A;
        Tue, 11 Aug 2020 03:46:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so12977695ljj.4;
        Tue, 11 Aug 2020 03:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QbMPdkDZ6gl/XQAeycQLRz6hlFETojbWgl9OUCbj+o8=;
        b=KdMQrkY1LdGJd0zpajnMj9oxmjqrSVc1Ggja6K/3OAPivsUw0oJkKNiUY4F9waF1te
         XJLnps9AOaVyx0c1Tp21zoeFkUQuH89qxsROKFQ7b77W53d2REmt6Bu4TmUy+i8lWz8y
         vKpxJyAbci8bqRPsojduDOCfOii3mGmsZqUN49Q+xf9cYn6m+atFNVbXk2ymWuDOpCCr
         qs2rxr/iO4UWtrO++nxmHmAqHhwsHuYSayZxG4GgODL+GUqdSCy50rEqp66ChcBhk6mR
         wsrTP7gexzSD3OKV+/EGs6/L8J1rn+t00EYTY/1HBeWLr3EeOnBlt5Er4SFM6sLCbl9p
         zfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QbMPdkDZ6gl/XQAeycQLRz6hlFETojbWgl9OUCbj+o8=;
        b=Bnh+umub2g/91sLA5Bu/K8hIcCBRPcWHjOVnVxQWXA3Ttvd2Bkk0Kywv6axP4Zwgbw
         R8VkepsSoVkMcN/t71vBvC5jGiLoTq5V+h9+9vzvDwYJsDKKYF9on0Due1+OcK8EY80k
         1n53v3FajDa+sWoE0nsR+n9MlRusGTxNRnjHUPuG3sBi+3LR0zwbyEuz2S81F5YdboeX
         cY1sFDdEiQGDzZ0vVyWl4oW0asaZReyXFR7+ovYOkoQQYizKJc7rGtg8gAVii56EvRHQ
         B9uY9CPlKgnf15py5x+4J/g5sAsaLuWMu+60qhMiKRJUVYmn+DmxLC8QwrrX+HmgPr7n
         IBdg==
X-Gm-Message-State: AOAM531UF6fOPakyDBK4s2RbKTI6Xr3WW438miTmPAXRFFF++njwBkwx
        igfozEn1t7eDKnNZ65oFoQI=
X-Google-Smtp-Source: ABdhPJzhc/jXUCVGVIhHeGPo2BEqY7mmIBU7D7Izx8scomgDPFT4g7QVNFF+iXyroJpk6NgUN+PwYw==
X-Received: by 2002:a2e:8589:: with SMTP id b9mr2661458lji.126.1597142760327;
        Tue, 11 Aug 2020 03:46:00 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id m12sm9353432lji.106.2020.08.11.03.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 03:45:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 11 Aug 2020 12:45:57 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200811104557.GA5301@pc636>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <20200811081917.GG4793@dhcp22.suse.cz>
 <20200811093713.GB2634@pc636>
 <20200811094251.GA3767@pc636>
 <20200811102818.GJ4793@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811102818.GJ4793@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:28:18PM +0200, Michal Hocko wrote:
> On Tue 11-08-20 11:42:51, Uladzislau Rezki wrote:
> > On Tue, Aug 11, 2020 at 11:37:13AM +0200, Uladzislau Rezki wrote:
> > > On Tue, Aug 11, 2020 at 10:19:17AM +0200, Michal Hocko wrote:
> [...]
> > > > Anyway, if the zone->lock is not a good fit for raw_spin_lock then the
> > > > only way I can see forward is to detect real (RT) atomic contexts and
> > > > bail out early before taking the lock in the allocator for NOWAIT/ATOMIC
> > > > requests.
> > > >
> > This is similar what i have done with mm: Add __GFP_NO_LOCKS flag. I just
> > did it for order-0 pages(other paths are impossible) and made it common for
> > any kernel.
> > 
> > Because when you say "bail out early" i suspect that we would like to check
> > the per-cpu-list cache.
> 
> Bail out early means to do as much as possible until a raw non-compliant
> lock has to be taken.
> 

<snip>
struct page *rmqueue(struct zone *preferred_zone,
   struct zone *zone, unsigned int order,
   gfp_t gfp_flags, unsigned int alloc_flags,
   int migratetype)
{
 unsigned long flags;
 struct page *page;

 if (likely(order == 0)) {
  page = rmqueue_pcplist(preferred_zone, zone, gfp_flags,
     migratetype, alloc_flags);
  goto out;
 }

 /*
  * We most definitely don't want callers attempting to
  * allocate greater than order-1 page units with __GFP_NOFAIL.
  */
 WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
 spin_lock_irqsave(&zone->lock, flags);
<snip>

only order-0 allocations can be checked if CPUs pcp-list-cache has something.
I mean without taking any locks, i.e. it is lockless. "Pre-fetching" is not
possible since it takes zone->lock in order to do transfer pages from the buddy
to the per-cpu-lists. It is done in the rmqueue_bulk() function.

--
Vlad Rezki
