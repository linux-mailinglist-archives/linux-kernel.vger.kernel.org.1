Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033522F85C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbhAOTxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbhAOTxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:53:43 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67290C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:53:03 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id a1so4535025qvd.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YOccbbRfNSMXCGHDICvlCYRLO57HHlYqke/K97gEpqY=;
        b=Vmi+u5PnGq6QrC1+HQaWL+Z9MasdSmvK4regdUEaYNDa3KpJZeZ428RDXeJ9sECCO+
         M9AcotGIPwNygQxluD0kcNW7qLMofiOdCClq8ak6Rvgq39cQwjWF2dJjOTjRXluBVZea
         duIg9VogrWWguzhAcMogxS3yK4+OnM1uacXpRMnuCtQodaVSUz4JpZaAi3eut8v4r4uw
         lQh1tQlSHl+SzlgtaJYhoapjFIFkbSsAgBDJmRIy3bmSwk7EIIJhYy8VJ4DaUh77foP/
         SNhwo3ld4KVHCbVWNOVvOQerm1h8fkks/sNEJ3phQB52K5Rk7WjazRMk0GzkYZvmnLj4
         iEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YOccbbRfNSMXCGHDICvlCYRLO57HHlYqke/K97gEpqY=;
        b=kCBeUNn3MYqc2wNCE2BVwa/+ad5S7Nl74AU7meI/wDakJbQKJAgURgGN3yFdjK/rZP
         ckVutupbhK1UtoDLYGcxaFx0Q16AOjPqsUxaujy0Za3kZhZ1ewbu6uwwut8ieRkxul9A
         jI+S+nzCm2Fc24DApe6CMrdMSp18ewBw44Cbj0fi9633zLSW3Qk0a/Kw/u9CiJFlkCTO
         mX+uyfdyt6BpqqmwVMR0iHers2yukOnipMR2Wze8JZSE2CfH3y25s2KZ9U/DnL5PDTIS
         cUsJ9LJxbyfp6r2+qOIYehubbpQ9noN5SxznCe/bCejexyE09V6VbxWJrBcxJOxsGgjZ
         wcGA==
X-Gm-Message-State: AOAM532NVyMrQiwAoTFSFvMnVY14QHIS4f2Qe115viVrXEMmekznLb7l
        H01+1YkbTucsfnDT6p13FKQm7g==
X-Google-Smtp-Source: ABdhPJxriPVEn+gJbENVTGxzVi7zq0Loc9XYuq8r8ugANKBL+YABpxLTdVL2mVhCv6OgltIqedZo+g==
X-Received: by 2002:ad4:452f:: with SMTP id l15mr13829167qvu.49.1610740382661;
        Fri, 15 Jan 2021 11:53:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id c49sm603116qta.89.2021.01.15.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:53:02 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l0V9Z-0022NF-Ib; Fri, 15 Jan 2021 15:53:01 -0400
Date:   Fri, 15 Jan 2021 15:53:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210115195301.GI4605@ziepe.ca>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <bb071419-bf40-c5ed-4b2d-d5eb03031b0a@redhat.com>
 <20210115183721.GG4605@ziepe.ca>
 <a21e6fdf-5cac-6fda-242e-7909af96027a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21e6fdf-5cac-6fda-242e-7909af96027a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 08:46:48PM +0100, David Hildenbrand wrote:

> Just wild ideas. Most probably that has already been discussed, and most
> probably people figured that it's impossible :)

No, I think it is all fair topics.

There is no API reason for any of this to be limited, but in practice,
I doubt there is more than small 10's

Huge pages complicate things of course

Jason
