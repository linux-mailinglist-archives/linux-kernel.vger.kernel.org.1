Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED3429072B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408827AbgJPO3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:29:22 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:53274 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408814AbgJPO3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:29:21 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id ABB1E80699;
        Fri, 16 Oct 2020 16:29:17 +0200 (CEST)
Date:   Fri, 16 Oct 2020 16:29:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/panel: mantix panel reset fixes
Message-ID: <20201016142916.GA1184974@ravnborg.org>
References: <cover.1602584953.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1602584953.git.agx@sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
        a=4K8JB3y5jV4O36iYuCkA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.
On Tue, Oct 13, 2020 at 12:32:45PM +0200, Guido Günther wrote:
> 
> The first patch in this series fixes dereferencing a NULL mode in the error
> path. The second one extends the resets to not only reset RESX but also TP_RSTN
> since otherwise the display will stay completely blank. I didn't spot that
> before initial submission since the reset line was bound to the touch
> controller and although that failed to probe it came far enough to deassert the
> reset line (at an arbitrary point in time during boot) and hence we got a
> picture. Since touch and panel are on the same IC they're not completely
> independent and i might have to turn the whole thing into an MFD at some point
> but this series gets the panel to a reliably working state on boot and on fb
> blank/unblank.
> 
> Since the reset-gpios are active low we can deassert in prepare and assert in
> unprepare simplifying the code making sure lines are kept low when the
> panel is off.
> 
> The binding were not part of a stable kernel so I hope it's okay to not worry
> about backward compatibility.
> 
> Changes from v1:
>  - As per review comments by Fabio Estevam
>    https://lore.kernel.org/dri-devel/CAOMZO5B5ECcConvKej=RcaF8wvOxgq7nUzKJ-ad0aSAOzUqtbQ@mail.gmail.com/
>    - Fix typo in commit messages
>  - As per review comments by Rob Herring
>    https://lore.kernel.org/dri-devel/20200929174624.GA832332@bogus/
>    - Don't use an array of reset lines
> 
> Guido Günther (3):
>   drm/panel: mantix: Don't dereference NULL mode
>   drm/panel: mantix: Fix panel reset
>   dt-binding: display: Require two resets on mantix panel

All applied to drm-misc-next and pushed out.
And then I remembered you had commit right - sigh.

	Sam

> 
>  .../display/panel/mantix,mlaf057we51-x.yaml   |  4 +++
>  .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 25 +++++++++++++------
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 
> -- 
> 2.28.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
