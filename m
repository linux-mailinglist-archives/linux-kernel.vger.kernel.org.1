Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2877430253F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbhAYNBJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jan 2021 08:01:09 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:58697 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728453AbhAYMxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:53:35 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23692793-1500050 
        for multiple; Mon, 25 Jan 2021 12:34:39 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210125122542.4144849-1-arnd@kernel.org>
References: <20210125122542.4144849-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/i915/gem: fix non-SMP build failure
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Mon, 25 Jan 2021 12:34:40 +0000
Message-ID: <161157808017.27462.17791510835963619576@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2021-01-25 12:25:34)
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The x86-specific wbinvd_on_all_cpus() function is exported
> through asm/smp.h, causing a build failure in the i915 driver
> when SMP is disabled:
> 
> drivers/gpu/drm/i915/i915_gem.c:1182:2: error: implicit declaration of function 'wbinvd_on_all_cpus' [-Werror,-Wimplicit-function-declaration]

I thought the code was already in i915_gem_pm.c (which included smp.h);
it is now.
-Chris
