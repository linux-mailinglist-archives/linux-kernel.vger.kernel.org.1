Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3126B379
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIOXDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:03:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbgIOOzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:55:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44D92AC7D;
        Tue, 15 Sep 2020 14:55:50 +0000 (UTC)
Date:   Tue, 15 Sep 2020 16:55:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     zangchunxin@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4] mm/vmscan: add a fatal signals check in drop_slab_node
Message-ID: <20200915145533.GG3736@dhcp22.suse.cz>
References: <20200915132741.84869-1-zangchunxin@bytedance.com>
 <20200915144737.GA2581123@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915144737.GA2581123@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-09-20 15:47:37, Chris Down wrote:
> zangchunxin@bytedance.com writes:
> > +		if (signal_pending(current))
> > +			return;
> 
> This doesn't match your patch title, please update it. :-)

I have to admit I have completely missed this and I think that this
should better be fatal_signal_pending because that would make sure that
the userspace will not see an incomplete operation. This is a general
practice for other bail outs as well.

> After that, you can add:
> 
> Acked-by: Chris Down <chris@chrisdown.name>

-- 
Michal Hocko
SUSE Labs
