Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB2327E891
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgI3MaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3MaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:30:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77316C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:30:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x201so1129099qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pIB/BrnCARLplACqwVj4jzjc3q+0k51FVNXxV4ATL1Q=;
        b=MvP7h294xIEbRHpFMRAX5vBZbkFqX2uFaWtrhCH6eX4KSMS97KAXAyzrEK9Y7dAk97
         d1uxAZNy/tuonY70eOgM1fZWbPqoeBYIavErYPCC7+FKagXuF7XNmBYGw6QQfdOjpmOi
         809awPQYYMG/MuwcBs8wWJslB81H0ivECWC0DoUSrpphZGPYX83LuP320LWXV5aiFsHu
         2lQsbIkXsp67vfIgWZU0kefMmfdtqS+CFe3cA7ILCU1kEEWHKoAbf02NAEDTQCozWjV3
         JHaa3/S+SpW375p7xJ7mBvlHh15RjIquOGbLI2c33cKvs1ywJ6pOHKT5z83WOX4FazI3
         C0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pIB/BrnCARLplACqwVj4jzjc3q+0k51FVNXxV4ATL1Q=;
        b=R2L263I+q9URXxBdfG5KUiYq8ggRBQttVqfm4T/nTBSrKnukSH4Q0NoBZBGRMG+gQq
         orCJ3kWCapOaCTmWbeTRsCsfXM62HW6g3Z+m9obfSQnHEXdoNi4H6Qi4lHtiDX34YI45
         lUB8lZe8/k/+lO6kNNshEOuqbIwS+ySfqxqZZog/Yd63wZmfEy6pi8bvplmCMGohqsOS
         1IwZSQUU2B0srWsgfjWDHLkI3C+3QDeVBbtB4dXu0byx39pyl85duXoyBvn9tmMrLaqs
         owfTkX7I0Q9Mzm/qG4dWatcD2p17UvaqgFWs4fvhyVXT371m7gq1asZc6J/tKDUaD49o
         rA7A==
X-Gm-Message-State: AOAM530NhilBk+Hf9aHiD9qMXYGGydd1XIeskSYkGXkmA1MdP9RlZRyw
        2pjOR4h3rSJD9plsCZIMnWCdMg==
X-Google-Smtp-Source: ABdhPJy/rI7ioygbhkFzpvP77x46x3rVWfmjQBGcdZUXw4jxZDfPULCzx7I+MFCan2zB+xWmpExw5A==
X-Received: by 2002:a37:9301:: with SMTP id v1mr2372108qkd.350.1601469002489;
        Wed, 30 Sep 2020 05:30:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 196sm1857233qkm.49.2020.09.30.05.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 05:30:01 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kNbFA-003w5a-MC; Wed, 30 Sep 2020 09:30:00 -0300
Date:   Wed, 30 Sep 2020 09:30:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 3/4] mmap locking API: Don't check locking if the mm
 isn't live yet
Message-ID: <20200930123000.GC9916@ziepe.ca>
References: <20200930011944.19869-1-jannh@google.com>
 <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 06:20:00PM -0700, Jann Horn wrote:
> In preparation for adding a mmap_assert_locked() check in
> __get_user_pages(), teach the mmap_assert_*locked() helpers that it's fine
> to operate on an mm without locking in the middle of execve() as long as
> it hasn't been installed on a process yet.

I'm happy to see lockdep being added here, but can you elaborate on
why add this mmap_locked_required instead of obtaining the lock in the
execv path?

Jason
