Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132B026B12E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgIOW0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:26:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42551 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727550AbgIOQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600186862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GfwuuWWzGYHhzmOr9zWk/h6mAKg0sY0tXHg31ZT1k8E=;
        b=cXUnQ+HRVUKb77v4Qww3cvk3lW4YnjluSQ7RTf6dIVIRyhrBX/fVmcZVTSwB2zOajpUDPb
        A4dULSyiq+eNqwNnmzhbtwvOaMjMUvVVy9DLrwb0TWG50tf+WP4fMrUau3nI8db5wLq8TZ
        wybX+sYg4pK9zWI2ZVJgf/rE1uj9Eh8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-zz05hMA8MQ-fM1QL7GojgQ-1; Tue, 15 Sep 2020 12:18:17 -0400
X-MC-Unique: zz05hMA8MQ-fM1QL7GojgQ-1
Received: by mail-qk1-f198.google.com with SMTP id m203so3225973qke.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GfwuuWWzGYHhzmOr9zWk/h6mAKg0sY0tXHg31ZT1k8E=;
        b=QU9hzSD0mohPzzqdnJRxB/bt4zIOB99MhMjHu5vU6s8XpjYoYtZ7nxLpSZsa03DtB5
         pb/vX78y1iJhdFqAV2WKaZIKYuq6GYU3lwbkfTMTNPsI2ydUrP5QhHPh+VPMM+5+dIAR
         HQ5dg8EOBmIBdtlf3sG+0/Iiq2wkPazYtAuQFyVY+idfNoVSxUk624UJDsxawYrghShD
         zc3lOdNDmMf2MbnOIaxoIb0xK6VR6Q/zS+hq7mX9+bRF2WiUZGA4vo5evhtmGmpGAv+m
         VWiYYyTdp/tD2l2mgG5WtcKYmvjil0D6wdHvDQZZspTcIVSWLvuVGnPO/LqptJYvwBdS
         yQsQ==
X-Gm-Message-State: AOAM5322wCUIoj8HVpANtQZf5TUGgOj5hf77pVS2dp0/378T+eV6uQlR
        eloejhK8caCYfpM5Vn8c53w8eGL0IgoyxbXQ3sMSi0BoHY/evyEsBMlzDl1f5KEb395wSVeLL9z
        HzjWAquP3aEzTOr6j/i++Hn1f
X-Received: by 2002:a37:64d4:: with SMTP id y203mr18363458qkb.359.1600186697195;
        Tue, 15 Sep 2020 09:18:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLVW8kuvMeh2di7XK6DC3uhyQVMeMlC0qltufBS9xG4VLH4xrOs73HZvyOAteqZrQAnOU8WA==
X-Received: by 2002:a37:64d4:: with SMTP id y203mr18363431qkb.359.1600186696948;
        Tue, 15 Sep 2020 09:18:16 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id u46sm16483548qth.31.2020.09.15.09.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:18:15 -0700 (PDT)
Date:   Tue, 15 Sep 2020 12:18:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200915161814.GC2949@xz-x1>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <20200915150349.GA22415@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915150349.GA22415@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 05:03:49PM +0200, Oleg Nesterov wrote:
> > -		if (reuse_swap_page(vmf->page, &total_map_swapcount)) {
> 
> It seems that nobody else calls reuse_swap_page() with total_map_swapcount != NULL.

Seems correct.  Though maybe we could postpone the cleanup later, until the
fallouts of the cow rework settle (just in case we'd like to bring some
mapcount logic back).  Thanks,

-- 
Peter Xu

