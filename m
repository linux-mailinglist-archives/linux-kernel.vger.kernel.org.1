Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914951AADA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 18:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410342AbgDOQRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 12:17:08 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:57324 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415520AbgDOQRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:17:01 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 492SDC0ZJvzCQ;
        Wed, 15 Apr 2020 18:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1586967419; bh=nvSXkuggto19YtM9iNVkNz/u61dow6dPIiXyLsFNiVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GL9XWg82YmU7Wm8NTD3odjlDUM/EZ0NaeRrTYz7060Y9VZYrJoRQqVGZRfc/sy2/+
         2mo5Oc9PwNNfEqhw8OJ/OmbUCTmV0WICwYpTbGl6wdvQR82MNvh+2dyC9gRrzD3faN
         /OOuh2W/+sAD7vp8r4Uut7Xz6kjy8bCY2KnHmhGUnMODG2107A/xmt9d8P7vEWnPh9
         WIGRuGHYmVc8S3uFtXTnllGht6GOHTjZ06QopyXqy/USdIsYGNWkrZaTQWZPWvt6XL
         Ve1+5iCgTZYjlSGGmLRuaKo3iQFM8O+2DS8I9lkwjsusBGpAbb9UQYEXq2cIjuupyb
         ZN6dvMbb/XcFQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 15 Apr 2020 18:16:57 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 4/7] mmc: sdhci: move SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
 frequency limit
Message-ID: <20200415161657.GC19897@qmqm.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <637b9bea4c28a0eeacf754d2930596b8e6673808.1585827904.git.mirq-linux@rere.qmqm.pl>
 <2b111407-0f35-3c5e-f7f0-4a05a281dce2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b111407-0f35-3c5e-f7f0-4a05a281dce2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 04:16:04PM +0300, Adrian Hunter wrote:
> On 2/04/20 2:54 pm, Micha³ Miros³aw wrote:
> > Move clock frequency limit for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN where
> > it belongs.
> 
> Did you consider getting rid of SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN and
> handling it in sdhci-of-arasan instead?

I'm expecting to use this quirk for DDR mode support in other host drivers,
but I can't test this, yet.

Best Regards,
Micha³ Miros³aw
