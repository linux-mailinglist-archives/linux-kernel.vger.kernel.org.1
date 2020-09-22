Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7472745FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgIVQDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgIVQDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600790615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kwkIumcqGzjBzZptTpViZugyJRhZCaJYwosFjtUl6TY=;
        b=PAjAPRFS6xfZOrN3LWYAANivPFyJWMaaMReCYYtCvMhNqnAmk5WzRwM7Q32BaiFmoJeX7Z
        EDLTdQeo5Lw+gjbwHJM9AwSb8SYWER4fNgamuG0dIh7wCD65vBkSuyyM80SwJHYGWabbs5
        qx0kCe0/3zeFL8JOaYC7VYfpc3AnafI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-vBKY0oqwOGCpPCzxybHfFg-1; Tue, 22 Sep 2020 12:03:34 -0400
X-MC-Unique: vBKY0oqwOGCpPCzxybHfFg-1
Received: by mail-qv1-f69.google.com with SMTP id dj20so12214367qvb.23
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kwkIumcqGzjBzZptTpViZugyJRhZCaJYwosFjtUl6TY=;
        b=rGQNpeEGI6c9g7gfjTyPqWU9zQSmxVqANbl57TchkhgvSMdTNqaXHh5hzOpRn3Fr1I
         ZrfwquyozvbBI2jB7IcP3iMO9eXPJQ5yqiPgcrqdfS3nu0SSMNmGy1EMSMh/ONAneANz
         IFdoCKn2S7iOG25FGM0PzdzIDnJgVKJoVGY55EADBNWTZAMCZMm5h7mKcLX8zGiz+h25
         36DA/cKmEsQL0Gp4NLxk90KRkKAJcffylog0JA7m0HkVdjKlJBec4mWfbEz11om2HRxX
         +kalhdvTHX5kBoo6wMMHFF25Asy2LXE58R2T7n31se4Zmghlr0rMfxVukmGRdgI1sgFb
         1JBA==
X-Gm-Message-State: AOAM532QMCFmMWfXPOh3jwPa26Hmr/tNnJpzDToJXVg9OLpjqrP563MS
        dThhYsGJfBzUhzZ8IcGsHznHbXdBrHEbK8zD6dn7aNDTy9AkWPph5mf4LKn5UhmkbpmMzZXTflF
        6R63s/3v+3y4qCRYBt5N3nrcH
X-Received: by 2002:a05:620a:4d9:: with SMTP id 25mr656039qks.285.1600790613610;
        Tue, 22 Sep 2020 09:03:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2WBpmEkrnIE7L5wh6n1brq8SIFLzkrPhF79h+d4jS9KuED2W2JmtaudJI0E5w+F+buxkp2w==
X-Received: by 2002:a05:620a:4d9:: with SMTP id 25mr656011qks.285.1600790613347;
        Tue, 22 Sep 2020 09:03:33 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id s20sm11692461qkg.65.2020.09.22.09.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 09:03:32 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:03:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 3/5] mm: Rework return value for copy_one_pte()
Message-ID: <20200922160330.GH19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-4-peterx@redhat.com>
 <20200922100840.GA11679@redhat.com>
 <20200922101815.GB11679@redhat.com>
 <20200922153612.GF19098@xz-x1>
 <20200922154845.GE11679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922154845.GE11679@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 05:48:46PM +0200, Oleg Nesterov wrote:
> > However since I didn't change this logic in this patch, it probably means this
> > bug is also in the original code before this series...  I'm thinking maybe I
> > should prepare a standalone patch to clear the swp_entry_t and cc stable.
> 
> Well, if copy_one_pte(src_pte) hits a swap entry and returns entry.val != 0, then
> pte_none(*src_pte) is not possible after restart? This means that copy_one_pte()
> will be called at least once.

Note that we've released the page table locks, so afaict the old swp entry can
be gone under us when we go back to the "do" loop... :) Extremely corner case,
but maybe still good to fix, extra clearness as a (good) side effect.

-- 
Peter Xu

