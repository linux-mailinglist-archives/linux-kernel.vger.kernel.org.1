Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73A71A4629
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDJMOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 08:14:12 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37402 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgDJMOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 08:14:12 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6B5A080530;
        Fri, 10 Apr 2020 14:14:08 +0200 (CEST)
Date:   Fri, 10 Apr 2020 14:14:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: drm/tve200: Checking for a failed platform_get_irq() call in
 tve200_probe()
Message-ID: <20200410121406.GA31761@ravnborg.org>
References: <0263f4fb-c349-7651-b590-8722cdd30c85@web.de>
 <20200410101831.GA27723@ravnborg.org>
 <235b500a-0e5e-9ca3-4be5-9026c7d9f87f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <235b500a-0e5e-9ca3-4be5-9026c7d9f87f@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10
        a=JsGlSLdvelpcWIy28Y0A:9 a=QEXdDO2ut3YA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus.

On Fri, Apr 10, 2020 at 12:56:25PM +0200, Markus Elfring wrote:
> > The right way to check for errors is to check if the return value is
> > less than 0.
> 
> Thanks for your constructive feedback.
> 
> I was unsure if I noticed another programming mistake.
> 
> 
> > Could you please audit all uses of platform_get_irq() in drivers/gpu/
> 
> I found 20 source files from the software “Linux next-20200408”
> which seem to contain similar update candidates.
> Would you like to clarify any extensions for improved applications
> of scripts with the semantic patch language (Coccinelle software)
> for corresponding analysis and transformation purposes?
Please just send a series of patches, one for each driver.
Each changelog needs to explain the rationale behind the change.
Look at how this is often done.

As for coccinelle - I cannot help you.

	Sam
