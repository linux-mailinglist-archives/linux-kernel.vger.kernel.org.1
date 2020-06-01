Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1988C1EA86A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 19:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgFARbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 13:31:31 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:42220 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFARbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:31:31 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49bMfS2W0LzLn;
        Mon,  1 Jun 2020 19:31:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591032689; bh=OcbJRSI9gSF9z5NgduN2oVxJ6vT/DUHo/GDJNy7Y0Is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oO3KEZHmFcixsHiF3qnNmW6/EaRrzo5ZWLa8usHOmKZLeqcBlzOwyoIXVFZ5y2Bzy
         tYH2SgKLRYiMAXaI/xPqQBRZbuetTrK8vnZPUl6MkAwaFocrSHsyqpDoRXVk8L5dU6
         +L26ikeDTAIUDCRYAkfRPurU8uZZaA9GQk/26W0lNFaSPugQp9KJ1XW14ZEd+XO82Z
         +21ysbjhAD3kzwfDgnR3vEkubG4VA76j0epEm3xkR/NRKIgRLDjee+Nv/J0E4BqqBS
         RuMZNzijow8bL4OoAChoVn+m8AiEoJ9ltbgttpX/lfcIUxMiGZnsAqitqjYTUAzdgK
         YIJSeGX1Pe/qA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 1 Jun 2020 19:31:27 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] misc: atmel-ssc: lock with mutex instead of spinlock
Message-ID: <20200601173126.GA31822@qmqm.qmqm.pl>
References: <eb9b1cb3-5b3f-f387-da45-71427a4383ed@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb9b1cb3-5b3f-f387-da45-71427a4383ed@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 11:18:48AM +0200, Markus Elfring wrote:
> > Uninterruptible context is not needed in the driver and causes lockdep
> > warning because of mutex taken in of_alias_get_id().
> 
> Was a spin lock taken?
> > Convert the lock to mutex to avoid the issue.
> Would you like to add the tag “Fixes” to the commit message?

I guess we can add:

Fixes: 099343c64e16 ("ARM: at91: atmel-ssc: add device tree support")

Best Regards
Michał Mirosław
