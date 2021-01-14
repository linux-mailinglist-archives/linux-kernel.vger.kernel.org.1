Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538AC2F5A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbhANFjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 00:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbhANFjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 00:39:43 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BFDC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:39:03 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x126so2695351pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fqBUe+vvN+P9JTqSIfpD9Vhk8w4ny3ImosrA1d+/dmM=;
        b=LMxBi8DP2LCrba0oIh4Uy4Ho5KlSkW5FOHY68DjM/ViMTFkqoAOFNXWggiedoRs399
         nF67pkHEojOqdiG3l3KbBgYp1zP0fLb3hAsrZgIy1MAhLalB2fogYrqpcm+UKMUDQPBT
         SJPnD57avS6VvyLOZrCEChKav/qgIGpp4nqhBhKmvPAl79dRov7nJuSuaqRGubah4r7U
         RJ631A/cQVb3LMkTgryha11FKBUG7UC27NlH6qtEQyc33QjjfL7YxgPhc/RTkyyqZ6Y0
         g2ZKCR9HirMwsBRHhYiMGY8xnVf3X7ueJSpeODBeMrOOHGrNEuBq9b/Zd7bkrD2DUBj/
         wifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fqBUe+vvN+P9JTqSIfpD9Vhk8w4ny3ImosrA1d+/dmM=;
        b=WrBBhpmYm3IWBkjeJeu+YD7kAQvVIv3YiAhTQjytb4lnepHUN/s8xs3H4rU+Pppvyj
         WWGGm2UuRAhlOpQgrQP+oZTLAoSthDuMCcSIgvp6pH5eQtG4u8Enm53f8S6efoBuqNLg
         DM0AuMfbSM+g2pRhCV7rPTTQxCGGBLY88bFxPCOKKFwPyU4NHHbTF4+jetBw4qFzGATT
         YfeQPkG+usJfXk885uyrI4DumJ0qEqsYSNZKU011ZtkWbFY++2EVUjOrdB2rXaEN1mY2
         7cdVSS1Djpq057SmbyYSdUej7+Dghmu0k3ugVZUCuRCTPvWSJ2Eu1AQeEFby1q0KHIoV
         fNTQ==
X-Gm-Message-State: AOAM531BT4oA0eIqhv9/d3O36qeroofT7ZpD5TkcTTDbSXDU6TPGqmcd
        IgBma6lpBgVEowjmQr1/BlVnaBXoxSU=
X-Google-Smtp-Source: ABdhPJx7Li3KBdCk8m6Ln7fdbryg668phWCMEKQ60eLTo31geFbKSRB/8Zk9BYOgKAVreHcy9/VyPw==
X-Received: by 2002:a63:d917:: with SMTP id r23mr5870061pgg.126.1610602742772;
        Wed, 13 Jan 2021 21:39:02 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id c5sm4258372pgt.73.2021.01.13.21.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 21:39:01 -0800 (PST)
Date:   Thu, 14 Jan 2021 14:38:58 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Suleiman Souhlal <suleiman@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: madvise(MADV_REMOVE) deadlocks on shmem THP
Message-ID: <X//Y8iRUfuH8WDg2@jagdpanzerIV.localdomain>
References: <X/+7dkbhNtAVV+wd@google.com>
 <alpine.LSU.2.11.2101132000500.4777@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2101132000500.4777@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/13 20:31), Hugh Dickins wrote:
> > We are running into lockups during the memory pressure tests on our
> > boards, which essentially NMI panic them. In short the test case is
> > 
> > - THP shmem
> >     echo advise > /sys/kernel/mm/transparent_hugepage/shmem_enabled
> > 
> > - And a user-space process doing madvise(MADV_HUGEPAGE) on new mappings,
> >   and madvise(MADV_REMOVE) when it wants to remove the page range
> > 
> > The problem boils down to the reverse locking chain:
> > 	kswapd does
> > 
> > 		lock_page(page) -> down_read(page->mapping->i_mmap_rwsem)
> > 
> > 	madvise() process does
> > 
> > 		down_write(page->mapping->i_mmap_rwsem) -> lock_page(page)
> > 
> > 
> > 
> > CPU0                                                       CPU1
> > 
> > kswapd                                                     vfs_fallocate()
> >  shrink_node()                                              shmem_fallocate()
> >   shrink_active_list()                                       unmap_mapping_range()
> >    page_referenced() << lock page:PG_locked >>                unmap_mapping_pages()  << down_write(mapping->i_mmap_rwsem) >>
> >     rmap_walk_file()                                           zap_page_range_single()
> >      down_read(mapping->i_mmap_rwsem) << W-locked on CPU1>>     unmap_page_range()
> >       rwsem_down_read_failed()                                   __split_huge_pmd()
> >        __rwsem_down_read_failed_common()                          __lock_page()  << PG_locked on CPU0 >>
> >         schedule()                                                 wait_on_page_bit_common()
> >                                                                     io_schedule()
> 
> Very interesting, Sergey: many thanks for this report.

Thanks for the quick feedback.

> There is no doubt that kswapd is right in its lock ordering:
> __split_huge_pmd() is in the wrong to be attempting lock_page().
> 
> Which used not to be done, but was added in 5.8's c444eb564fb1 ("mm:
> thp: make the THP mapcount atomic against __split_huge_pmd_locked()").

Hugh, I forgot to mention, we are facing these issues on 4.19.
Let me check if (maybe) we have cherry picked c444eb564fb1.

	-ss
