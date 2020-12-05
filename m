Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB552CFDC1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgLESnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgLEQzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:55:24 -0500
Date:   Sat, 5 Dec 2020 17:31:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607185817;
        bh=Go2i9I5GYis0bcDmAK3eXZgV1WFDP4tUKeevAYtLQJs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUPABwyZTw922my5NtydwlJm7wnfm6+/Ljby83zLRdPoMSaj1GJRrUhMHF3kViv+k
         a2QmQ0k77SEr5lBT+5vXR3k9NEBJmkXF69r5tXCDn4yJ1SUflhOZqRvD8AvO0DMQKB
         myFLRZkmcrZ9R3SRwWK2FRuPNygDhO1gC5F7ww2w=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 5/7] regmap: sdw: use no_pm routines for SoundWire 1.2 MBQ
Message-ID: <X8u147aZbdrj6qN7@kroah.com>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-6-yung-chuan.liao@linux.intel.com>
 <20201205074630.GS8403@vkoul-mobl>
 <e4e3d7ea-0825-2c8c-4182-6d1b578200a3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4e3d7ea-0825-2c8c-4182-6d1b578200a3@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 08:52:50AM -0600, Pierre-Louis Bossart wrote:
> 
> > >   MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
> > > -MODULE_LICENSE("GPL v2");
> > > +MODULE_LICENSE("GPL");
> > 
> > Why do you want to change this ?
> 
> We only use MODULE_LICENSE("GPL") for new contributions since 'GPL v2' does
> not bring any information on the license, is equivalent to 'GPL' and only
> exists for 'historical reasons', see
> 
> https://www.kernel.org/doc/html/latest/process/license-rules.html
> 
> 
> “GPL”	Module is licensed under GPL version 2. This does not express any
> distinction between GPL-2.0-only or GPL-2.0-or-later. The exact license
> information can only be determined via the license information in the
> corresponding source files.
> 
> “GPL v2”	Same as “GPL”. It exists for historic reasons.
> 
> We should have used 'GPL' in the initial regmap MBQ patch but didn't for
> some reason, this change just realigns with what we intended.
> 
> That said, this is unrelated to this no_pm patch so could be in a separate
> one if you preferred it that way.

It should be separate as it does not have anything to do with the real
reason this patch was submitted.

thanks,

greg k-h
