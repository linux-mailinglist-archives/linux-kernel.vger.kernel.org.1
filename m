Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D13041F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406201AbhAZPOS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jan 2021 10:14:18 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:63629 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406146AbhAZPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:13:47 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23704930-1500050 
        for multiple; Tue, 26 Jan 2021 15:12:54 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210126150155.1617-1-kernel@esmil.dk>
References: <20210126150155.1617-1-kernel@esmil.dk>
Subject: Re: [PATCH v2] drm/i915/gt: use new tasklet API for execution list
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>,
        intel-gfx@lists.freedesktop.org
Date:   Tue, 26 Jan 2021 15:12:56 +0000
Message-ID: <161167397638.2943.18167940013400200979@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2021-01-26 15:01:55)
> This converts the driver to use the new tasklet API introduced in
> commit 12cc923f1ccc ("tasklet: Introduce new initialization API")
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> 
> ---
> v2: Rebased on drm-intel-next

Ta. Saves me having to do the fixup.

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Will be applied to drm-intel-gt-next which is scheduled for inclusion in
5.13. It should apply against the 5.12 merge window if there's a tree
through which you want to migrate the tasklet API faster.
-Chris
