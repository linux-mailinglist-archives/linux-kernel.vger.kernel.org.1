Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501B226C4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgIPP7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 11:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgIPPzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:32 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4262C22211;
        Wed, 16 Sep 2020 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600258341;
        bh=kkMD2cqZ8fttnTyQxIw3Z6fU1nZFyyqMqzMlQsH3GOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xPq9zi5888aBFYajlDJls8BsbIZwjrro6fxEWjAVKOJRkrBL/ps1RDgtg9CNJmZfd
         b341ygXmYaT6ZHA7wVgXTDvAYgRTXo5v8wNW3PuZ6rdhvhsuuIs6reF9lqrvq0w3cN
         /l3LkBgFjl4TM0dJf6GA1SZaYDxIEqmt5gLUxNy4=
Date:   Wed, 16 Sep 2020 17:42:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>
Subject: Re: [PATCH v2 0/7] PHY: Prepare Cadence Torrent PHY driver to
 support multilink configurations
Message-ID: <20200916121213.GH2968@vkoul-mobl>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
 <20200908050533.GB77521@vkoul-mobl>
 <DM6PR07MB61543BF71CE5CAE3611A7A31C5290@DM6PR07MB6154.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR07MB61543BF71CE5CAE3611A7A31C5290@DM6PR07MB6154.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 08-09-20, 13:57, Swapnil Kashinath Jakhade wrote:
> > On 27-08-20, 15:28, Swapnil Jakhade wrote:
> > > Cadence Torrent PHY is a multiprotocol PHY supporting different
> > > multilink PHY configurations including DisplayPort, PCIe, USB, SGMII,
> > QSGMII etc.
> > > Existing Torrent PHY driver supports only DisplayPort. This patch
> > > series prepares Torrent PHY driver so that different multilink
> > > configurations can be supported. It also updates DT bindings
> > > accordingly. This doesn't affect ABI as Torrent PHY driver has never
> > > been functional, and therefore do not exist in any active use case.
> > >
> > > Support for different multilink configurations with register sequences
> > > for protocols above will be added in a separate patch series.
> > 
> > Series looks good to me.
> > 
> > > This patch series is dependent on PHY attributes patch series [1].
> > 
> > I did not see any obvious depends in the series, if it is not maybe good to
> > rebase and send without dependency
> > 
> 
> Sure. I will resend the series removing dependency.

I have applied the PHY attributes patch series, but dt patch has some
comments, please fix that and repost

-- 
~Vinod
