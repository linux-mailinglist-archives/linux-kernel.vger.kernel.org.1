Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2DB2E8C7E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 15:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbhACODU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 3 Jan 2021 09:03:20 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:51564 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbhACODT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 09:03:19 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23489600-1500050 
        for multiple; Sun, 03 Jan 2021 14:01:59 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210103135158.3591442-1-arnd@kernel.org>
References: <20210103135158.3591442-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] i915: fix shift warning
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Sun, 03 Jan 2021 14:01:59 +0000
Message-ID: <160968251911.30283.15581575287166640028@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2021-01-03 13:51:44)
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Randconfig builds on 32-bit machines show lots of warnings for
> the i915 driver for passing a 32-bit value into __const_hweight64():
> 
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2584:9: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>         return hweight64(VDBOX_MASK(&i915->gt));
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from macro 'hweight64'
>  #define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) : __arch_hweight64(w))
> 
> Change it to hweight_long() to avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by:: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
