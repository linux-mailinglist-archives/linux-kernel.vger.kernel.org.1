Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5796A2A9922
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKFQLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:11:14 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:43362 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:11:14 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 4D61620068;
        Fri,  6 Nov 2020 17:11:11 +0100 (CET)
Date:   Fri, 6 Nov 2020 17:11:09 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 16/19] gpu: drm: panel: panel-ilitek-ili9322: Demote
 non-conformant kernel-doc header
Message-ID: <20201106161109.GA625131@ravnborg.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-17-lee.jones@linaro.org>
 <20201105211742.GD216923@ravnborg.org>
 <20201106074323.GV4488@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106074323.GV4488@dell>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=OMx_FZZBDUzjhAoBPWsA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
> > 
> > Applied to drm-misc-next.
> 
> Thanks for all these Sam.
> 
> Any idea what happens to the other patches?
> 
> Do they go in via a different Maintainer?

I expect the respective drm maintaines to take them.
Give them a few days to take action.

I look forward for the next set that you said would kill 2000+ warnings.

	Sam
