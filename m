Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4729109D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437560AbgJQH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:59:34 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:46892 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437553AbgJQH7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:59:34 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 35A6580608;
        Sat, 17 Oct 2020 09:59:31 +0200 (CEST)
Date:   Sat, 17 Oct 2020 09:59:29 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/mcde: Fix handling of platform_get_irq() error
Message-ID: <20201017075929.GA2568873@ravnborg.org>
References: <20200827071107.27429-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827071107.27429-1-krzk@kernel.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=OmeMd-_iD0Inhxqqi-8A:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Thu, Aug 27, 2020 at 09:11:06AM +0200, Krzysztof Kozlowski wrote:
> platform_get_irq() returns -ERRNO on error.  In such case comparison
> to 0 would pass the check.
> 
> Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, applied this and the tve200 patch to drm-misc-next.
They will appear in -next in a few weeks time.

	Sam
