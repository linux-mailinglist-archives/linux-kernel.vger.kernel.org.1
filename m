Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046F526C045
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgIPJRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgIPJRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:17:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86159C06174A;
        Wed, 16 Sep 2020 02:16:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ay8so5508815edb.8;
        Wed, 16 Sep 2020 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tiUWzelY/QM67YXAjw8S4hXq7Bdu/l8z7sYlivpXpPw=;
        b=fNXRrzI5ATAQQf42TGNXbdPQFYj/tg1++kXw6Nh4Lx4iet8BUz7h2WJxsCyFD7prCV
         LBWv6OTVYI32dDum7UKyFzwaHKHDEWRqtPcgPpgFUGKYmHV2hZ92sjXJu362U4i5hRMC
         LRl+ETNByRKWHXKfaH8+IHV4r4gnw4IZ95Bwda9gZn2fSRLNhBYlMfOvmH3Pn/YA8t2i
         OfX0MZ/tWEwZvdmXWE/ONSzkNqdz0FziXO9YzkHcYI3bYKYeaq5PAOLD0/aLk7+R11L5
         yczvlBiPFBMaUgDU7iHjJI9TXiMPNW/f7kjjBQZuLQgaNd4A0+58I3UHLDGgdNu9v4QR
         zFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tiUWzelY/QM67YXAjw8S4hXq7Bdu/l8z7sYlivpXpPw=;
        b=kj8OM7JTNAPliA0SxpEAX0yDPtNlACa06r8zoVfHsXcr+7p/+5VQ4JRlD+8lMBCt1z
         yEq+017JsPiOrzm3rbPlfwD7INJCTz4Dt11Z9USk4P8C4ZlrH/Y1LGjDIivVhnyRzH04
         H4p4OHMvSmvcV/T8Z2pE8x44L6FYehxVhsiVVy6FxBWW70G6T0HWkHdlqv6oORIhY69b
         XWgOFHuIj+lga6AcLwUm4lFDCvEPwCyoQCUAyuL4Dm9ybX2+oiKB0or8IAJId4zaA2bH
         cnLt9Ywfo/Rz4Pd8hjGuvgHu/94K2dVUigIfCPhkU9Q2jHlQrceZaM7QO/4WI08sZ5Wt
         uAcg==
X-Gm-Message-State: AOAM532gwgoQTnMV2MYdow/k5Be+nMPLqnXhdiexLdaG+JiHWl/UdOSh
        nc0RhvuIe1Op7zfGfX4lJXXOnYwlrZDDDjix
X-Google-Smtp-Source: ABdhPJx6ArxE7cZbDhSS9hfa8xkncYEtFcWk/bYSUcGG11MDPsPrW1h3klaQUoLboqhBrTRCyswQfQ==
X-Received: by 2002:aa7:d30b:: with SMTP id p11mr26764557edq.80.1600247807032;
        Wed, 16 Sep 2020 02:16:47 -0700 (PDT)
Received: from felia ([2001:16b8:2dec:c500:15b1:3554:3841:68b])
        by smtp.gmail.com with ESMTPSA id b25sm2973870ejc.75.2020.09.16.02.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 02:16:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 16 Sep 2020 11:16:45 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>, linux-spdx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] LICENSES/deprecated: add Zlib license text
In-Reply-To: <20200401211316.7251-1-zaslonko@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2009161111460.10877@felia>
References: <20200401211316.7251-1-zaslonko@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Apr 2020, Mikhail Zaslonko wrote:

> The new files contributed to zlib have Zlib SPDX license identifier. Since
> there was no Zlib license text in LICENSES, scripts/spdxcheck.py
> reported the following errors:
>   lib/zlib_dfltcc/dfltcc.c: 1:28 Invalid License ID: Zlib
>   lib/zlib_dfltcc/dfltcc.h: 1:28 Invalid License ID: Zlib
>   lib/zlib_dfltcc/dfltcc_deflate.c: 1:28 Invalid License ID: Zlib
>   lib/zlib_dfltcc/dfltcc_inflate.c: 1:28 Invalid License ID: Zlib
>   lib/zlib_dfltcc/dfltcc_util.h: 1:28 Invalid License ID: Zlib
> 
> The patch adds Zlib SPDX license to LICENSES/deprecated, thus
> resolving the issues reported by spdxcheck.
> 
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> ---

IANAL, but to me that looks identical to the reference text on spdx.org. 
So:

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Greg, could you pick this patch on your spdx tree?

It has been hanging around here quite long :)

Lukas

>  LICENSES/deprecated/Zlib | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 LICENSES/deprecated/Zlib
> 
> diff --git a/LICENSES/deprecated/Zlib b/LICENSES/deprecated/Zlib
> new file mode 100644
> index 000000000000..b60d0d73f131
> --- /dev/null
> +++ b/LICENSES/deprecated/Zlib
> @@ -0,0 +1,27 @@
> +Valid-License-Identifier: Zlib
> +SPDX-URL: https://spdx.org/licenses/Zlib.html
> +Usage-Guide:
> +  To use the Zlib License put the following SPDX tag/value pair into a
> +  comment according to the placement guidelines in the licensing rules
> +  documentation:
> +    SPDX-License-Identifier: Zlib
> +License-Text:
> +
> +zlib License
> +
> +Copyright (c) <year> <copyright holders>
> +
> +This software is provided 'as-is', without any express or implied warranty. In
> +no event will the authors be held liable for any damages arising from the use
> +of this software.
> +
> +Permission is granted to anyone to use this software for any purpose, including
> +commercial applications, and to alter it and redistribute it freely, subject
> +to the following restrictions:
> +  1. The origin of this software must not be misrepresented; you must not
> +claim that you wrote the original software. If you use this software in a
> +product, an acknowledgment in the product documentation would be appreciated
> +but is not required.
> +  2. Altered source versions must be plainly marked as such, and must not be
> +misrepresented as being the original software.
> +  3. This notice may not be removed or altered from any source distribution.
> -- 
> 2.17.1
> 
> 
