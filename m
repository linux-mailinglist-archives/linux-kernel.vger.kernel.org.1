Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC02AE103
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgKJUuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:50:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJUuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:50:12 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8115620665;
        Tue, 10 Nov 2020 20:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605041410;
        bh=3hv5p5qekbgP0DrUGts71/2N8rvEWkFJnELYbEtqoIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AVcBjBebzIYTXj/uoWrEU0i8ej5d9pL2T+Rg5ecvlKcYKd90KhzT1W1mED224VgFh
         DuP4ZLVAb1ldO+WVIpCpUgWlSfBADgW/EjZtkteq/fFGCe9LH4Mcj1VHUOOqz6h9UQ
         evSYM0HEXH7lGv2B2TdXLMhZ0kWQ1AQ8z+USNq/0=
Date:   Tue, 10 Nov 2020 12:50:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
 caches with SLAB_ACCOUNT
Message-Id: <20201110125008.003fb018e74c40109fd6723f@linux-foundation.org>
In-Reply-To: <20201110195753.530157-2-guro@fb.com>
References: <20201110195753.530157-1-guro@fb.com>
        <20201110195753.530157-2-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 11:57:53 -0800 Roman Gushchin <guro@fb.com> wrote:

> In general it's unknown in advance if a slab page will contain
> accounted objects or not. In order to avoid memory waste, an
> obj_cgroup vector is allocated dynamically when a need to account
> of a new object arises. Such approach is memory efficient, but
> requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
> because an allocation can race with a different allocation on another
> cpu.
> 
> But in some common cases it's known for sure that a slab page will
> contain accounted objects: if the page belongs to a slab cache with a
> SLAB_ACCOUNT flag set. It includes such popular objects like
> vm_area_struct, anon_vma, task_struct, etc.
> 
> In such cases we can pre-allocate the objcgs vector and simple assign
> it to the page without any atomic operations, because at this early
> stage the page is not visible to anyone else.

Was there any measurable performance change from this?
