Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF82727DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgIUOiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgIUOiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:38:50 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9880C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:38:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g3so12451997qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QMHiWFQdsvZHKBI/j/7oYy979M/DAsi7XHjdGEu8DOk=;
        b=lluI7KGPFyOukCPwfQIYGmlkjVC0zPmyi+/1Efes0ZxI/qiF5mtDVjKBuYQR4Bidno
         +Grn4xepSRETquj1FSjZP65oo/nVJPpIJ47WsFCpKrrocSfDbivpKwynueRb1Jf5d17G
         UF0WKlzZc8fXvd1fPz09pzJsNY1ZTzjwlgGUFvB2pNYOtK/MdP2W/kKVWsYTzigi9ENS
         98kapqDXy/tccuzjPeHbnjDQEvGWHayJep3AUpJUwc+pY8r7YZwMdg3/L04MH3HZR8Jf
         ooOV1DoRRXfK+0LqcUBIIhDAJa+TwfLDTQwq9gdKYaQY/63x70AaX+X/AgzrBS+peka1
         oJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QMHiWFQdsvZHKBI/j/7oYy979M/DAsi7XHjdGEu8DOk=;
        b=nMhI7QwAPzPHgJxANIfOCOPyngTNAfpPZuO4g0Xm5xQji2i6JnhQnhLKFO60LFsZGN
         pcO73r1Rmeakioko1Qw1IyRDXyHmpYlqSPCk6/Ev4zph0LLN0xE5UTYASDGQUdYdO6xA
         8Z2s/7bMiPSwKP8s+Hsud1j81gFmlbyi/LR+AD9DEHHbfJMOkh8i+4SfPv16r8oUGUnT
         YrWw2fQZLHJ8nDrxp+/xKWnACGLORkoF+6+wIuRieEKTRLBZyUEnCosP7D1EZc362c6E
         V0xMzp4P/fB2H6DHMIkTq2erJDTbZjJyCDgIBMtJFd+YonbIINkQGpTQqe5hgsWoS3lg
         xMdQ==
X-Gm-Message-State: AOAM532ULRKO3H3nfYPTfsjxt0B9s7OBgIgVnby9aEHKhNg8irUMzvTk
        jJASIGr4H9du8HdQTjcnOEA=
X-Google-Smtp-Source: ABdhPJzecNCAKF0YIZdZ2frAo/HvF0zJWZ70w2IuxkJ6PpqtVmpMDCAHcSVYUNSv5jfsRvd4iYhWPg==
X-Received: by 2002:ac8:4e49:: with SMTP id e9mr34887724qtw.167.1600699129898;
        Mon, 21 Sep 2020 07:38:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:54a6])
        by smtp.gmail.com with ESMTPSA id r24sm9825884qtm.70.2020.09.21.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 07:38:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Sep 2020 10:38:47 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200921143847.GB4268@mtj.duckdns.org>
References: <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200921134200.GK12990@dhcp22.suse.cz>
 <20200921141830.GE5962@xz-x1>
 <20200921142834.GL12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921142834.GL12990@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 21, 2020 at 04:28:34PM +0200, Michal Hocko wrote:
> Fundamentaly CLONE_INTO_CGROUP is similar to regular fork + move to the
> target cgroup after the child gets executed. So in principle there
> shouldn't be any big difference. Except that the move has to be explicit
> and the the child has to have enough privileges to move itself. I am not

Yeap, they're supposed to be the same operations. We've never clearly
defined how the accounting gets split across moves because 1. it's
inherently blurry and difficult 2. doesn't make any practical difference for
the recommended and vast majority usage pattern which uses migration to seed
the new cgroup. CLONE_INTO_CGROUP doesn't change any of that.

> completely sure about CLONE_INTO_CGROUP model though. According to man
> clone(2) it seems that O_RDONLY for the target cgroup directory is
> sufficient. That seems much more relaxed IIUC and it would allow to fork
> into a different cgroup while keeping a lot of resources in the parent's
> proper.

If the man page is documenting that, it's wrong. cgroup_css_set_fork() has
an explicit cgroup_may_write() test on the destination cgroup.
CLONE_INTO_CGROUP should follow exactly the same rules as regular
migrations.

Thanks.

-- 
tejun
