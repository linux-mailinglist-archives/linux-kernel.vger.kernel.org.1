Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED56F1EB62A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgFBHF5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Jun 2020 03:05:57 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50463 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFBHF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:05:56 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 39728FF807;
        Tue,  2 Jun 2020 07:05:52 +0000 (UTC)
Date:   Tue, 2 Jun 2020 09:05:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bean Huo <huobean@gmail.com>
Cc:     vigneshr@ti.com, s.hauer@pengutronix.de,
        boris.brezillon@collabora.com, derosier@gmail.com,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH v6 0/5] Micron SLC NAND filling block
Message-ID: <20200602090550.2e6403f3@xps13>
In-Reply-To: <0a4fc94213ca5c2040796a66942f626587483721.camel@gmail.com>
References: <20200525121814.31934-1-huobean@gmail.com>
        <829d76189beff5a50ddc56123d22bff3aa6a3378.camel@gmail.com>
        <0a4fc94213ca5c2040796a66942f626587483721.camel@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Bean Huo <huobean@gmail.com> wrote on Mon, 01 Jun 2020 23:10:43 +0200:

> Hi Richard 
> would you please help us confirm below question??
> 
> Thanks,
> Bean
> 
> On Thu, 2020-05-28 at 16:14 +0200, Bean Huo wrote:
> > hi, Richard
> > 
> > 
> > On Mon, 2020-05-25 at 14:18 +0200, Bean Huo wrote:  
> > > After submission of patch V1 [1] and V2 [2], we stopped its update
> > > since we get
> > > stuck in the solution on how to avoid the power-loss issue in case
> > > power-cut
> > > hits the block filling. In the v1 and v2, to avoid this issue, we
> > > always damaged
> > > page0, page1, this's based on the hypothesis that NAND FS is UBIFS.
> > > This
> > > FS-specifical code is unacceptable in the MTD layer. Also, it
> > > cannot
> > > cover all
> > > NAND based file system. Based on the current discussion, seems that
> > > re-write all
> > > first 15 page from page0 is a satisfactory solution.  
> >   
> 
> > This patch has overwrite page0~page14, damage EC and VID header
> > boths.
> > I know this is safe for UBIFS, even fastmap is enabled (you fixed
> > this in (ubi: fastmap: Correctly handle interrupted erasures in
> > EBA)).
> > Now, how about jffs2? 
> > 
> > 
> > Thanks,
> > Bean
> >   
> 

FYI, Bean already askes me privately and here was my answer. Feel free
to comment.

---8<---
I'm not sure we are synced on this issue, because it is clearly
not addressed in your patchset.

Quoting Richard, the ubifs log uses a fixed range of LEBs. It replays
them upon mount and checks whether they are empty, new or outdated refs
it assumes that interrupted erase got detecred by UBI and such a LEB
will just contain 0xFF bytes. Rewriting the page before erase basically
fails this assumption.

For JFFS2, the problem is the clean marker. You cannot destroy the
payload while keeping the clean marker which says "this block is fine
and contain data".

Also, if you destroy the clean marker, you need to take care of not
turning the block being discovered as "bad" at reboot time if a power
cut happens before the erasure.

All of this is not impossible but:
- we need to write specific code for each user
- we don't want to create more problems that we already have

I cannot give you more details because this is not something that I
master. Ask Richard directly if you need more details on this.
--->8---

Cheers,
Miquèl
