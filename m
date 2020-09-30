Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7827E89C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgI3McX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgI3McT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:32:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E1BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:32:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id db4so766106qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NkfhHWqAyTXfsHUI0Z4eVtQNkwGeBFdljOZ84SCK75I=;
        b=GUGGoSv/+Zv/Uq7Uw1zhk63u/eHB/U4rT/5bP8wIu7UwiI+nt2KRiWKpcHUl0qoTw6
         rJUIwRmN4L2cprluAoSgLHWcIAMWfRIYyxJ3tTB8g4nJF+LQAzgm5gAZPeDCMSCcXOgi
         muMYRHXyLdX1Q7BW1No7xEPmeohy4cJtByCMrokGA0fI8vMMWs8DfCku0GrXBtlWnN2T
         jQxgjzfdbgQOQge0gNFmt8U0Wkc1Fpqp2g9uS/iprfFvk4M5FoyriSZHVYYC70BX/yHZ
         0+9L20hw+fCOvid6nhsW7QnsSqP492hv2+L5lOlAqOZOs53MxDbbilEPKju5k5yUR/aH
         vZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NkfhHWqAyTXfsHUI0Z4eVtQNkwGeBFdljOZ84SCK75I=;
        b=POj2ohLC6g1mUZGKA/hX11tN3HGKt1AGhKKo+JiSWzpUr+uQtF/LMtX9gjdX0aQwDC
         Nv+zHKQBMRqTrtUqEbQ48MwjpY1OKQKPbsksTavX45BEuYuegoKDOrBIQJ/CGQpYw49o
         ffHtHMLcd2TqdsG9SV6j36jsGRdRFuaXjruRZwA54ZCqS95iqr/qWJBRzmu50O2l9JTo
         WVFfb7X+WPR2f2dFYtIQ+TPy0ieSOHf+btOVYsW5/0fOYPGaEg2v6iUmT2/j6IU98ObQ
         mDYqCfvQkoHgN+en789URCx85nmrIRluGCUSSo22brQUYBzYk9yTkjXyUioQksiBR5Km
         daAg==
X-Gm-Message-State: AOAM530urDrGXINVborAVFVJHFVTpZM+XcnKPZlElaPKHjen99tQgwGw
        vyUwqLW81rgJK8MjsNHn2bgv0g==
X-Google-Smtp-Source: ABdhPJxr1lJohZaVmNubjdVqFxJt30RPkWUcDblap0Wx8uvGAf8koWgYxRBQ3wu+zrgv4Al9PQ7N6g==
X-Received: by 2002:a0c:e5cf:: with SMTP id u15mr2213842qvm.14.1601469138414;
        Wed, 30 Sep 2020 05:32:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u46sm2193852qth.31.2020.09.30.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 05:32:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kNbHN-003w8o-3n; Wed, 30 Sep 2020 09:32:17 -0300
Date:   Wed, 30 Sep 2020 09:32:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 4/4] mm/gup: Assert that the mmap lock is held in
 __get_user_pages()
Message-ID: <20200930123217.GD9916@ziepe.ca>
References: <20200930011944.19869-1-jannh@google.com>
 <CAG48ez1GM==OnHpS=ghqZNJPn02FCDUEHc7GQmGRMXUD_aKudg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1GM==OnHpS=ghqZNJPn02FCDUEHc7GQmGRMXUD_aKudg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 06:20:01PM -0700, Jann Horn wrote:
> After having cleaned up all GUP callers (except for the atomisp staging
> driver, which currently gets mmap locking completely wrong [1]) to always
> ensure that they hold the mmap lock when calling into GUP (unless the mm is
> not yet globally visible), add an assertion to make sure it stays that way
> going forward.
> 
> [1] https://lore.kernel.org/lkml/CAG48ez3tZAb9JVhw4T5e-i=h2_DUZxfNRTDsagSRCVazNXx5qA@mail.gmail.com/
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  mm/gup.c | 2 ++
>  1 file changed, 2 insertions(+)

I'm happy to see this, I have observed many cases of missing locking
here.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
