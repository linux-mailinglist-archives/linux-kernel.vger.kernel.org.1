Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41B72CBB86
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgLBL0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgLBL0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:26:37 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928EFC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 03:25:56 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2269A23E43;
        Wed,  2 Dec 2020 12:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606908354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGdaTb8+n/eu9mBaZ6S/gg5++a3lVOaPda1flJn9YFI=;
        b=S1jljpozSrGwR68R9kAGotK4F+MWcsrKJxK0FFbdStXZk3WsdPPzqBMnBw0lVlZnHIouLm
        kww2/tDroMZEzGu58ymBf3u4cYE3YgVz79b5ndS0uI1DFo0QHZ7LNrmIOAuWp7GheKw9Hp
        U0+dhyg/k+Jyf/xwBfYUucRiLRsRP/w=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 02 Dec 2020 12:25:49 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Subject: Re: [PATCH v6 5/5] mtd: spi-nor: keep lock bits if they are
 non-volatile
In-Reply-To: <8e0a6a20-2779-9397-eedf-02518b4a0e5a@microchip.com>
References: <20201126202614.5710-1-michael@walle.cc>
 <20201126202614.5710-6-michael@walle.cc>
 <432b31a7-2560-3b83-44d2-aa82c2e322ae@microchip.com>
 <46c99138eb6ce251bc741d358388c219@walle.cc>
 <8e0a6a20-2779-9397-eedf-02518b4a0e5a@microchip.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <fe04f234584c2f459e865955b0d09303@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-12-02 12:10, schrieb Tudor.Ambarus@microchip.com:
> On 11/30/20 4:38 PM, Michael Walle wrote:
[..]
>>>> +        * indicated by SNOR_F_WP_IS_VOLATILE.
>>>> +        */
>>>> +       if (IS_ENABLED(CONFIG_MTD_SPI_NOR_WP_DISABLE) ||
>>>> +           (IS_ENABLED(CONFIG_MTD_SPI_NOR_WP_DISABLE_ON_VOLATILE) 
>>>> &&
>>>> +            nor->flags & SNOR_F_WP_IS_VOLATILE)) {
>>>> +               err = spi_nor_unlock_all(nor);
>>>> +               if (err) {
>>>> +                       dev_err(nor->dev, "Failed to unlock the 
>>>> entire
>>>> flash memory array\n");
>>> 
>>> dev_dbg for low level info
>> 
>> Is this low level info or an actual error? Which raises the question:
>> should spi_nor_unlock_all() in case SWRD couldn't be cleared and thus
>> should all the spi_nor_init fail of this? Or should it rather be a
> 
> yes, it should, because the flash will not work as expected/requested.

One counterargument: take our sl28 board, it has a hardware 
write-protected
SPI flash. It actually works right now because the write_sr_and_check()
doesn't work as intended and doesn't check what is written. So if you'd
fix that (and these changes would be backported to the stable trees), 
you'd
basically break spi-nor on these boards. And this _must_ be the case for
all boards which are actually using (hard- or sofware) write-protection.
That is the only way write-protection makes sense prior to this patch
series. Because linux will happily unlock every flash on startup. 
Therefore,
the hardware write protection is the only measure against this.

-michael
