Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ED32C7BA0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 23:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgK2WMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 17:12:21 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41348 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2WMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 17:12:21 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 0A07F20034;
        Sun, 29 Nov 2020 23:11:34 +0100 (CET)
Date:   Sun, 29 Nov 2020 23:11:32 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>, robdclark@chromium.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/5] drm: panel: simple: Defer unprepare delay till
 next prepare to shorten it
Message-ID: <20201129221132.GI1162850@ravnborg.org>
References: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
 <20201109170018.v4.2.I06a95d83e7fa1bd919c8edd63dacacb5436e495a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109170018.v4.2.I06a95d83e7fa1bd919c8edd63dacacb5436e495a@changeid>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8 a=1W7J8uJR8bNfhs70qOMA:9
        a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,
On Mon, Nov 09, 2020 at 05:00:56PM -0800, Douglas Anderson wrote:
> It is believed that all of the current users of the "unprepare" delay
> don't actually need to wait the amount of time specified directly in
> the unprepare phase.  The purpose of the delay that's specified is to
> allow the panel to fully power off so that we don't try to power it
> back on before it's managed to full power down.
> 
> Let's use this observation to avoid the fixed delay that we currently
> have.  Instead of delaying, we'll note the current time when the
> unprepare happens.  If someone then tries to prepare the panel later
> and not enough time has passed, we'll do the delay before starting the
> prepare phase.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Applied to drm-misc-next.

	Sam
