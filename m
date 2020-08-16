Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C67C24585F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgHPPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 11:25:41 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:32866 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgHPPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:25:39 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 3C4558050E;
        Sun, 16 Aug 2020 17:25:35 +0200 (CEST)
Date:   Sun, 16 Aug 2020 17:25:34 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Modernize rocktech,jh057n00900 bindings a bit
Message-ID: <20200816152534.GB1394979@ravnborg.org>
References: <cover.1597561897.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1597561897.git.agx@sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=VwQbUJbxAAAA:8 a=7gkXJVJtAAAA:8
        a=Af31sPGs3lfZk1L4b_UA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

On Sun, Aug 16, 2020 at 09:13:41AM +0200, Guido G�nther wrote:
> This was prompted by Sam's review in
> https://lore.kernel.org/dri-devel/20200815210802.GA1242831@ravnborg.org/
> and yamllint. I also added myself as maintainer, hope that's o.k.
> 
> Guido G�nther (2):
>   dt-bindings: panel: rocktech,jh057n00900: Modernize
>   dt-bindings: panel: rocktech,jh057n00900: Add myself as maintainer

Thanks for this nice clean-up, and always good with an extra person
caring for something.
Applied to drm-misc-next

	Sam

> 
>  .../display/panel/rocktech,jh057n00900.yaml   | 40 +++++++++----------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> -- 
> 2.26.2
