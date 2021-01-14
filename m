Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBC82F6629
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhANQni convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Jan 2021 11:43:38 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59563 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbhANQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:43:38 -0500
X-Originating-IP: 86.201.233.230
Received: from xps13 (lfbn-tou-1-151-230.w86-201.abo.wanadoo.fr [86.201.233.230])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C36E6E0013;
        Thu, 14 Jan 2021 16:42:55 +0000 (UTC)
Date:   Thu, 14 Jan 2021 17:42:54 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Md Sadre Alam <mdalam@codeaurora.org>, richard@nod.at,
        vigneshr@ti.com, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: update last code word register
Message-ID: <20210114174254.55bd0083@xps13>
In-Reply-To: <20210114163154.GA76759@thinkpad>
References: <1610251305-20792-1-git-send-email-mdalam@codeaurora.org>
        <20210114165325.3d510355@xps13>
        <20210114163154.GA76759@thinkpad>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote on Thu,
14 Jan 2021 22:01:54 +0530:

> On Thu, Jan 14, 2021 at 04:53:25PM +0100, Miquel Raynal wrote:
> > Hello,
> > 
> > Md Sadre Alam <mdalam@codeaurora.org> wrote on Sun, 10 Jan 2021
> > 09:31:45 +0530:
> >   
> > > From QPIC version 2.0 onwards new register got added to  
> > 
> >                                 a
> >   
> > > read last codeword. This change will update the same.  
> > 
> >        the?           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >                       Please reword this sentence.
> >   
> > > For first three code word READ_LOCATION_n register will be
> > > use.For last code word READ_LOCATION_LAST_CW_n register will be
> > > use.  
> > 
> > "For the first three codewords, READ_LOCATION_n registers will be used.
> > The last codeword register will be accessed through
> > READ_LOCATION_LAST_CW_n."
> > 
> > Also, please specify what these registers store.
> >   
> > > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>  
> > 
> > Could someone please test this patch?
> >   
> 
> This is on my TODO list. Will get back to it once I'm back from holidays
> or sooner if I find some time in the middle.

No hurry, I believe this patch still needs a little bit of effort before
being ready for upstreaming.

Thanks,
Miquèl
