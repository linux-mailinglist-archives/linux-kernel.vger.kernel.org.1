Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE3300077
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbhAVKgw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Jan 2021 05:36:52 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:50469 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727372AbhAVJba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:31:30 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23668503-1500050 
        for multiple; Fri, 22 Jan 2021 09:29:33 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210122015640.16002-1-bianpan2016@163.com>
References: <20210122015640.16002-1-bianpan2016@163.com>
Subject: Re: [PATCH] drm/i915/selftest: Fix potential memory leak
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
To:     Andi Shyti <andi.shyti@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Pan Bian <bianpan2016@163.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Fri, 22 Jan 2021 09:29:32 +0000
Message-ID: <161130777297.28599.8771475730453120887@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pan Bian (2021-01-22 01:56:40)
> Object out is not released on path that no VMA instance found. The root
> cause is jumping to an unexpected label on the error path.

Wouldn't the root cause be whatever caused the allocation to fail?

Language notwithstanding,
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
