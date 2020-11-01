Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC932A1DD5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 13:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgKAM0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 07:26:17 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:48618 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgKAM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 07:26:17 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 85B9220022;
        Sun,  1 Nov 2020 13:26:13 +0100 (CET)
Date:   Sun, 1 Nov 2020 13:26:11 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christophe Branchereau <cbranchereau@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/panel: ABT Y030XX067A panel support
Message-ID: <20201101122611.GA1269759@ravnborg.org>
References: <20201101093150.8071-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101093150.8071-1-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=9Q3-Gd2UY0mbpF3q5_8A:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Sun, Nov 01, 2020 at 09:31:46AM +0000, Paul Cercueil wrote:
> Hi,
> 
> This patchset is for adding support for the Asia Better Technology (aka.
> ABT) Y030XX067A 3.0" 320x480 24-bit LCD IPS panel.
> 
> While being 320x480 it is actually 4:3 with non-square pixels, and
> requires a specific bus format, as the pixel ordering changes each line
> (RGB on odd lines, GRB on even lines).
> 
> Patch #1 adds the abt,* vendor prefix.
> Patch #2 adds the abt,y030xx067a panel binding documentation.
> Patch #3 adds the MEDIA_BUS_FMT_RGB888_3X8_DELTA media bus format.
> Patch #4 adds the driver itself.

Full series looks good.

I asked google - but no hits for "Asia Better Technology". But I blame
that the company has no public page - in english at least.
Also the part with a DELTA media bus format looks correct, but not
something I know much off.

The driver itself utilises regmap_multi_reg_write() - very nice!

Full series is:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I assume you will apply yourself - but please wait a few days after it
have hit dri-devel to let others have the possibility to give feedback.

	Sam
