Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C913022FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 09:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbhAYItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 03:49:06 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52802 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbhAYIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 03:41:58 -0500
Received: by mail-wm1-f43.google.com with SMTP id m187so9796027wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 00:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mZo7aKwXK5deoAcrsXLP1GP5WkzKfPSS28ocvilrOE8=;
        b=JQGfDbg8HrojNONppBEkR4ON/YxepZQv0TOPaxYSHUbEa6F3h8N7vJRBU12h4ipFfF
         /GGDGa4XXbday2fDFmmn9z1Voyyr9lWkdvRxFfzS1L6m7ORUUFJr0w17H3041ya5m50S
         P5PWxywP68XyThFzy4LznATDL4hAra9LlYi+XttvHvpaCrnznea0KOxXA776XadfJnQ6
         wbKQIBLcOiSC4pjyqlYVdWMRV7GGLbgI7lY2n4ysJn1Au/yal9oOfKeoth0Pft+lvBa/
         PLwzyJ2p8+t1TnAWG8ftOSHF7p7+VvMR0+oKJSl5bEXJiftE4yuyBiWSlO6A9oBqNsgp
         TOww==
X-Gm-Message-State: AOAM533QmKlYlqraCYngMcEc9Xpn9GnlmMJcE1Xa9DV/byd/+qwbLgPY
        PhGIIUIuQFFElRsA+ZPB+j0=
X-Google-Smtp-Source: ABdhPJzqtyNCKS2sng7AvV/KuXwIGCg36ChTNZfCr5oRaLPx4r2cb6HVrQPNF1aJsw7Pq4EawQNxdA==
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr14774541wmm.79.1611564053570;
        Mon, 25 Jan 2021 00:40:53 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n193sm20346055wmb.0.2021.01.25.00.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 00:40:52 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:40:51 +0100
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
Message-ID: <20210125084051.ipgeu2ksucdag2u4@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-3-yong.wu@mediatek.com>
 <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
 <1611557381.3184.21.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1611557381.3184.21.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 02:49:41PM +0800, Yong Wu wrote:
> On Fri, 2021-01-22 at 22:34 +0100, Krzysztof Kozlowski wrote:
> > On Thu, Jan 21, 2021 at 02:24:28PM +0800, Yong Wu wrote:
> > > The config MTK_SMI always depends on MTK_IOMMU which is built-in
> > > currently. Thus we don't have module_exit before. This patch adds
> > > module_exit and module_license. It is a preparing patch for supporting
> > > MTK_SMI could been built as a module.
> > > 
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/memory/mtk-smi.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > index e2aebd2bfa8e..aa2a25abf04f 100644
> > > --- a/drivers/memory/mtk-smi.c
> > > +++ b/drivers/memory/mtk-smi.c
> > > @@ -597,3 +597,13 @@ static int __init mtk_smi_init(void)
> > >  	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > >  }
> > >  module_init(mtk_smi_init);
> > > +
> > > +static void __exit mtk_smi_exit(void)
> > > +{
> > > +	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > > +}
> > > +module_exit(mtk_smi_exit);
> > > +
> > > +MODULE_DESCRIPTION("MediaTek SMI driver");
> > > +MODULE_ALIAS("platform:MediaTek-SMI");
> > 
> > Drivers do not use capital letters, so I have doubts whether this alias
> > is correct.
> 
> I didn't care the upper/lower-case. I will change to lower case in next
> time.

Then why do you need the alias? The name does not match driver name, so
what's the purpose of this alias/

> 
> MODULE_ALIAS("platform:MediaTek-smi")
> 
> > 
> > Adding all these should be squashed with changing Kconfig into tristate.
> > It does not have sense on its own.
> 
> Thanks  very much for review.
> 
> Only confirm: Squash whole this patch or only squash the MODULE_x into
> the next patch?

This entire patch 2/3 should be with 3/3.

Best regards,
Krzysztof
