Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD291DA827
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 04:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgETCoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 22:44:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46622 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgETCoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:44:55 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04K2ig9e038487;
        Tue, 19 May 2020 21:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589942682;
        bh=4LA7BQvWOOiT0ndwf7oyzTtXGkJFmJHqlSXFIPNcau0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aruydvhM1RVJGbXuIcbt+D9bSr6ZhmWn4jG8zxGvvTR8yjctJ7LU501+0NlbjZO2v
         GnPmYp7KNDjfp1W84ksGrGKl6IG4vJTnjbLFhaupbSPSwL6GNJSv/zfxXGmUqbCpo8
         yJbC5EcEJc6L4y0HQDus9dTTtEOnNSZsWhTjP+D0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04K2igFZ043373
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 21:44:42 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 21:44:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 21:44:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04K2iffQ007005;
        Tue, 19 May 2020 21:44:41 -0500
Date:   Tue, 19 May 2020 21:44:41 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Min Guo <min.guo@mediatek.com>
CC:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH] usb: musb: mediatek: add reset FADDR to zero in reset
 interrupt handle
Message-ID: <20200520024441.GB5684@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Min Guo <min.guo@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
References: <1589428872-29282-1-git-send-email-macpaul.lin@mediatek.com>
 <1589441605.28160.27.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1589441605.28160.27.camel@mhfsdcap03>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 03:33:25PM +0800, Min Guo wrote:
> On Thu, 2020-05-14 at 12:01 +0800, Macpaul Lin wrote:
> > When receiving reset interrupt, FADDR need to be reset to zero in
> > periphearl mode. Otherwise ep0 cannot do enumeration when re-pluging USB
> > cable.
> > 
> > Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> > ---
> >  drivers/usb/musb/mediatek.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
> > index 6196b0e..eebeadd 100644
> > --- a/drivers/usb/musb/mediatek.c
> > +++ b/drivers/usb/musb/mediatek.c
> > @@ -208,6 +208,12 @@ static irqreturn_t generic_interrupt(int irq, void *__hci)
> >  	musb->int_rx = musb_clearw(musb->mregs, MUSB_INTRRX);
> >  	musb->int_tx = musb_clearw(musb->mregs, MUSB_INTRTX);
> >  
> > +	if ((musb->int_usb & MUSB_INTR_RESET) && !is_host_active(musb)) {
> > +		/* ep0 FADDR must be 0 when (re)entering peripheral mode */
> > +		musb_ep_select(musb->mregs, 0);
> > +		musb_writeb(musb->mregs, MUSB_FADDR, 0);
> > +	}
> > +
> >  	if (musb->int_usb || musb->int_tx || musb->int_rx)
> >  		retval = musb_interrupt(musb);
> >  
> 
> Acked-by:Min Guo <min.guo@mediatek.com>
> 

Queued for v5.8. Thanks.

-Bin.
