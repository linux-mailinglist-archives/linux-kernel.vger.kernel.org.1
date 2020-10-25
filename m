Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36421298208
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 15:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416504AbgJYORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 10:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733290AbgJYORM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 10:17:12 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CD422226;
        Sun, 25 Oct 2020 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603635431;
        bh=CoHyOzDXRIyiI8+Y6QIv52+Qp9AQ46O3BTgdQ1ZDXxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nryzDadHK6eET9ANsik9TzVfAC9A0ShBYEgfmKa8JGuLUZ/cy2wfrc34n8Ga/f2AH
         yjKpaRiwL9lUuhYQNq1r5UjAIC4knRz6S4MvU1HHEn53/Yd1qX6zpCcO50RWKADBTh
         VKex//kiVso1nBAVdI+CHCzeaE8N6BJYxwyFpi78=
Date:   Sun, 25 Oct 2020 16:17:04 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 1/7] mm, page_alloc: clean up pageset high and batch
 update
Message-ID: <20201025141704.GG392079@kernel.org>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008114201.18824-2-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 01:41:55PM +0200, Vlastimil Babka wrote:
> The updates to pcplists' high and batch valued are handled by multiple

Nit:                                     ^ values

> functions that make the calculations hard to follow. Consolidate everything
> to pageset_set_high_and_batch() and remove pageset_set_batch() and
> pageset_set_high() wrappers.
> 
> The only special case using one of the removed wrappers was:
> build_all_zonelists_init()
>   setup_pageset()
>     pageset_set_batch()
> which was hardcoding batch as 0, so we can just open-code a call to
> pageset_update() with constant parameters instead.
> 
> No functional change.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 49 ++++++++++++++++++++-----------------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
 
--
Sincerely yours,
Mike.
