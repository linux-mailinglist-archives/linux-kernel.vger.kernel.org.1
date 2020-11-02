Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF752A26F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgKBJ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:27:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:40128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbgKBJ14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:27:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604309275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZlskjhoYSfzJ/eJDetR1GZddrqtr18aAQLgNDYWBuaE=;
        b=VEOZnVeRCtmLaNTjY6K+BxZlP9bbWxc+cpUEFCW3qCVQJalwiAndxPMNSKpGx7jhkLWOiB
        dP0ioWLU3nHr/ac/ZhVFSVqsQoTQOr5ccgmUu//AbzgFZZyD3aP1s+SJ7v0iDrsjTWSnkT
        U33CKSBqbmVLctUpPE70xjewOTVVHJs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A55D5ABB2;
        Mon,  2 Nov 2020 09:27:55 +0000 (UTC)
Date:   Mon, 2 Nov 2020 10:27:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops -22.7%
 regression
Message-ID: <20201102092754.GD22613@dhcp22.suse.cz>
References: <20201102091543.GM31092@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102091543.GM31092@shao2-debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-11-20 17:15:43, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -22.7% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: bd0b230fe14554bfffbae54e19038716f96f5a41 ("mm/memcg: unify swap and memsw page counters")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I really fail to see how this can be anything else than a data structure
layout change. There is one counter less. 

btw. are cgroups configured at all? What would be the configuration?
-- 
Michal Hocko
SUSE Labs
