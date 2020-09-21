Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61606272A41
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgIUPdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIUPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:33:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=j7DoK1q3vj3smXcrG1pL+I+cmL3yszs2iI54TItoeGE=; b=bjw0lfIOLeHAVMB3ORqtPtTM6J
        t6zBGxedSTBD9TsfurO/C1x/cx/r0fEoR5ExxPG1DdWwplz8YmogJJa3wj0hyWAmyfENetLgwQFYH
        LxUC24hbG5x6L6X9xVjVbUD7XntKnYxHITTM9v8gnFbIYtu2a4tQSFKa8cd4lpRFYG+WTClNvJD+W
        JZBFrRa3CgWXGCCmZFoIqJaFyerECFOGq2x588WGD2U4F76b2EimS++iERgm59nE4PvvNeykjj8Su
        +acatvvJqhX/LGvnnRYv7De+d4jy1RCYc3Ircppo8xNlhKUfBUA+kPsdHaxVu1iIuEz1W+R3/VHmT
        /exFawuQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKNot-0000Ta-SJ; Mon, 21 Sep 2020 15:33:36 +0000
Subject: Re: [PATCH v2 33/33] auxdisplay: add a driver for lcd2s character
 display
To:     poeschel@lemonage.de,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-34-poeschel@lemonage.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <775088e0-8873-3f6d-4947-95ffb763ef39@infradead.org>
Date:   Mon, 21 Sep 2020 08:33:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921144645.2061313-34-poeschel@lemonage.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 7:46 AM, poeschel@lemonage.de wrote:
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 153fa426ae7d..9c338af59589 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -173,6 +173,17 @@ config HT16K33
>  	  Say yes here to add support for Holtek HT16K33, RAM mapping 16*8
>  	  LED controller driver with keyscan.
>  
> +config LCD2S
> +	tristate "lcd2s 20x4 character display over I2C console"
> +	depends on I2C
> +	select CHARLCD
> +	default n

Drop "default n". That is already the default.

> +	help
> +	  This is a driver that lets you use the lcd2s 20x4 character display
> +	  from modtronix engineering as a console output device. The display

	       Modtronix

> +	  is a simple single color character display. You have to connect it
> +	  to an I2C bus.

thanks.
-- 
~Randy

