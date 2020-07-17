Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0623B224444
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 21:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgGQTdK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jul 2020 15:33:10 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:59248 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727999AbgGQTdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:33:10 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21854107-1500050 
        for multiple; Fri, 17 Jul 2020 20:32:44 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200717141138.4a4289ac@xhacker.debian>
References: <20200717141138.4a4289ac@xhacker.debian>
Subject: Re: [PATCH] drm/i915: Don't force IOSF_MBI
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Fri, 17 Jul 2020 20:32:44 +0100
Message-ID: <159501436493.15672.10863611355648667796@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jisheng Zhang (2020-07-17 07:11:38)
> The i915 doesn't depend on IOSF_MBI, asm/iosf_mbi.h already defines
> isof_mbi_* APIs when ISOF_MBI is disabled.
> 
> Don't force IOSF_MBI to allow disabling IOSF_MBI for non SoC platforms.

But it is required for Valleyview/Cherryview and we want to support
those by default. Tricky.
-Chris
