Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3FB2C7BA3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 23:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgK2WMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 17:12:47 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41382 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2WMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 17:12:46 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A968320031;
        Sun, 29 Nov 2020 23:11:59 +0100 (CET)
Date:   Sun, 29 Nov 2020 23:11:58 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>, robdclark@chromium.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 3/5] drm: panel: simple: Allow specifying the delay
 from prepare to enable
Message-ID: <20201129221158.GJ1162850@ravnborg.org>
References: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
 <20201109170018.v4.3.Ib9ce3c6482f464bf594161581521ced46bbd54ed@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109170018.v4.3.Ib9ce3c6482f464bf594161581521ced46bbd54ed@changeid>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8 a=4Av5kLI2NlvhjzHu5tUA:9
        a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On Mon, Nov 09, 2020 at 05:00:57PM -0800, Douglas Anderson wrote:
> On the panel I'm looking at, there's an 80 ms minimum time between HPD
> being asserted by the panel and setting the backlight enable GPIO.
> While we could just add an 80 ms "enable" delay, this is not ideal.
> Link training is allowed to happen in parallel with this delay so the
> fixed 80 ms delay over-delays.
> 
> We'll support this by logging the time at the end of prepare and then
> delaying in enable if enough time hasn't passed.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
Applied too.

	Sam
