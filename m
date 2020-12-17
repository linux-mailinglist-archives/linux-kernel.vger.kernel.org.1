Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0272DD61A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgLQR0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:26:48 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:49500 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgLQR0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:26:47 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 733C580567;
        Thu, 17 Dec 2020 18:25:58 +0100 (CET)
Date:   Thu, 17 Dec 2020 18:25:56 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        jernej.skrabec@siol.net, narmstrong@baylibre.com, airlied@linux.ie,
        jonas@kwiboo.se, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, a.hajda@samsung.com,
        robh+dt@kernel.org, Laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] dt-bindings: display: bridge: tc358768: Remove
 maintainer information
Message-ID: <20201217172556.GA1339623@ravnborg.org>
References: <20201215124227.1872-1-peter.ujfalusi@ti.com>
 <1608042367.307112.3775381.nullmailer@robh.at.kernel.org>
 <90d45716-4f4e-7379-07fd-74eff793e498@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d45716-4f4e-7379-07fd-74eff793e498@ti.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=sozttTNsAAAA:8 a=krgCvxnHoqGKM54YNBcA:9
        a=CjuIK1q_8ugA:10 a=U8x1aBgNEqwA:10 a=aeg5Gbbo78KNqacMgKqU:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.

On Wed, Dec 16, 2020 at 09:44:59AM +0200, Peter Ujfalusi wrote:
> 
> On 15/12/2020 16.26, Rob Herring wrote:
> > On Tue, 15 Dec 2020 14:42:27 +0200, Peter Ujfalusi wrote:
> >> My employment with TI is coming to an end and I will not have access to
> >> the board where this bridge is connected to.
> >>
> >> It is better to remove a soon bouncing email address.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  .../devicetree/bindings/display/bridge/toshiba,tc358768.yaml   | 3 ---
> >>  1 file changed, 3 deletions(-)
> >>
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml: 'maintainers' is a required property
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml: ignoring, error in schema: 
> > warning: no schema found in file: ./Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> 
> Right, so it is not that easy to not been able to maintain this... :o
> 
> Who should be documented as maintainer?
> Andrzej, Neil, David or Daniel?

I have no problem being listed as maintainer despite my very limited
knowledge on the HW. So unless you end up volunteering then just
add me.

	Sam
