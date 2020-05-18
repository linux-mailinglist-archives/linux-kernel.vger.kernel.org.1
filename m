Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE341D89BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 23:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgERVA5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 May 2020 17:00:57 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:59742 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726250AbgERVA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:00:57 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21235473-1500050 
        for multiple; Mon, 18 May 2020 22:00:53 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200518150336.15265-1-aishwaryarj100@gmail.com>
References: <20200518150336.15265-1-aishwaryarj100@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     aishwaryarj100@gmail.com
To:     Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Use ARRAY_SIZE for vgpu_types
Message-ID: <158983565244.7442.10004490488930800145@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Mon, 18 May 2020 22:00:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aishwarya Ramakrishnan (2020-05-18 16:03:36)
> Prefer ARRAY_SIZE instead of using sizeof
> 
> Fixes coccicheck warning: Use ARRAY_SIZE
> 
> Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
