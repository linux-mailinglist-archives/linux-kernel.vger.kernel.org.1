Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F1D2534B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 18:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHZQVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 12:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgHZQVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:21:06 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 169DF214F1;
        Wed, 26 Aug 2020 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598458865;
        bh=ebWQh3nk8D4zG1syvCLitTt388shKB71c0Otl//ugiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yGu5Q+kQSKFQr3D2q9p/nApUJtOTWpsSyz3viYF2MAAYVGxjQ4bli5amwCn5mFqyG
         e8g5Qi36QC8yHasloS/dMD6HuHvN3n+kL3dYpx97hnfzCccSQ9+zutGq1UtHSZp4/o
         NMoGWAnNHFqIFID7MIj+FXmU+1c8CzIHasu90ZHw=
Date:   Wed, 26 Aug 2020 21:51:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 4/4] ASoC: rt715: Fix return check for
 devm_regmap_init_sdw()
Message-ID: <20200826162101.GE2639@vkoul-mobl>
References: <20200826122811.3223663-1-vkoul@kernel.org>
 <20200826122811.3223663-4-vkoul@kernel.org>
 <e71ba625-ec1e-1adf-9e4c-b65a91562d9c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e71ba625-ec1e-1adf-9e4c-b65a91562d9c@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-20, 10:09, Pierre-Louis Bossart wrote:
> 
> 
> On 8/26/20 7:28 AM, Vinod Koul wrote:
> > devm_regmap_init_sdw() returns a valid pointer on success or ERR_PTR on
> > failure which should be checked with IS_ERR. Also use PTR_ERR for
> > returning error codes.
> 
> Do you mind changing these two additional codecs that were missed in this
> series? Thanks!
> 
> rt700-sdw.c:	sdw_regmap = devm_regmap_init_sdw(slave, &rt700_sdw_regmap);
> rt700-sdw.c-	if (!sdw_regmap)
> rt700-sdw.c-		return -EINVAL;

Yes missed this one
> 
> --
> rt711-sdw.c:	sdw_regmap = devm_regmap_init_sdw(slave, &rt711_sdw_regmap);
> rt711-sdw.c-	if (!sdw_regmap)
> rt711-sdw.c-		return -EINVAL;

And somehow patch series is messed, I have two 2/4 but no 3/4 which
patches rt711-sdw.c, will send v2 with these fixed

-- 
~Vinod
