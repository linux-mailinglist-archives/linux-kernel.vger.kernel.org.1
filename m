Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC99C2A27AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgKBKCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:02:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:60774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgKBKCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:02:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604311369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tNKEMmH9F8juYqw2jPkbqFetX3SlnA/nJyxI3Ms+uYo=;
        b=ZJyAF9LYWfqq85yQyRWy4N8uDn66xqvjZkD0cEW4z6JDaSpKntkeehIkO0H/DpB8FW8+CT
        UVVOA5YBjCUOJnRaSa9a0lzcd7TZRnqF2mkmKPnQRZcxi9KVR16T+WDL8sxCyMTVVuWudW
        d+iCxOkePeY6KKSX60P3D58Soeyajao=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE486AC8C;
        Mon,  2 Nov 2020 10:02:48 +0000 (UTC)
Date:   Mon, 2 Nov 2020 11:02:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rong Chen <rong.a.chen@intel.com>
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
        lkp@intel.com, zhengjun.xing@intel.com
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
Message-ID: <20201102100247.GF22613@dhcp22.suse.cz>
References: <20201102091543.GM31092@shao2-debian>
 <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-11-20 17:53:14, Rong Chen wrote:
> 
> 
> On 11/2/20 5:27 PM, Michal Hocko wrote:
> > On Mon 02-11-20 17:15:43, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -22.7% regression of will-it-scale.per_process_ops due to commit:
> > > 
> > > 
> > > commit: bd0b230fe14554bfffbae54e19038716f96f5a41 ("mm/memcg: unify swap and memsw page counters")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > I really fail to see how this can be anything else than a data structure
> > layout change. There is one counter less.
> > 
> > btw. are cgroups configured at all? What would be the configuration?
> 
> Hi Michal,
> 
> We used the default configure of cgroups, not sure what configuration you
> want,
> could you give me more details? and here is the cgroup info of will-it-scale
> process:
> 
> $ cat /proc/3042/cgroup
> 12:hugetlb:/
> 11:memory:/system.slice/lkp-bootstrap.service

OK, this means that memory controler is enabled and in use. Btw. do you
get the original performance if you add one phony page_counter after the
union?
-- 
Michal Hocko
SUSE Labs
