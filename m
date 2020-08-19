Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B524A6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 21:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgHSThQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 15:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHSThO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:37:14 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283BB207BB;
        Wed, 19 Aug 2020 19:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597865834;
        bh=FSqnN4eyzzekQI8QmT0uMExpMLfdw+JltxvAtUnqXgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sXBor1SafBP+oLCCppMCOKcFNPi3DJMASjl+uB1WLxVq7KRGp76oq08t+OSFzxmRZ
         jsIWryqeU+FGIDsYM0RVCrFLjT1KDQQhW54jBxl6Mq84LAYaouHYxHkS/veJJyMB66
         0y74lEiqQ5QQOMPfIVEk8XRQBbGyjn9dmAo8JLoY=
Date:   Wed, 19 Aug 2020 12:37:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <wuyun.wu@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <liu.xiang6@zte.com.cn>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/slub: make add_full() condition more explicit
Message-Id: <20200819123713.38a2509a2b7651f14db33e61@linux-foundation.org>
In-Reply-To: <20200811020240.1231-1-wuyun.wu@huawei.com>
References: <20200811020240.1231-1-wuyun.wu@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 10:02:36 +0800 <wuyun.wu@huawei.com> wrote:

> From: Abel Wu <wuyun.wu@huawei.com>
> 
> The commit below is incomplete, as it didn't handle the add_full() part.
> commit a4d3f8916c65 ("slub: remove useless kmem_cache_debug() before remove_full()")
> 
> This patch checks for SLAB_STORE_USER instead of kmem_cache_debug(),
> since that should be the only context in which we need the list_lock for
> add_full().
> 

Does this contradict what the comment tells us?

* This also ensures that the scanning of full
* slabs from diagnostic functions will not see
* any frozen slabs.


