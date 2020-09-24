Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5641277385
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgIXOCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXOCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:02:40 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED9EC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:02:40 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t138so3373567qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DX2HQBWGuaee0luRYYI4yMH5TJumhhW2wtpCA8Ku7VM=;
        b=HpQfoeidFIVPg4nNWvc99Nd1mzrQYL7G5U3CfwQS6NtRbSZ6TWjV3NaFirSAgay8+7
         qPkj9wN/8HI6zi4hV92cb3wmwVKvcf9IjHpyIeZCPvsu5/oWGU90Z1mn4GI2RiC1FvW/
         fQ+okKbI4dzzb0R6+cL3CgVL5ymexsRNylv6jWp7s88HQ7JfFjYL+vA98LXH9JudhEWI
         nBlZW41T72JraFIFMo+xcmWAfOnU18KTBrBdI/STIvlPMxSm+PtoRaMfTSdq9dQjU061
         BPy+5vdnYnZFad3cQQ7Sk95i6VXk5j0vi9xBRE5JreeisjZhgq5OAOrjWs7jANCNWsjk
         boPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DX2HQBWGuaee0luRYYI4yMH5TJumhhW2wtpCA8Ku7VM=;
        b=nogHKzYfRUcjlfPtJ20TQV/+WgliGqCHzwpqySjV+1BX9fIjN6PBm9bh+6OZ8dmCP1
         n9Y3fd+wkATrYv104DQwsZXFoqUq78Zmkkw0Wgam/G4uKslzUwZhy2V+fAUxMX8YmpX8
         jK5dmwgdWybIhikMcftK3zyndAxvwsIcSyyP0p1dyL2RX05VM3ZruNOXdF4D1SQThHp3
         AQU2rjiv2X3EENSiW3nYCEay/3NxPfT+YPmXW9a9sfk1dpDxkTxP79dccnW0s+bjtPc/
         3RgpqISYe8MvrLVMb2JP1a4FYAPQgYM6eBX9CoNr+DgvQTKcbtZQVq3Le94BOTNY5s3V
         tHRA==
X-Gm-Message-State: AOAM530a2GuB5uXEh/fj8NI8GHC9ktcx+8/S5aAMeY7gLc14dNhf1y6R
        aBCcs3Oj1lNYUriGTJOAqxz2OA==
X-Google-Smtp-Source: ABdhPJzdb+LYnbfPo+87vNSC6CT7v1UxrZxA4oszJTG1SGGGsOjoeh2l7+pKS8fv9n+QXuNFfGESIQ==
X-Received: by 2002:ae9:e84c:: with SMTP id a73mr4721002qkg.61.1600956159787;
        Thu, 24 Sep 2020 07:02:39 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x43sm2375131qtx.40.2020.09.24.07.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:02:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kLRpV-000LQR-Ov; Thu, 24 Sep 2020 11:02:37 -0300
Date:   Thu, 24 Sep 2020 11:02:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200924140237.GD9916@ziepe.ca>
References: <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923131043.GA59978@xz-x1>
 <20200923142003.GB15875@quack2.suse.cz>
 <20200923171207.GB9916@ziepe.ca>
 <20200924074409.GB27019@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924074409.GB27019@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 09:44:09AM +0200, Jan Kara wrote:
> > After the page is pinned it is prevented from being freed and
> > recycled. After GUP has the pin it must check that the PTE still
> > points at the same page, otherwise it might have pinned a page that is
> > alreay free'd - and that would be a use-after-free issue.
> 
> I don't think a page use-after-free is really the reason - we add page
> reference through page_ref_add_unless(page, x, 0) - i.e., it will fail for
> already freed page. 

I mean, the page could have been freed and already reallocated with a
positive refcount, so the add_unless check isn't protective.

The add_unless prevents the page from being freed. The 2nd pte read
ensures it wasn't already freed/reassigned before the pin.

If something drives the page refcount to zero then it is already
synchronized with GUP fast because of the atomic add_unless, no need
to re-check the pte for that case?? But I don't know what the DAX case
is you mentioned.

Jason
