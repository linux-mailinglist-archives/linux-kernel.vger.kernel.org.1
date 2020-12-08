Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B410B2D2B81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgLHM4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgLHM4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:56:34 -0500
Date:   Tue, 8 Dec 2020 18:25:49 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607432154;
        bh=DwAV7zH+P8yCLLppVdnEWm7jEyFYcY0buhiThYP1IpQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=resxd2wxBAM0ElayHYdUDK8fD16d3qFWPlTzJ9Pa+uA4NBMOiSMCECIniE5STbceD
         p9M2qOxsWdRLIGK5SGHHryzOiwFBJI9bCZ9vpQ86EpC2U5x79WgyN8geNp96pRdRId
         3pE2mT/z9Nl5X1nEctSWVktg2oR0/sH7Ns0/1j0XjqK/Wc7z1TgxEISIgkuo/xtogQ
         Tmz8sMn6tEyk93pdykDJbIjdk0xgQ4IbsJ5ocXtf6V63eyedtzEtLrBOmst3/F0E2v
         NtFQmTOoK6tynjIH0JXY/L4zgYffzJxwjGKA8dpQN94BXgJMMg/Qicwac/1Xu9QBJV
         QsxLKmNRk8LCw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Colin King <colin.king@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        chunhui dai <chunhui.dai@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/mediatek: avoid dereferencing a null hdmi_phy
 on an error message
Message-ID: <20201208125549.GG8403@vkoul-mobl>
References: <20201207150937.170435-1-colin.king@canonical.com>
 <1607392202.23328.1.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607392202.23328.1.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-12-20, 09:50, Chunfeng Yun wrote:
> On Mon, 2020-12-07 at 15:09 +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently there is a null pointer check for hdmi_phy that implies it
> > may be null, however a dev_err messages dereferences this potential null
> > pointer.  Avoid a null pointer dereference by only emitting the dev_err
> > message if hdmi_phy is non-null.  It is a moot point if the error message
> > needs to be printed at all, but since this is a relatively new piece of
> > code it may be useful to keep the message in for the moment in case there
> > are unforseen errors that need to be reported.
> > 
> > Addresses-Coverity: ("Dereference after null check")
> > Fixes: be28b6507c46 ("drm/mediatek: separate hdmi phy to different file")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/phy/mediatek/phy-mtk-hdmi.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
> > index c5c61f5a9ea0..5184054783c7 100644
> > --- a/drivers/phy/mediatek/phy-mtk-hdmi.c
> > +++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
> > @@ -84,8 +84,9 @@ mtk_hdmi_phy_dev_get_ops(const struct mtk_hdmi_phy *hdmi_phy)
> >  	    hdmi_phy->conf->hdmi_phy_disable_tmds)
> >  		return &mtk_hdmi_phy_dev_ops;
> >  
> > -	dev_err(hdmi_phy->dev, "Failed to get dev ops of phy\n");
> > -		return NULL;
> > +	if (hdmi_phy)
> > +		dev_err(hdmi_phy->dev, "Failed to get dev ops of phy\n");
> > +			return NULL;
> indentation: one tab before return

I have applied this and fixed the indent while applying

-- 
~Vinod
