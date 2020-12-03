Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3ED2CE0C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgLCVeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:34:24 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:47560 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgLCVeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:34:24 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 22B508050C;
        Thu,  3 Dec 2020 22:33:36 +0100 (CET)
Date:   Thu, 3 Dec 2020 22:33:34 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        kraxel@redhat.com, tzimmermann@suse.de, alexander.deucher@amd.com,
        tglx@linutronix.de
Subject: Re: [PATCH drm/hisilicon 2/3] drm/irq: Add the new api to install irq
Message-ID: <20201203213334.GB81406@ravnborg.org>
References: <1606898835-40775-1-git-send-email-tiantao6@hisilicon.com>
 <1606898835-40775-3-git-send-email-tiantao6@hisilicon.com>
 <20201203200711.GA74163@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203200711.GA74163@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=TJU36lUpsagq2rwV8KQA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tian,

> > +	ret = devm_add_action_or_reset(dev->dev, devm_drm_irq_uninstall, dev);
> > +	if (ret)
> > +		devm_drm_irq_uninstall(dev);
> devm_add_action_or_reset() will call devm_drm_irq_uninstall() if ret is
> != 0. See include/device.h.
> 
> I guess that is the "_or_reset" part of the name that can tell us that.
> So you can drop the if condition as it just will cause the code to call
> drm_irq_uninstall() twice.

Noticed this was fixed in v2 - so all is fine here.

	Sam
