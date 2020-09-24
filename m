Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F742775BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgIXPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728343AbgIXPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600962478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0Wq6XmFh8VZYlX5hyJG2SFGzwON1YoEuWr2uV15tgk=;
        b=ZPhg9WFb+bpaMTNcw+J1/WkDIaJ7LJD0mpYSk8eNCcyGnY8EE03ycWjo5Xw/Ai3fLV+1PX
        x1fR543ggFnGpehbetUnCjcO3yuJvzCqaici8UFKad9n3TcWXoAxF/NZYrP3mHIkYRSdl6
        fhF8vFUFX+mvfdpgz8uvSDoxaGNODZw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-UHLIxRymMPav4AgdVHFKXA-1; Thu, 24 Sep 2020 11:47:54 -0400
X-MC-Unique: UHLIxRymMPav4AgdVHFKXA-1
Received: by mail-qk1-f200.google.com with SMTP id c19so2166334qkk.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O0Wq6XmFh8VZYlX5hyJG2SFGzwON1YoEuWr2uV15tgk=;
        b=ESYVMLqH3ckogILyEUPLBb06qW8XSn5DKhiU2cJl+oKtEBqfdjnlcMOPUJS4v2aYx2
         Ey5SgzWapcedwcmpZEyZA/xY8txYDTM/hQU9gAP/AMhUjk8YtVk6escJorhgf5XS5sqd
         hgvqx5di+pTDZF/WJRhrAO5J6j4MwL+VX3R6rRv4bufO2miZF2sWXHnJYKOpFNtpgO7/
         lk3Ufr6T8hEO8XUVH4FtcsYuFo4Fo3OTob1B+Cc45h8f0TayJjCbKu3rQ/IkSIGaSirR
         KkWjPCcOJYg3d4Ei0F051//ev2HDhERQ/ik71kBjD8EBw+VhsZnoSGSbCtPVi0ebOqZU
         WU6w==
X-Gm-Message-State: AOAM531uOap2DlwAwzSnwHRYvnJVwjUSYHfEM/hZKcjN6KyiuQzriR2I
        P09oLcsbEjc4qbN+wdoW6ppB1UkmVzbvQ36AYUyQWX1JohX4AODD/lfAsRBeu0UhBG0Nsk+u/6M
        YAwMzcaJstzeIRt325R2ha9IS
X-Received: by 2002:ac8:44d2:: with SMTP id b18mr207746qto.172.1600962473342;
        Thu, 24 Sep 2020 08:47:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwreSc2tbtHJRziSdtOdjy5McetvBzD4coNC11o5h8a949nql2Owr48ZHNuTtrX+uJg3D6ySg==
X-Received: by 2002:ac8:44d2:: with SMTP id b18mr207716qto.172.1600962473096;
        Thu, 24 Sep 2020 08:47:53 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id d9sm2487108qtg.51.2020.09.24.08.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:47:52 -0700 (PDT)
Date:   Thu, 24 Sep 2020 11:47:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when
 fork()
Message-ID: <20200924154750.GG79898@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <20200922120505.GH8409@ziepe.ca>
 <20200923152409.GC59978@xz-x1>
 <CAHbLzkr_C-4g+ArA3JXyvFHiAzU1ObHA9f4t1anj=N9b8oi7wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkr_C-4g+ArA3JXyvFHiAzU1ObHA9f4t1anj=N9b8oi7wQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 09:07:49AM -0700, Yang Shi wrote:
> For tmpfs map, the pmd split just clears the pmd entry without
> reinstalling ptes (oppositely anonymous map would reinstall ptes). It
> looks this patch intends to copy at pte level by splitting pmd. But
> I'm afraid this may not work for tmpfs mappings.

IIUC that's exactly what we want.

We only want to make sure the pinned tmpfs shared pages will be kept there in
the parent.  It's not a must to copy the pages to the child, as long as they
can be faulted in later correctly.

-- 
Peter Xu

