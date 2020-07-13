Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B752D21A058
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 14:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGIMzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 08:55:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36182 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgGIMzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:55:54 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtW4d-0003xv-Ke; Thu, 09 Jul 2020 22:54:48 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Jul 2020 22:54:47 +1000
Date:   Thu, 9 Jul 2020 22:54:47 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Corey Minyard <minyard@acm.org>,
        virtualization@lists.linux-foundation.org,
        openipmi-developer@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-crypto@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drivers/char: Constify static variables
Message-ID: <20200709125447.GD31057@gondor.apana.org.au>
References: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 10:09:45PM +0200, Rikard Falkeborn wrote:
> Constify some static variables (mostly structs) that are not modified.
> 
> Rikard Falkeborn (5):
>   hwrng: bcm2835 - Constify bcm2835_rng_devtype[]
>   hwrng: nomadik - Constify nmk_rng_ids[]
>   hwrng: virtio - Constify id_table[]
>   ipmi: watchdog: Constify ident
>   virtio_console: Constify some static variables
> 
>  drivers/char/hw_random/bcm2835-rng.c | 2 +-
>  drivers/char/hw_random/nomadik-rng.c | 2 +-
>  drivers/char/hw_random/virtio-rng.c  | 2 +-
>  drivers/char/ipmi/ipmi_watchdog.c    | 2 +-
>  drivers/char/virtio_console.c        | 8 ++++----
>  5 files changed, 8 insertions(+), 8 deletions(-)

Patches 1-3 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
