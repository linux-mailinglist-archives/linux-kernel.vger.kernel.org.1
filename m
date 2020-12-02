Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7562CC9E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbgLBWrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgLBWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:47:12 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E60C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 14:46:32 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id o144so204016ybg.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 14:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IIxg209gF2HmcDmIfCti2CITWbBgmANl1tS9JOtM/5U=;
        b=VkArJcQmdYMjQ8w3gfZvfQV2YDqYCUOQ6rSxk8sYJyCOzSEGIQcmJYJYZZsg5D16Vn
         1RzCtdAHzW9rosgW8WjR6xj+ftciNDTW19uQ4YRjsdNJGA2oOYJs0cLzmRV9x6oOY/zC
         uX1qxqvcWYOObGSQpys2tcnkz37ZfoLOf9fiZv3ZnIqs5m4Ezh1iwySB7R1dTkgWhO4e
         GAH1rQeXltcPRouIyvZeUIivIBT7FSWlSGLDiB6u5b2ppQmLtMQNSQSLX4/ygpT91b9n
         9Fey05ody2M67J/QPge1AuoZqXHJqQ4Kf3262Nyn98dok3qY7iQ2sco3GOky4Nl3Y9HI
         WOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IIxg209gF2HmcDmIfCti2CITWbBgmANl1tS9JOtM/5U=;
        b=r9eAdCDxlTNAR4D58oyvNIyUO1z58Bur1FBfc9DxMlAoAfaaQPas1aulOOVaFa/Vvf
         t+ZRoCm5a7w3rLxwMoBCQuOA0F0uW6Mwi5AA+DeTb5HtNtoKorawYKCxlmkWLz3jHXWd
         SKcBDwbqzE+MeMYTCI62fBvZjYV4QEG9IL2ulPa50f/zFb54hYjQwgWcBf0CqcQdUknj
         Te6/zg9nLblUGhZm9NG2RlbtoPphKAVRBvvsUP8jKciMBfRY9kMfZRJqWqsNAApzrDWv
         D46HswzA8f5n77ltn3Wl/hwyPDg6EsgfJk9jI8vpizqZbCrwvV/dTBgE6s6fT0BbXUGq
         SHdw==
X-Gm-Message-State: AOAM531Zs54DaWKKk6PQlI457yYZYyhslBZwsH7g6UNChtBNpzMof6UW
        K9qdqfiJCcjY+iHmuyY2QUF+iz59tJ6c9g==
X-Google-Smtp-Source: ABdhPJzxJf6nNp8vI4/lnSI0sb8Bwwx6yGSy2pISFbJlqBPxUjzyR0jvVIlPwpD+yP2+rJZ1SjVy9Q==
X-Received: by 2002:a9d:68c3:: with SMTP id i3mr64477oto.31.1606948668257;
        Wed, 02 Dec 2020 14:37:48 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e8sm33488oti.76.2020.12.02.14.37.47
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2020 14:37:47 -0800 (PST)
Date:   Wed, 2 Dec 2020 14:37:33 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
In-Reply-To: <X8bZk3jTGU8QyJWc@redhat.com>
Message-ID: <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
References: <20201130230603.46187-1-peterx@redhat.com> <20201201125927.GB11935@casper.infradead.org> <20201201223033.GG3277@xz-x1> <X8bZk3jTGU8QyJWc@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020, Andrea Arcangeli wrote:
> 
> Any suggestions on how to have the per-vaddr per-mm _PAGE_UFFD_WP bit
> survive the pte invalidates in a way that remains associated to a
> certain vaddr in a single mm (so it can shoot itself in the foot if it
> wants, but it can't interfere with all other mm sharing the shmem
> file) would be welcome...

I think it has to be a new variety of swap-like non_swap_entry() pte,
see include/linux/swapops.h.  Anything else would be more troublesome.

Search for non_swap_entry and for migration_entry, to find places that 
might need to learn about this new variety.

IIUC you only need a single value, no need to carve out another whole
swp_type: could probably be swp_offset 0 of any swp_type other than 0.

Note that fork's copy_page_range() does not "copy ptes where a page
fault will fill them correctly", so would in effect put a pte_none
into the child where the parent has this uffd_wp entry.  I don't know
anything about uffd versus fork, whether that would pose a problem.

Hugh
