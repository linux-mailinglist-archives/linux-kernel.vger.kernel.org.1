Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD1274E10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIWBDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbgIWBDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600823017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYTDkmTafNbJNdPtFz5RF6SE07Ft93O9frOXJeIZMpM=;
        b=czhgUCUjFEajXO48KEWLGeZcX0CwSjTrA0LqELmQuI6mCIa6oQYLPAA9skpzNkIurCuXWd
        b74M3SSPxupuRbdPsy4h8LsFc+dckhKslfpMLgg/ZgaZYdReHTiy3kKNqKycHYC2TNYtIh
        g5vD5zxx/qwx5Ed5rptRfM3fAstOgEI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-jclxV-S0OFuydm1b3HzTHA-1; Tue, 22 Sep 2020 21:03:36 -0400
X-MC-Unique: jclxV-S0OFuydm1b3HzTHA-1
Received: by mail-qk1-f199.google.com with SMTP id 125so15465136qkh.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tYTDkmTafNbJNdPtFz5RF6SE07Ft93O9frOXJeIZMpM=;
        b=DTHPErU5PGcJy6daMbV9NKB5KcVOIDLV13+HiSybZ+C32+UcZy0rtOPlptMBsR1ZBQ
         bt3Lth4oz5DaqIArdU2+eG5SnJ5uOz7KXS/PRIto4C4jNBhB+ZaFtD7OwVaCDZy+Jcf8
         PVwoCiSrqgj9UqKF5QvYlrwqdoXpGN9FesslUPnokAoa0ICePCAgP5J2WKms6Dh92x9y
         fdG1BiMKA9lVdQ+sNqWxph7+/YHRd/SMmkO5us4tn/y5TE0m9+bbE3b0T3tTgPsQduTb
         FPv+9uatK4PCMJVwsfPN5ABCpyDDI2v5htmGeYvMuiM1yMkBOp+kYyqOZ+niyRuxz4A3
         tWyg==
X-Gm-Message-State: AOAM530xZj4bSe94Sb9We9p+OTZZZwpNhoYY+BtfGCgEqBkweomgru3d
        1VzjV2SU18xWo1taBu+A8woxPYaTqsZAVdlY8HPpuuEylTeYx510XSEGK4fflScu9h81+DJIjt0
        u9k2bo4giHoJ14eBAmth5Gnq8
X-Received: by 2002:ae9:e84c:: with SMTP id a73mr7482041qkg.432.1600823015460;
        Tue, 22 Sep 2020 18:03:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytLLPRvlF3rQEFDbUVECJiGXlt2EU/+dRSlt5GUHhN3hLqqHZmzrtwsnS8SNmMEmxQ0iLY4A==
X-Received: by 2002:ae9:e84c:: with SMTP id a73mr7482019qkg.432.1600823015232;
        Tue, 22 Sep 2020 18:03:35 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id w94sm13879882qte.93.2020.09.22.18.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:03:34 -0700 (PDT)
Date:   Tue, 22 Sep 2020 21:03:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for
 ptes
Message-ID: <20200923010332.GP19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <20200922114839.GC11679@redhat.com>
 <20200922124013.GD11679@redhat.com>
 <20200922155842.GG19098@xz-x1>
 <20200922165216.GF11679@redhat.com>
 <20200922183438.GL19098@xz-x1>
 <20200922184359.GI11679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922184359.GI11679@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 08:44:00PM +0200, Oleg Nesterov wrote:
> On 09/22, Peter Xu wrote:
> >
> > Or I can also do it in inverted order if you think better:
> >
> >         if (unlikely(copy_ret == COPY_MM_BREAK_COW)) {
> >                 WARN_ON_ONCE(!data.cow_new_page);
> >                 ...
> >         }
> 
> Peter, let me say this again. I don't understand this code enough, you
> can safely ignore me ;)

Why? I appreciate every single comment from you! :)

> 
> However. Personally I strongly prefer the above. Personally I really
> dislike this part of 4/5:
> 
> 	 again:
> 	+	/* We don't reset this for COPY_MM_BREAK_COW */
> 	+	memset(&data, 0, sizeof(data));
> 	+
> 	+again_break_cow:
> 
> If we rely on "copy_ret == COPY_MM_BREAK_COW" we can unify "again" and
> "again_break_cow", we don't need to clear ->cow_new_page, this makes the
> logic more understandable. To me at least ;)

I see your point.  I'll definitely try it out.  I think I'll at least use what
you preferred above since it's actually the same as before, logically.  Then
I'll consider drop the again_break_cow, as long as I'm still as confident after
I do the change on not leaking anything :).

Thanks,

-- 
Peter Xu

