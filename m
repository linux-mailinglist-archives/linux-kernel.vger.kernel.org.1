Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1262C7B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 23:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgK2WLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 17:11:36 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41300 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2WLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 17:11:36 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8627E2002C;
        Sun, 29 Nov 2020 23:10:48 +0100 (CET)
Date:   Sun, 29 Nov 2020 23:10:47 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>, robdclark@chromium.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/5] drm: panel: simple: Fixup the struct panel_desc
 kernel doc
Message-ID: <20201129221047.GH1162850@ravnborg.org>
References: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8 a=fX1WW4ge2cSSqTkCiDQA:9
        a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,
On Mon, Nov 09, 2020 at 05:00:55PM -0800, Douglas Anderson wrote:
> When I run:
>   scripts/kernel-doc -rst drivers/gpu/drm/panel/panel-simple.c
> 
> I see that several of the kernel-doc entries aren't showing up because
> they don't specify the full path down the hierarchy.  Let's fix that
> and also move to inline kernel docs.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks, applied to drm-misc-next.

Could you do a follow-up patch that moves the rest as inline comments
and verify that all fields are described.  (W=1 should show no warnings).
That would be appreciated!

	Sam
