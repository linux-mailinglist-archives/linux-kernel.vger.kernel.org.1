Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217472F32DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbhALOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:24:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:57818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbhALOY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:24:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610461420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xq1aHA8mbrEMaD5Ve0Fl96EfFqk/5ogr68Z+fQaO8D0=;
        b=rUyrJvvcNbludVlUMXKtBj3FaVcKKFoarrUICH/TobbkfNZkK39iW75Q5mw6kJSYFlMv4C
        +y7k9AL7Bkw4C24ytYRjCo3wyfRfly53q4h6kkVvkpGMxSlAXrcVjXCX03QFH04c/Idxyc
        GaJB/Xwnvn1U5zgx6D/kdpigldIaG28=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55864ABD6;
        Tue, 12 Jan 2021 14:23:40 +0000 (UTC)
Date:   Tue, 12 Jan 2021 15:23:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
Message-ID: <20210112142337.GR22493@dhcp22.suse.cz>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com>
 <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
 <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com>
 <20210112112709.GO22493@dhcp22.suse.cz>
 <d00da0ca-8a2b-f144-b455-2887fd269ed7@redhat.com>
 <20210112121643.GP22493@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112121643.GP22493@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-01-21 13:16:45, Michal Hocko wrote:
[...]
> Well, currently pool pages are not migrateable but you are right that
> this is likely something that we will need to look into in the future
> and this optimization would stand in the way.

After some more thinking I believe I was wrong in my last statement.
This optimization shouldn't have any effect on pages on the pool as
those stay at reference count 0 and they cannot be isolated either
(clear_page_huge_active before it is enqueued).

That being said, the migration code would still have to learn about
about this pages but that is out of scope of this discussion.

Sorry about the confusion from my side.
-- 
Michal Hocko
SUSE Labs
