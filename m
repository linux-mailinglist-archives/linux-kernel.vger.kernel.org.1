Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28422220831
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 11:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgGOJH0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Jul 2020 05:07:26 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:55118 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725912AbgGOJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:07:26 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21823895-1500050 
        for multiple; Wed, 15 Jul 2020 10:06:56 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200715032104.32052-1-yuehaibing@huawei.com>
References: <20200715032104.32052-1-yuehaibing@huawei.com>
Subject: Re: [Intel-gfx] [PATCH -next] drm/i915: Remove unused inline function drain_delayed_work()
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
To:     YueHaibing <yuehaibing@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Date:   Wed, 15 Jul 2020 10:06:54 +0100
Message-ID: <159480401488.3188.7146761465651932968@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2020-07-15 04:21:04)
> It is not used since commit 058179e72e09 ("drm/i915/gt: Replace
> hangcheck by heartbeats")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Indeed, it is no more.
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
