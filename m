Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E22730BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgIUROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgIUROY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:14:24 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76C720758;
        Mon, 21 Sep 2020 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600708464;
        bh=jPXdpHJkSl25fQoyZON2j0z0ifjF9rzRPXwPQatNkyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAXaWSBYMfEohj9PQP23laak9G/7ldEX+XWOFTMYaDVdskcHwA7n89K+bEf+NLbm8
         HK9KWRCs2Avu0qnmKVllg+ol7lyJBzWOtyL41g3jJ0MD6iORwcgar1wSFEXbfxe556
         AQwGVuQ2JB4mG6WLBj3VfHin0iDYxdLbURuak4BM=
Received: by pali.im (Postfix)
        id B83C27BF; Mon, 21 Sep 2020 19:14:21 +0200 (CEST)
Date:   Mon, 21 Sep 2020 19:14:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andre Heider <a.heider@gmail.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Get rid of duplicate
 serial aliases
Message-ID: <20200921171421.qvp2x3syuh6zph34@pali>
References: <20200921164830.499548-1-a.heider@gmail.com>
 <20200921165357.yvajlsb6cjojbqqc@pali>
 <670c25da-9a3a-9d67-dcc6-bd839235574a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <670c25da-9a3a-9d67-dcc6-bd839235574a@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 September 2020 18:57:46 Andre Heider wrote:
> On 21/09/2020 18:53, Pali Rohár wrote:
> > On Monday 21 September 2020 18:48:30 Andre Heider wrote:
> > > The included armada-372x.dtsi already defines these two aliases.
> > 
> > Where? I do not see it in that file:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> 
> Oh sorry, it's in armada-37xx.dtsi:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/marvell/armada-37xx.dtsi#n20

Ok, with fixing file in commit message you can add my:

Reviewed-by: Pali Rohár <pali@kernel.org>

> > 
> > > 
> > > Signed-off-by: Andre Heider <a.heider@gmail.com>
> > > ---
> > > 
> > > This goes on top of Pali's patch:
> > > "arm64: dts: marvell: espressobin: Add ethernet switch aliases"
> > > 
> > > The resulting .dtb files are the same.
> > > 
> > >   arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 2 --
> > >   1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> > > index 0775c16e0ec8..3169a820558f 100644
> > > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> > > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> > > @@ -17,8 +17,6 @@ aliases {
> > >   		ethernet1 = &switch0port1;
> > >   		ethernet2 = &switch0port2;
> > >   		ethernet3 = &switch0port3;
> > > -		serial0 = &uart0;
> > > -		serial1 = &uart1;
> > >   	};
> > >   	chosen {
> > > -- 
> > > 2.28.0
> > > 
> 
