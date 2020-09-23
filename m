Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A5275D30
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIWQTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWQTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:19:33 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 366F520719;
        Wed, 23 Sep 2020 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877972;
        bh=TZLW6wHGCKieqihCO7hlRfnrIi0AXUV6iu39Wm/82bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1AYq7PaX3t9xhMD2CVFqcMTSOMNmJnEIfoXDBvCmRZRWw/estSl1pqpwlK0fWOoBF
         jvq5qJe4Q/wkYORAGIwUwtJjTjphxnTN2bQktgFCoaPvYEHA31daTk2TXpa5eJR3CI
         B5MvgyeRDc1b57GzTp+iZ1Ch7V+XdTx7Mq/5+p4I=
Received: by pali.im (Postfix)
        id 8192DD0F; Wed, 23 Sep 2020 18:19:29 +0200 (CEST)
Date:   Wed, 23 Sep 2020 18:19:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Andre Heider <a.heider@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
Message-ID: <20200923161929.2qiqvlnxoj45jzjg@pali>
References: <20200907112718.5994-1-pali@kernel.org>
 <20200907144228.GV3112546@lunn.ch>
 <20200907145213.fwlyz4k6scible7x@pali>
 <20200907154353.GW3112546@lunn.ch>
 <20200907161316.xd5svvahi5xusdlw@pali>
 <20200907172345.GB3254313@lunn.ch>
 <20200908074733.f33pwtreojzobivq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200908074733.f33pwtreojzobivq@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 September 2020 09:47:33 Pali Rohár wrote:
> On Monday 07 September 2020 19:23:45 Andrew Lunn wrote:
> > On Mon, Sep 07, 2020 at 06:13:16PM +0200, Pali Rohár wrote:
> > > On Monday 07 September 2020 17:43:53 Andrew Lunn wrote:
> > > > > I would not say it is a "new feature". But rather that patch in this
> > > > > email fixes issue that Linux kernel did not set correct MAC address for
> > > > > DSA slave ports. I think it is something which could be backported also
> > > > > to stable releases as "ignoring" vendor/factory MAC address is not
> > > > > correct behavior.
> > > > 
> > > > Hi Pali
> > > > 
> > > > The rules for stable are here:
> > > > 
> > > > https://www.kernel.org/doc/html/v5.8/process/stable-kernel-rules.html
> > > > 
> > > > Do you think it fits?
> > > > 
> > > >    Andrew
> > > 
> > > Hello Andrew! I think it fits into those rules. As I wrote it fixes real
> > > bug that Linux kernel does not use correct MAC address for particular
> > > DSA slaves / ethernet ports.
> > 
> > O.K, then:
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> >     Andrew
> 
> Ok! Andrew, I would like to ask another question, how to correctly
> define that this patch depends on a2c7023f7075c? I specified it in
> human-readable part of commit description, but for backporting it would
> also need some machine-readable format. So patch would not be
> occasionally backported to older/stable kernel where a2c7023f7075c is
> not available.

Based on stable-kernel-rules.html document I think that following line
should define this dependency in machine readable format:

Cc: <stable@vger.kernel.org> # a2c7023f7075c: dsa: read mac address

Gregory, if it is correct, would you add that line into commit sign-off
area where is existing Fixes: line?
