Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0758C2E78AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgL3Mt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:49:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgL3Mt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:49:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 102EA221FA;
        Wed, 30 Dec 2020 12:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609332557;
        bh=N5O6ImIkhpBZXKVxzeXm2qESd/kJs56wLovgR0WzzvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfBzYsy1U4kWCSu15T6F6GHLAulAxHU6NStTDDann3jT9gNRpDyoXovshTBVH5Zie
         BYx60T/7tNBZg0OrERa8shK1Nyh9dOtc1Qx9vSJGdpVZMQYU53fvjmm8+uHixYnQ1S
         NnPH1SydXvkM4FY8O0bytIAsLNKaAaB7Xfx8px8k=
Date:   Wed, 30 Dec 2020 13:50:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Xiaolei Wang <Xiaolei.Wang@windriver.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3] regmap: debugfs: Fix a memory leak when calling
 regmap_attach_dev
Message-ID: <X+x3pIanr18Ep4ga@kroah.com>
References: <20201229105046.41984-1-xiaolei.wang@windriver.com>
 <d516efdd-7e66-13fe-3798-cdea5ff012dc@web.de>
 <PH0PR11MB5077EC74C0A81ABF8F082BC795D70@PH0PR11MB5077.namprd11.prod.outlook.com>
 <1503f5fa-1ad6-7675-6e02-6dc1eb04c1de@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1503f5fa-1ad6-7675-6e02-6dc1eb04c1de@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 01:01:42PM +0100, Markus Elfring wrote:
> > Thank you very much, very good suggestion,
> 
> Thanks for another positive feedback.
> 
> 
> > do I need to re-send a patch to fix this problem, or modify the previous patch and send it again?
> 
> Please convince the involved contributors to integrate a corrected patch version.
> 
> * Better indentation.
> 
> * …
> >> +		if (!map->debugfs_name)
> >> +			kfree(map->debugfs_name);
> 
>   Would this questionable null pointer check result in a memory leak?

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
