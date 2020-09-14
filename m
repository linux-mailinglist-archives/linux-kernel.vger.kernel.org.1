Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671252689E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgINLZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgINLYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:24:37 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D7AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:24:36 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ADD1C2250C;
        Mon, 14 Sep 2020 13:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600082671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSIenT/eAdfWHsMzr+7fvwJvSwJevHUBTg8/EDHXEAI=;
        b=WbXvk1B0PQEhKBAqE5pX/daD7i4tV8zaQsMadEivSvPhV4tUoEeoBeBAtKNQ8AsDD6sq2C
        30H8jvQKhIO2M334SGFHZJluZ3NdqUlyV9UOnANuwI6yIoZsk/mET0hdZn6oyHDq91IhAI
        LgQRf+K8/cAl8j8PhrNLh8JonEfb2uU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Sep 2020 13:24:30 +0200
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jungseung Lee <js07.lee@samsung.com>
Subject: Re: [PATCH v2 0/4] mtd: spi-nor: OTP support
In-Reply-To: <20200911222634.31804-1-michael@walle.cc>
References: <20200911222634.31804-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <fd6562b7771c2dc18292b588ae75d17d@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-09-12 00:26, schrieb Michael Walle:
> This patchset implements the MTD OTP functions to allow access to the 
> SPI
> OTP data. Specific support is added for the Adesto, Macronix and 
> Winbond
> flash chips.
> 
> In the past there was already an attempt by Rahul Bedarkar to add this, 
> but
> there was no response. These patches are slightly based on his work.
> 
> https://lore.kernel.org/linux-mtd/1489754636-21461-1-git-send-email-rahul.bedarkar@imgtec.com/
> 

I've missed appending the changelog:

changes since v1:
  - rebased to latest tree
  - correctly check return code of otp_ops->is_locked() in 
spi_nor_mtd_otp_info()
  - use correct bouncebuf for spi command in spi_nor_otp_lock_sr2()
  - add cleanup patch to consolidate some of the "if (spimem) {} else {}" 
patterns
  - add otp support for macronix and similar flashes
  - moved otp code into core.c because it is used across different 
vendors
  - use generic naming, eg. spi_nor_otp_lock_sr2() instead of 
winbond_otp_lock()

-michael

> Michael Walle (4):
>   mtd: spi-nor: cleanup common code
>   mtd: spi-nor: add OTP support
>   mtd: spi-nor: implement OTP support for Macronix and similar flashes
>   mtd: spi-nor: implement OTP support for Winbond and similar flashes
> 
>  drivers/mtd/chips/Kconfig      |   2 +-
>  drivers/mtd/spi-nor/atmel.c    |  13 +-
>  drivers/mtd/spi-nor/core.c     | 769 ++++++++++++++++++++++++---------
>  drivers/mtd/spi-nor/core.h     |  61 +++
>  drivers/mtd/spi-nor/macronix.c |  13 +-
>  drivers/mtd/spi-nor/winbond.c  |  18 +-
>  include/linux/mtd/spi-nor.h    |  16 +
>  7 files changed, 676 insertions(+), 216 deletions(-)
