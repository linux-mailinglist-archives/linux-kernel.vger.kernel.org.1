Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969D32DB368
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbgLOSOP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Dec 2020 13:14:15 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:60675 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729759AbgLOSOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:14:10 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23336117-1500050 
        for multiple; Tue, 15 Dec 2020 18:13:09 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201215144101.1878719-1-trix@redhat.com>
References: <20201215144101.1878719-1-trix@redhat.com>
Subject: Re: [PATCH] drm/i915: remove h from printk format specifier
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, daniele.ceraolospurio@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        lionel.g.landwerlin@intel.com, rodrigo.vivi@intel.com,
        tejaskumarx.surendrakumar.upadhyay@intel.com, trix@redhat.com,
        tvrtko.ursulin@intel.com, venkata.s.dhanalakota@intel.com
Date:   Tue, 15 Dec 2020 18:13:10 +0000
Message-ID: <160805599050.14591.5854311082825914383@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting trix@redhat.com (2020-12-15 14:41:01)
> From: Tom Rix <trix@redhat.com>
> 
> See Documentation/core-api/printk-formats.rst.
> h should no longer be used in the format specifier for printk.

It's understood by format_decode().
* 'h', 'l', or 'L' for integer fields

At least reference commit cbacb5ab0aa0 ("docs: printk-formats: Stop
encouraging use of unnecessary %h[xudi] and %hh[xudi]") as to why the
printk-formats.rst was altered so we know the code is merely in bad
taste and not using undefined behaviour of printk.
-Chris
