Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775C52B00D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgKLIIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:08:07 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35450 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLIIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:08:06 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 602863B747B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:02:27 +0000 (UTC)
Received: from windsurf (lfbn-tou-1-236-25.w86-201.abo.wanadoo.fr [86.201.80.25])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 25618200004;
        Thu, 12 Nov 2020 08:02:03 +0000 (UTC)
Date:   Thu, 12 Nov 2020 09:02:02 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        thomas.petazzoni@free-electrons.com, arnd@arndb.de,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mvebu-mbus: make iounmap() symmetric with
 ioremap()
Message-ID: <20201112090202.638c0c13@windsurf>
In-Reply-To: <20201112032149.21906-1-chris.packham@alliedtelesis.co.nz>
References: <20201112032149.21906-1-chris.packham@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 16:21:49 +1300
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> make coccicheck complains:
> 
>   ./drivers/bus/mvebu-mbus.c:1113:2-8: ERROR: missing iounmap; ioremap on line 1106 and execution via conditional on line 1111
> 
> It took some staring but I don't think there is a problem because the
> file global `mbus_state` is passed mvebu_mbus_common_init() as the
> `mbus` parameter so `mbus_state.mbuswins_base` and `mbus->mbuswins_base`
> are the same thing. But this is confusing for anyone reading the code
> and one less complaint from coccicheck would be nice so lets fix it.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
