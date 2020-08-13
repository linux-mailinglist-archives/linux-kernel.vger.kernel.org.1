Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B6D243933
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 13:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHMLPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 07:15:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:60822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgHMLPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:15:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4035B700;
        Thu, 13 Aug 2020 11:15:28 +0000 (UTC)
Date:   Thu, 13 Aug 2020 13:15:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813111505.GG9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813095840.GA25268@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-08-20 11:58:40, Uladzislau Rezki wrote:
[...]
> Sorry for jumping in. We can rely on preemptable() for sure, if CONFIG_PREEMPT_RT
> is enabled, something like below:
> 
> if (IS_ENABLED_RT && preemptebale())

Sure. I thought this was an RT specific thing that would be noop
otherwise.

> Also i have a question about pcp-lists. Can we introduce and use all allowed 
> MIGRATE_PCPTYPES? If called with GFP_RT_SAFE? If not please elaborate.

Yes we can. This depends on the provided gfp_mask. Many gfp flags will
be meaningless for such a context but essentially all we care about is
that ((gfp_mask & __GFP_RECLAIM) == GFP_RT_SAFE) for the checking
purpose. We can sort out all these details if this is decided to be the
right way to do. My (pseudo) patch was mostly to show the direction I've
had in mind for easier further discussion.

-- 
Michal Hocko
SUSE Labs
