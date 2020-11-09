Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C912AB1AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgKIHQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:16:58 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:51518 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIHQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:16:57 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6779B80537;
        Mon,  9 Nov 2020 08:16:54 +0100 (CET)
Date:   Mon, 9 Nov 2020 08:16:52 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] drm/panel: simple: Add flags to boe_nv133fhm_n61
Message-ID: <20201109071652.GA1715181@ravnborg.org>
References: <20201106182333.3080124-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106182333.3080124-1-swboyd@chromium.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8 a=KKAkSRfTAAAA:8
        a=iQUANYYRbEHiEctOL_IA:9 a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22
        a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen
On Fri, Nov 06, 2020 at 10:23:33AM -0800, Stephen Boyd wrote:
> Reading the EDID of this panel shows that these flags should be set. Set
> them so that we match what is in the EDID.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Fixes: b0c664cc80e8 ("panel: simple: Add BOE NV133FHM-N61")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to drm-misc-next as I could not see this was needed in mainline.
Or at least not urgently.
Let me know if this should be expeditet to current -rc

	Sam
