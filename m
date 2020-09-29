Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8F27BC30
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 06:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgI2Eu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 00:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgI2Eu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 00:50:56 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B8C207F7;
        Tue, 29 Sep 2020 04:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601355055;
        bh=gV6QEyJxDl+g2byKjvydjtaPQ921rhOyIz0suE2c25k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sCMA5ZZQOAmaVjdHqeK6yhK/tgd6/OZ8p6xiO3FXaqhHXXKFSBJUraJtmLw/h+1+v
         7NVLZpHwdpdZYTVxbEKvNdW90Ro0uzGbqllUrO9gmksEhAkYZAAYN9ry4SYwcwhjI/
         tM1udPnGxoN0EfCCBV7EWtxiCfMrjeVecHwxRmdk=
Date:   Mon, 28 Sep 2020 21:50:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
Message-Id: <20200928215055.02ff9b3ff5e0c392b2403411@linux-foundation.org>
In-Reply-To: <CAAmzW4OY7z+bF=aFOsNuadc8M_f1Pb7jifuxzQo5AL6mCuO5Ng@mail.gmail.com>
References: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com>
        <20200928165215.f46924bfff9a109131048f81@linux-foundation.org>
        <CAAmzW4OY7z+bF=aFOsNuadc8M_f1Pb7jifuxzQo5AL6mCuO5Ng@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 10:28:05 +0900 Joonsoo Kim <js1304@gmail.com> wrote:

> > What about manually emptying the pcplists beforehand?
> 
> It also increases the probability. schedule() or interrupt after emptying but
> before the allocation could invalidate the effect.

Keep local interrupts disabled across the pcp drain and the allocation
attempt.

> > Or byassing the pcplists for this caller and calling __rmqueue() directly?
> 
> What this patch does is this one.

I meant via a different function rather than by adding overhead to the
existing commonly-used function.

