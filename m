Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39081BED7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD3BQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 21:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgD3BQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:16:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6427CC035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:16:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so53874wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l64V23ovWLJzXgRwUJUSoRHmFCYvD/C61lUFlvHuAM8=;
        b=NEm5AmoTD2jKzz4hSccJVFQ1FPjZ6Bxkvy9pbF1n13au2XvE7BgLVefCXG75LJARlN
         vnoy8WuPgSjgJpXQR+RcXTzwoRRtfu4SDZm+Yc+p6DSFyw0qj5XWcrtNba7s9fwH42iU
         Dmrs/6XTu4+ArHUN5ftQeDPkUfs2GVxihVugU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l64V23ovWLJzXgRwUJUSoRHmFCYvD/C61lUFlvHuAM8=;
        b=sLvdACwbh6VWkaIJEjDx24z8cXjyXF48rUWTWexC1rKJGOTCkFGLhStJI3NPTOILVm
         54TSVci4IegQo6URdF2e/+3OWSneOlQcyCLwpMjEr4bMuGPWocSmvwqfO7tdjQHPlN+i
         AqFv2vSCVf7lv2Lt17R20b4R5+X9uNjg83DEXl81yaOUZVzhg7EijP7SUeAFFseiJ689
         Le5FkWEqP7BhxeY38bsuTYyg1QzxGUdjkC0MclyjDDMx0rzkmk+rypCo24/ZR2En+dkQ
         88fDPEd6oQik+2KRc+zYqnlBKVqOEWZwjvY8gCfI1JT1Ob51FykyQAU5fnRxfjEKr4HT
         nnmg==
X-Gm-Message-State: AGi0PuZiQ3YCL+eKm2JdPG5jyv332O9ZiDxRRRil2qrArX9yz5eCyS6P
        TZBYnLK4G3bhric6eCThS9KQXlLdo0nJLQ==
X-Google-Smtp-Source: APiQypLqV+ArzORPofbv6BQwM8YI/oPdsz+Copu8gSwvyT8oSBSXG3Ri7l1nKh86jTZCo5uAEF/Ejw==
X-Received: by 2002:a05:600c:2c04:: with SMTP id q4mr93056wmg.7.1588209387919;
        Wed, 29 Apr 2020 18:16:27 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id e11sm1467438wrn.87.2020.04.29.18.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 18:16:27 -0700 (PDT)
Date:   Thu, 30 Apr 2020 02:16:26 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200430011626.GA2754277@chrisdown.name>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <CALOAHbCotD1-+o_XZPU_4_i8Nn98r5F_5NpGVd=z6UG=rUcCmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALOAHbCotD1-+o_XZPU_4_i8Nn98r5F_5NpGVd=z6UG=rUcCmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yafang,

Yafang Shao writes:
>Would you pls. add some comments above these newly added WRITE_ONCE() ?
>E.g.
>What does them mean to fix ?
>Why do we must add WRITE_ONCE() and READ_ONCE here and there all over
>the memcg protection ?
>Otherwise, it may be harder to understand by the others.

There is already discussion in the changelogs for previous store tear 
improvements. For example, b3a7822e5e75 ("mm, memcg: prevent 
mem_cgroup_protected store tearing").

WRITE_ONCE and READ_ONCE are standard compiler barriers, in this case, to avoid 
store tears from writes in another thread (effective protection caching is 
designed by its very nature to permit racing, but tearing is non-ideal).

You can find out more about them in the "COMPILER BARRIER" section in 
Documentation/memory-barriers.txt. I'm not really seeing the value of adding an 
extra comment about this specific use of them, unless you have some more 
explicit concern.
