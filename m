Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2FA2FC463
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbhASXEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 18:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbhASXDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 18:03:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B739E23108;
        Tue, 19 Jan 2021 23:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611097369;
        bh=4E6CYyWfOzG3kbePOJg95Tr9M7XePzzoRhZIEGwKPYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rYOD5vm/10zX8Z85fjbmCuePvlre8h9i21JsaIV33refwUyqq5ndU6BPmrVf5SsoL
         OBplT+xiKpjiHWYMNZc/Lha0/w3G88xuwRjY7/HlILoLBPmlVEoSFqZUj5Y5ZEINSl
         DbMs4jHphUpwcwCOL3m4ToG8g1F5WBpXFpsaqpT7ruWgUI/5Gls/UrHeKEhQLHPNmQ
         91FjDnQ889lIav5c40LmTCwcwpCLBitmBVYJGsbILI+OQMm3ePic9NZoQDVX6hPJq3
         rBUnu8ZCwN+RO90tvl9NCEufr610pSfmttmMpDfjT/H04DmQTJjG2DdIasMKYvUxYF
         s7IMmLhSQzccA==
Date:   Wed, 20 Jan 2021 00:02:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/21] regulator: hi6421v600-regulator: move it from
 staging
Message-ID: <20210120000244.2f1862d6@coco.lan>
In-Reply-To: <20210119161950.GC4478@sirena.org.uk>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
        <8000252dfd10677c5eb52d498e68de9c65304cf4.1611072387.git.mchehab+huawei@kernel.org>
        <20210119161950.GC4478@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 19 Jan 2021 16:19:50 +0000
Mark Brown <broonie@kernel.org> escreveu:

> On Tue, Jan 19, 2021 at 05:10:45PM +0100, Mauro Carvalho Chehab wrote:
> 
> > +static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
> > +{  
> 
> > +static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
> > +						 unsigned int selector)  
> 
> Now that the driver has been converted to regmap these are just
> duplicates of the regmap helpers.  You may also be able to use them for
> the disable() and is_enabled() operations, I didn't confirm that that's
> OK with the device using multi-bit enable controls for some reason IIRC.

True.

In order to avoid re-submitting 21 patches, I sent such change as
patch 22/21 .

Thanks,
Mauro
