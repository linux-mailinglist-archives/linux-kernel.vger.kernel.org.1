Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C52B9007
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgKSKUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:20:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgKSKUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:20:47 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B457A24698;
        Thu, 19 Nov 2020 10:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605781246;
        bh=ehcYypQuHzkF5BBv0v8MHkj6WiebOTftlrc66yRCup8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aOcHDQupECII/OPF1ZL97joCf5UAJW1nxgbLLnjhMpeewNP59EcUgNH31uCt5Jlbj
         R/BzklO4l86Zii9GwTGFGPFrapVYBlYHRrZuqvtN0Bw+she5+i7wkSAn+Fqeru4o35
         daNhqKAPZVA+pQddvIgsaNYfW29MhZHbi6+JZVcY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kfh3P-00Bv0R-EZ; Thu, 19 Nov 2020 10:20:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Nov 2020 10:20:39 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     kernelci-results@groups.io, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: next/master bisection: baseline.dmesg.emerg on meson-gxbb-p200
In-Reply-To: <a0bec7c4-9bec-8858-4879-52f4688d9992@collabora.com>
References: <5fb5e094.1c69fb81.a2014.2e62@mx.google.com>
 <a0bec7c4-9bec-8858-4879-52f4688d9992@collabora.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <630e00e83cdd07ee5a0eaba9d3479554@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: guillaume.tucker@collabora.com, narmstrong@baylibre.com, kernelci-results@groups.io, khilman@baylibre.com, jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com, airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-19 08:50, Guillaume Tucker wrote:
> Please see the automated bisection report below about some kernel
> errors on meson-gxbb-p200.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org, however this one
> looks valid.
> 
> The bisection started with next-20201118 but the errors are still
> present in next-20201119.  Details for this regression:
> 
>   https://kernelci.org/test/case/id/5fb6196bfd0127fd68d8d902/
> 
> The first error is:
> 
>   [   14.757489] Internal error: synchronous external abort: 96000210
> [#1] PREEMPT SMP

Looks like yet another clock ordering setup. I guess different Amlogic
platforms have slightly different ordering requirements.

Neil, do you have any idea of which platform requires which ordering?
The variability in DT and platforms is pretty difficult to follow (and
I don't think I have such board around).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
