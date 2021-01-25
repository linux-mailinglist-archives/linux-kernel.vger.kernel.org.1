Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D5C30351A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbhAZFfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:35:16 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40223 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbhAYKlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:41:18 -0500
Received: by mail-wr1-f47.google.com with SMTP id c12so11744994wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 02:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DsJE2zPkprb7gh+GS+eIFG0M1vuNomWHZqhGRuLhtzQ=;
        b=iFgmho6ywcoHVoNGYfUC9bOKinRGbOeUWH+PcDT7dm5O5YMx8XnqWk6xYI9U6LmxEc
         OgrT6OjLro2Yx2o0u28tTmOrCQirJ0IoN5RRd9LZY9+oy6PKDKiwZhBRJINgjy4tZYs2
         A4yGI7CBzk/ogmuGsLmWelEb5VupENnrjgy6GTpExBHU4eAmLoh14tmG13P8IwWmBBs0
         MbSbadK3UYRAPwn/nCTKXFHtxTssB9GdQLXg8gCRyXpWPbhoYnzlUVZLjysj2XOvl3tU
         m0jKwf1i1fSt1yZpKmEzZvN5HgzJdzABkNKvR/xebQwWMTk8DuSiytKKyWSkkqzRMykh
         kIew==
X-Gm-Message-State: AOAM5306pRTBzjvEdVKgr/FUlLI5eXb79H4BtWOGrIaApzfchYZLy547
        O019CXCkMNjhi7ePodZ4TUY=
X-Google-Smtp-Source: ABdhPJxFRyn+qu6XbZN8Kw3vcIaOk89MqJcinq7fckxNIcL/17AL7YibO7Tz3bhcgYseghNGX5zLzA==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr200432wru.152.1611571236869;
        Mon, 25 Jan 2021 02:40:36 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id g1sm21982339wrq.30.2021.01.25.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 02:40:35 -0800 (PST)
Date:   Mon, 25 Jan 2021 11:40:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        yi.kuo@mediatek.com
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add module_exit and module_license
Message-ID: <20210125104033.2ewzumhmagmouvo5@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-3-yong.wu@mediatek.com>
 <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
 <1611557381.3184.21.camel@mhfsdcap03>
 <20210125084051.ipgeu2ksucdag2u4@kozik-lap>
 <1611566885.5302.4.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1611566885.5302.4.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 05:28:05PM +0800, Yong Wu wrote:
> On Mon, 2021-01-25 at 09:40 +0100, Krzysztof Kozlowski wrote:
> > On Mon, Jan 25, 2021 at 02:49:41PM +0800, Yong Wu wrote:
> > > On Fri, 2021-01-22 at 22:34 +0100, Krzysztof Kozlowski wrote:
> > > > On Thu, Jan 21, 2021 at 02:24:28PM +0800, Yong Wu wrote:
> > > > > The config MTK_SMI always depends on MTK_IOMMU which is built-in
> > > > > currently. Thus we don't have module_exit before. This patch adds
> > > > > module_exit and module_license. It is a preparing patch for supporting
> > > > > MTK_SMI could been built as a module.
> > > > > 
> > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > ---
> > > > >  drivers/memory/mtk-smi.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > > > index e2aebd2bfa8e..aa2a25abf04f 100644
> > > > > --- a/drivers/memory/mtk-smi.c
> > > > > +++ b/drivers/memory/mtk-smi.c
> > > > > @@ -597,3 +597,13 @@ static int __init mtk_smi_init(void)
> > > > >  	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > > > >  }
> > > > >  module_init(mtk_smi_init);
> > > > > +
> > > > > +static void __exit mtk_smi_exit(void)
> > > > > +{
> > > > > +	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > > > > +}
> > > > > +module_exit(mtk_smi_exit);
> > > > > +
> > > > > +MODULE_DESCRIPTION("MediaTek SMI driver");
> > > > > +MODULE_ALIAS("platform:MediaTek-SMI");
> > > > 
> > > > Drivers do not use capital letters, so I have doubts whether this alias
> > > > is correct.
> > > 
> > > I didn't care the upper/lower-case. I will change to lower case in next
> > > time.
> > 
> > Then why do you need the alias? The name does not match driver name, so
> > what's the purpose of this alias/
> 
> I think it is not so necessary for us. I will delete this line in next
> version.
> 
> Only curious what's alias is fit in our case? normally it should be the
> file name: mtk-smi?

If autoloading of your module works, then remove it. The alias is
necessary for some cases when a device table is missing (e.g. platform
driver is matched via devicetree but not having the platform_device_id
table) or matching is done via different method (e.g. driver is matched
from MFD via devicetree compatible even though there is a
platform_device_id table).

Best regards,
Krzysztof
