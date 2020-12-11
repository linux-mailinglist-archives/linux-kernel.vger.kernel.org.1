Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B342D6D60
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394877AbgLKBWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:22:37 -0500
Received: from twhmllg4.macronix.com ([122.147.135.202]:61509 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394788AbgLKBWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:22:14 -0500
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 0BB1KmVG015719;
        Fri, 11 Dec 2020 09:20:48 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 9E34BAEED14616A66FEC;
        Fri, 11 Dec 2020 09:20:48 +0800 (CST)
In-Reply-To: <20201210223333.204062b1@xps13>
References: <1607570529-22341-1-git-send-email-ycllin@mxic.com.tw>      <1607570529-22341-2-git-send-email-ycllin@mxic.com.tw> <20201210223333.204062b1@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, vigneshr@ti.com
Subject: Re: [PATCH 1/2] mtd: nand: ecc-bch: Fix the size of calc_buf/code_buf of
 the BCH
MIME-Version: 1.0
X-KeepSent: CD61AB38:41A2EFE7-4825863B:0006C241;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFCD61AB38.41A2EFE7-ON4825863B.0006C241-4825863B.000765F3@mxic.com.tw>
From:   ycllin@mxic.com.tw
Date:   Fri, 11 Dec 2020 09:20:48 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/12/11 AM 09:20:48,
        Serialize complete at 2020/12/11 AM 09:20:48
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com 0BB1KmVG015719
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,
> "Miquel Raynal" <miquel.raynal@bootlin.com> 
> 
> Re: [PATCH 1/2] mtd: nand: ecc-bch: Fix the size of calc_buf/code_buf of 
the BCH
> 
> Hi YouChing,
> 
> YouChing Lin <ycllin@mxic.com.tw> wrote on Thu, 10 Dec 2020 11:22:08
> +0800:
> 
(deleted)
> > The root cause is that the size of calc_buf/code_buf is limited to 64
> > bytes, although sizeof(mtd->oobsize) returns 4, kzalloc() will 
allocate
> > 64 bytes (cache size alignment).
> > 
> > So we correct the size of calc_buf/code_buf to mtd->oobsize.
> > 
> > Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/ecc-sw-bch.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/ecc-sw-bch.c 
b/drivers/mtd/nand/ecc-sw-bch.c
> > index 4d8a979..0a0ac11 100644
> > --- a/drivers/mtd/nand/ecc-sw-bch.c
> > +++ b/drivers/mtd/nand/ecc-sw-bch.c
> > @@ -237,8 +237,8 @@ int nand_ecc_sw_bch_init_ctx(struct nand_device 
*nand)
> > 
> >     engine_conf->code_size = code_size;
> >     engine_conf->nsteps = nsteps;
> > -   engine_conf->calc_buf = kzalloc(sizeof(mtd->oobsize), GFP_KERNEL);
> > -   engine_conf->code_buf = kzalloc(sizeof(mtd->oobsize), GFP_KERNEL);
> > +   engine_conf->calc_buf = kzalloc(mtd->oobsize, GFP_KERNEL);
> > +   engine_conf->code_buf = kzalloc(mtd->oobsize, GFP_KERNEL);
> 
> Very nice catch! If you don't mind I will merge this fix with the
> faulty commit (still in next) and I will also bring the fix to Hamming
> which will suffer from the same error.
> 
> Then I will apply the second patch.
 
No problem, thank you for your help.


Thanks,
Youching.


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

