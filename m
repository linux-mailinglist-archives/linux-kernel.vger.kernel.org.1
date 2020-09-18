Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD02D26FBE3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgIRL6M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Sep 2020 07:58:12 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60265 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIRL6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:58:12 -0400
X-Greylist: delayed 70082 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 07:58:12 EDT
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D787660072;
        Fri, 18 Sep 2020 11:58:08 +0000 (UTC)
Date:   Fri, 18 Sep 2020 13:58:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [GIT PULL] mtd: Fixes for v5.9-rc6
Message-ID: <20200918135806.00b76de3@xps13>
In-Reply-To: <c6965ad6-7d32-7dd9-21f8-346cfa634147@ti.com>
References: <c6965ad6-7d32-7dd9-21f8-346cfa634147@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Vignesh Raghavendra <vigneshr@ti.com> wrote on Fri, 18 Sep 2020
16:13:47 +0530:

> Hello Linus,
> 
> Please pull the MTD changes for v5.9-rc6.
> 
> I am sending this on behalf of MTD maintainers group this time around.
> 
> Miquel/Richard, 
> 
> Could you please ACK the PR?

I confirm Vignesh is allowed to send MTD PRs.

Thanks,
Miquèl
