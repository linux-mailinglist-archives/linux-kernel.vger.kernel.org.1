Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534161DF66E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 11:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgEWJll convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 23 May 2020 05:41:41 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57880 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725268AbgEWJll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 05:41:41 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21269533-1500050 
        for multiple; Sat, 23 May 2020 10:41:25 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200522051931.54191-1-jhubbard@nvidia.com>
References: <20200522051931.54191-1-jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 0/4] mm/gup, drm/i915: refactor gup_fast, convert to pin_user_pages()
Message-ID: <159022688563.11139.3402294435382936623@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Sat, 23 May 2020 10:41:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting John Hubbard (2020-05-22 06:19:27)
> The purpose of posting this series is to launch a test in the
> intel-gfx-ci tree. (The patches have already been merged into Andrew's
> linux-mm tree.)
> 
> This applies to today's linux.git (note the base-commit tag at the
> bottom).
> 
> Changes since V1:
> 
> * Fixed a bug in the refactoring patch: added FOLL_FAST_ONLY to the
>   list of gup_flags *not* to WARN() on. This lead to a failure in the
>   first intel-gfx-ci test run [1].
> 
> [1] https://lore.kernel.org/r/159008745422.32320.5724805750977048669@build.alporthouse.com

Ran this through our CI, warn and subsequent lockup were gone. That
lockup is worrying me now, but that doesn't seem to be an issue from
this series.

The i915 changes were simple enough, I would have computed the pin flags
just once (since the readonly bit is static, that would be interesting
if that was allowed to change mid gup :)
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
