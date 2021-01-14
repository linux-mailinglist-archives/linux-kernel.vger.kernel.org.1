Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21F12F5F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbhANLNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbhANLNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:13:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8C4E238A1;
        Thu, 14 Jan 2021 11:13:08 +0000 (UTC)
Date:   Thu, 14 Jan 2021 11:13:06 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] mm/slub: disable user tracing for kmemleak caches by
 default
Message-ID: <20210114111305.GA16561@gaia>
References: <20210113215114.d94efa13ba30.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113215114.d94efa13ba30.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:51:14PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If kmemleak is enabled, it uses a kmem cache for its own objects.
> These objects are used to hold information kmemleak uses, including
> a stack trace. If slub_debug is also turned on, each of them has
> *another* stack trace, so the overhead adds up, and on my tests (on
> ARCH=um, admittedly) 2/3rds of the allocations end up being doing
> the stack tracing.
> 
> Turn off SLAB_STORE_USER if SLAB_NOLEAKTRACE was given, to avoid
> storing the essentially same data twice.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

I think that's the simplest.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

> Perhaps instead it should go the other way around, and kmemleak
> could even use/access the stack trace that's already in there ...
> But I don't really care too much, I can just turn off slub debug
> for the kmemleak caches via the command line anyway :-)

This stack trace doesn't seem to be accessible in a unified way across
the sl*b allocators. Given that kmemleak already needs to track this
information for other objects (vmalloc, certain page allocations), it's
probably more hassle to handle it differently for slab objects (I don't
say it's impossible, just not sure it's worth).

-- 
Catalin
