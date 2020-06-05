Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B083C1EFBA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 16:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgFEOlF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Jun 2020 10:41:05 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63184 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727113AbgFEOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:41:04 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21408010-1500050 
        for multiple; Fri, 05 Jun 2020 15:40:48 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <202006050718.9D4FCFC2E@keescook>
References: <202006050718.9D4FCFC2E@keescook>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Joe Perches <joe@perches.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix comments mentioning typo in IS_ENABLED()
Message-ID: <159136804617.22562.13050948656630993484@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Fri, 05 Jun 2020 15:40:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kees Cook (2020-06-05 15:19:53)
> This has no code changes, but the typo is clearly getting copy/pasted,
> so better to avoid this now and fix the typo. IS_ENABLED() takes full
> names, and must have the "CONFIG_" prefix.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Link: https://lore.kernel.org/lkml/b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
