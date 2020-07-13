Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4260821D967
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgGMPDX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Jul 2020 11:03:23 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:62706 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729593AbgGMPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:03:23 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2020 11:03:22 EDT
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21804978-1500050 
        for multiple; Mon, 13 Jul 2020 15:46:35 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200713142551.423649-1-colin.king@canonical.com>
References: <20200713142551.423649-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] drm/i915/selftest: fix an error return path where err is not being set
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Colin King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Date:   Mon, 13 Jul 2020 15:46:35 +0100
Message-ID: <159465159599.23097.17150763550392763778@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2020-07-13 15:25:51)
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an error condition where err is not being set and an uninitialized
> garbage value in err is being returned.  Fix this by assigning err to an
> appropriate error return value before taking the error exit path.
> 
> Addresses-Coverity: ("Uninitialized scalar value")
> Fixes: ed2690a9ca89 ("drm/i915/selftest: Check that GPR are restored across noa_wait")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, pushed.
-Chris
