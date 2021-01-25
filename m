Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE05303641
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbhAZGH3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jan 2021 01:07:29 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:58676 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728430AbhAYMwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:52:12 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23692780-1500050 
        for multiple; Mon, 25 Jan 2021 12:33:19 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210125122650.4178417-1-arnd@kernel.org>
References: <20210125122650.4178417-1-arnd@kernel.org>
Subject: Re: [PATCH] i915: Fix DRM_I915_WERROR dependencies
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Mon, 25 Jan 2021 12:33:20 +0000
Message-ID: <161157800073.27462.7610644354455990065@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2021-01-25 12:26:44)
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_DRM_I915_DEBUG now selects CONFIG_DRM_I915_WERROR, but fails
> to honor its dependencies:
> 
> WARNING: unmet direct dependencies detected for DRM_I915_WERROR
>   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=m] && EXPERT [=y] && !COMPILE_TEST [=y]
>   Selected by [m]:
>   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && EXPERT [=y] && DRM_I915 [=m]

DRM_I915_DEBUG now depends on !COMPILE_TEST and EXPERT.
-Chris
