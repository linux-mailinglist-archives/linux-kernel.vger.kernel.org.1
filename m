Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB22E2C7BA5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 23:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgK2WNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 17:13:45 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41500 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2WNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 17:13:45 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 0B7E620031;
        Sun, 29 Nov 2020 23:12:58 +0100 (CET)
Date:   Sun, 29 Nov 2020 23:12:56 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>, robdclark@chromium.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 4/5] drm: panel: simple: Add BOE NV110WTM-N61
Message-ID: <20201129221256.GK1162850@ravnborg.org>
References: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
 <20201109170018.v4.4.I71b2118dfc00fd7b43b02d28e7b890081c2acfa2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109170018.v4.4.I71b2118dfc00fd7b43b02d28e7b890081c2acfa2@changeid>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8 a=4xseQxl7JwUluFqpXLkA:9
        a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On Mon, Nov 09, 2020 at 05:00:58PM -0800, Douglas Anderson wrote:
> Add support for the BOE NV110WTM-N61 panel.  The EDID lists two modes
> (one for 60 Hz refresh rate and one for 40 Hz), so we'll list both of
> them here.
> 
> Note that the panel datasheet requires 80 ms between HPD asserting and
> the backlight power being turned on.  We'll use the new timing
> constraints structure to do this cleanly.  This assumes that the
> backlight will be enabled _after_ the panel enable finishes.  This is
> how it works today and seems a sane assumption.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I applied the binding patch (bindings before driver patch),
and added the missing flags while applying this patch.
All to drm-misc-next.

	Sam
