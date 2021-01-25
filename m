Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A076302365
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbhAYJwD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jan 2021 04:52:03 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:53696 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727114AbhAYJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:46:53 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23690693-1500050 
        for multiple; Mon, 25 Jan 2021 09:44:52 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <YA6F3oF8mRaNQWjb@mwanda>
References: <YA6F3oF8mRaNQWjb@mwanda>
Subject: Re: [PATCH] drm/i915/gvt: fix uninitialized return in intel_gvt_update_reg_whitelist()
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Yan Zhao <yan.y.zhao@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Zhi Wang <zhi.a.wang@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Date:   Mon, 25 Jan 2021 09:44:53 +0000
Message-ID: <161156789392.31416.7341729779003502151@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dan Carpenter (2021-01-25 08:48:30)
> Smatch found an uninitialized variable bug in this code:
> 
>     drivers/gpu/drm/i915/gvt/cmd_parser.c:3191 intel_gvt_update_reg_whitelist()
>     error: uninitialized symbol 'ret'.
> 
> The first thing that Smatch complains about is that "ret" isn't set if
> we don't enter the "for_each_engine(engine, &dev_priv->gt, id) {" loop.
> Presumably we always have at least one engine so that's a false
> positive.
> 
> But it's definitely a bug to not set "ret" if i915_gem_object_pin_map()
> fails.

True.
 
> Let's fix the bug and silence the false positive.
> 
> Fixes: 493f30cd086e ("drm/i915/gvt: parse init context to update cmd accessible reg whitelist")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
