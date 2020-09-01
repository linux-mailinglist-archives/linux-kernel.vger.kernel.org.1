Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D7258D72
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 13:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIAL3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 07:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgIALZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:25:27 -0400
Received: from localhost (unknown [122.172.190.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9A4207EA;
        Tue,  1 Sep 2020 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598958469;
        bh=Y3y5UkDAv4eqxhZr5c9rL5O7ZyCc/VXuq26MFzz9nq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PR/oaQSSufNBm6+ewj1f1CKlOwqhr9DQhG0ymdEG1psbU4awNK4d8GmoFZGRz3//b
         SJakzIt8uoE5C7CN+Tz0b1ckPnhMmej6SRyHSSpUPsC3j/kN2duHxDH5LLs81gsnn8
         YtL3c8s2eqWk9dPgeiTyb1CxEl5Bt72kn/mKZcjI=
Date:   Tue, 1 Sep 2020 16:37:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: soundwire: remove unsed header mod_devicetable.h
Message-ID: <20200901110745.GB2639@vkoul-mobl>
References: <20200829103939.4007097-1-vkoul@kernel.org>
 <d329c295-b2d1-68d9-79bf-278f7af4bb58@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d329c295-b2d1-68d9-79bf-278f7af4bb58@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-20, 09:12, Pierre-Louis Bossart wrote:
> typo in commit message?

Thanks for spotting, will send v2.

> 
> On 8/29/20 5:39 AM, Vinod Koul wrote:
> > mod_devicetable.h does not seem to be required for this file, so
> > remove it.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   drivers/base/regmap/regmap-sdw.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
> > index 50a66382d87d..c92d614b4943 100644
> > --- a/drivers/base/regmap/regmap-sdw.c
> > +++ b/drivers/base/regmap/regmap-sdw.c
> > @@ -2,7 +2,6 @@
> >   // Copyright(c) 2015-17 Intel Corporation.
> >   #include <linux/device.h>
> > -#include <linux/mod_devicetable.h>
> >   #include <linux/module.h>
> >   #include <linux/soundwire/sdw.h>
> >   #include "internal.h"
> > 

-- 
~Vinod
