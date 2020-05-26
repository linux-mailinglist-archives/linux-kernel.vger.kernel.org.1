Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3F01B5106
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 01:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDVXwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 19:52:14 -0400
Received: from gentwo.org ([3.19.106.255]:35098 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgDVXwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:52:14 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id B131B3EC02; Wed, 22 Apr 2020 23:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id B04793EBBA;
        Wed, 22 Apr 2020 23:52:13 +0000 (UTC)
Date:   Wed, 22 Apr 2020 23:52:13 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
In-Reply-To: <20200422204708.2176080-5-guro@fb.com>
Message-ID: <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
References: <20200422204708.2176080-1-guro@fb.com> <20200422204708.2176080-5-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020, Roman Gushchin wrote:

>  enum stat_item {
>  	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> @@ -86,6 +87,7 @@ struct kmem_cache {
>  	unsigned long min_partial;
>  	unsigned int size;	/* The size of an object including metadata */
>  	unsigned int object_size;/* The size of an object without metadata */
> +	struct reciprocal_value reciprocal_size;


This needs to be moved further back since it is not an item that needs to
be cache hot for the hotpaths. Place it with "align", inuse etc?

Hmmm. the same applies to min_partial maybe?

