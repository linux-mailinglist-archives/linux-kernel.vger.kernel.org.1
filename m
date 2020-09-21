Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E17272A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgIUPac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgIUPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:30:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B9BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=1koMiRQbFFf0p9r9d0UTi54c7bEUA3DdvcMtOF4qjUg=; b=LXGbD7ATyDxuyUP7lUEf0o1j6p
        0RX3/QtQREPDsj4JG5mphPxND8eR5gR5C+P42PjS1v5VZklJWR/xj0+SiZxPSAWx2uZow1dMsFmc4
        bloGVlIXnb/umUBNc5CL7eRPgekfV2Jxav0FBVNx/lUhbxKYBKC3XaVhosOoZZWwRopMsckGL3Cws
        l4MDHmF5P+cJ+yj7UJrKE71GAQ0h88GI/iWi7ghq9bY002eVC2SSB9ImtHx4cjEpZQJG1PgnNu8IW
        YrYBEXb96xzb6bMM+2z8p5eVrZk1D3TapZrUpKeMSMYFffbHL2wveIFfJGkLmiu/CAcLG5hxvbyf3
        wJXcu/pg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKNlt-0008U3-3m; Mon, 21 Sep 2020 15:30:29 +0000
Subject: Re: [PATCH v2 02/32] auxdisplay: Introduce hd44780_common.[ch]
To:     poeschel@lemonage.de,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-3-poeschel@lemonage.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7239765f-bcbe-2149-e38a-bd03e33a7099@infradead.org>
Date:   Mon, 21 Sep 2020 08:30:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921144645.2061313-3-poeschel@lemonage.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/20 7:46 AM, poeschel@lemonage.de wrote:
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 81757eeded68..153fa426ae7d 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -14,12 +14,31 @@ menuconfig AUXDISPLAY
>  
>  	  If you say N, all options in this submenu will be skipped and disabled.
>  
> +config CHARLCD
> +	tristate "Character LCD core support" if COMPILE_TEST
> +	help
> +	  This is the base system for character based lcd displays.

	                              character-based LCD

> +	  It makes no sense to have this alone, you select your display driver
> +	  and if it needs the charlcd core, it will select it automatically.
> +	  This is some character lcd core interface that multiple drivers can

	                         LCD

> +	  use.
> +
> +config HD44780_COMMON
> +	tristate "Common functions for HD44780 (and compatibles) LCD displays" if COMPILE_TEST
> +	help
> +	  This is a module with the common symbols for HD44780 (and compatibles)
> +	  displays. This is the code that multiple other modules use. It is not
> +	  useful alone. If you have some sort of HD44780 compatible display,
> +	  you very likely use this. It is selected automatically by selecting
> +	  your concrete display.


thanks.
-- 
~Randy

