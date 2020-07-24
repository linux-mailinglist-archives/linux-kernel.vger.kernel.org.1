Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC722C7E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGXO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 10:26:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40814 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXO0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:26:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id b13so4786363edz.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fQc6a55htIZJuQwps2J4GcOYjRoEwiPLJFT6XTUnmHQ=;
        b=co13hGAxWKrQHH7wAK1ndTvQSGgqnOVIK0/x30TQ7T9VU9aT1nbq9JUzTDjgora2nk
         y0V5sm10lSSM5Cvur+s190t4ww8oU/3fC+EP3+Yy5Bw2obz8bcT6cV/yEzeGS11VUOAH
         ljMLpdnvqq184n2aVaUHa2lAnkB548k5W7ZTBCAWMze9sXhyc4CgU7aiIdE7of1EKrsU
         U8lVsAWLQl/x+Kp1cRIMtvafoFA6R5xvg7rLxxTCD30cIMgkGY+S7RPhSuCFxjAV8Wll
         4IurgZT8jrpecS0yvI3X3E5b3dear8lqv5Le4IUBSCcszzjV2zhQexxvi3C8bUzBPeQn
         6azA==
X-Gm-Message-State: AOAM5301OvudP+ZBcf5olwp4IMGRr9WTqQqlmeVIzPvQwoKFqhdm6GhH
        Z6JoCqbUkq1vXXAw2MJ2SzY=
X-Google-Smtp-Source: ABdhPJxT/FT7VCkOSUSQBSY40kqmPgw0t7WYcwoSmE1x+0nvVqgkavSXxCfqTks2iqxN2EDg6+Xfbw==
X-Received: by 2002:a05:6402:b99:: with SMTP id cf25mr8889248edb.291.1595600791843;
        Fri, 24 Jul 2020 07:26:31 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id v24sm789166eds.71.2020.07.24.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:26:30 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:26:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, mgorman@suse.de,
        walken@google.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jianchao Guo <guojianchao@bytedance.com>
Subject: Re: [Phishing Risk] [External] Re: [PATCH v2] mm/hugetlb: add
 mempolicy check in the reservation routine
Message-ID: <20200724142629.GA31772@dhcp22.suse.cz>
References: <20200724100306.33457-1-songmuchun@bytedance.com>
 <20200724113415.GG4061@dhcp22.suse.cz>
 <CAMZfGtUVHN4HA45d18zxQVUJvWyVPimvKG=y3YDPJBhu4ocLPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUVHN4HA45d18zxQVUJvWyVPimvKG=y3YDPJBhu4ocLPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-07-20 21:56:29, Muchun Song wrote:
> On Fri, Jul 24, 2020 at 7:34 PM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > I believe you can simplify this and use a similar pattern as the page
> > allocator. Something like
> >
> >         for_each_node_mask(node, mpol_allowed) {
> >                 if (node_isset(node, &cpuset_current_mems_allowed))
> >                         nr += array[node];
> >         }
> >
> > There shouldn't be any need to allocate a potentially large nodemask on
> > the stack.
> 
> An unsigned long can satisfy 64 nodes. So I think that nodemask is using
> little stack memory. Right?

CONFIG_NODES_SHIFT=10

is not something surprising. E.g. SLES is using that default for a long
time because those kernels tend to run on very large machines.

-- 
Michal Hocko
SUSE Labs
