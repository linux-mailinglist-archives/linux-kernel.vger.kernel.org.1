Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1622AB3D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgKIJnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:43:09 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39089 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgKIJnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:43:06 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4A7CE22F2D;
        Mon,  9 Nov 2020 10:43:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604914983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TISJX/0g0eTQvbb/iznKAoeAEUeQtZ4L3gDonZPa6fg=;
        b=HGsjjCZPzp70oOWnoVY8PrIEv7hr8tj+nm0oJ/1dojWxsXcVt6k5hCgWmYJ+/AFRjB/7ZE
        PCfR4oD41OaBZ45/z/uJvrZVZZYgLDRIhZox1LVKW5sEmwIXNz1he47uZv/z1Uas62R8Uo
        8Qf37A0U3oSZij/OmMi+CTJq3yDTXXQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Nov 2020 10:43:03 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [RFC PATCH v3 9/9] arm64: dts: lx2160a: fix FlexSPI clock
In-Reply-To: <20201108212139.ht22zdk27pyxv6wc@skbuf>
References: <20201108185113.31377-1-michael@walle.cc>
 <20201108185113.31377-10-michael@walle.cc>
 <20201108212139.ht22zdk27pyxv6wc@skbuf>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <0e165232e518c0f6c1b894311f00982a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-08 22:21, schrieb Vladimir Oltean:
> On Sun, Nov 08, 2020 at 07:51:13PM +0100, Michael Walle wrote:
>> Now that we have a proper driver for the FlexSPI interface use it. 
>> This
>> will fix SCK frequency switching on Layerscape SoCs.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> Thanks to Vladimir Oltean, this was partially tested on a LX2160A RDB. 
>> But
>> this patch is marked as RFC nonetheless, because there is too much
>> difference in the clock tree between LS1028A and LX2160A. It would be 
>> nice
>> if someone could test it and add a Tested-by.
> 
> You want someone to probe the SCK frequency?

No not really, just a thorough test.

> I expect that if frequency
> switching works on LS1028A, and the lx2160a_flexspi_divs table is
> correct (which, based on the documentation for 
> FlexSPICR1[FlexSPI_CLK_DIV],
> it is), then it would work on LX2160A too?

The switching should work. Finding out wether it is correct can be 
checked
by reading the raw register value, i.e. 01E0_0900h. But the parent clock 
is
what is bothering me a little. Getting that wrong would lead to a wrong 
SCK
output frequency albeit the divider is set to a correct value.

> Is there a simple test that can be made in order to trivially determine
> whether the frequencies are correct?

We already found out that there seems to be kind of a saturation with
higher frequencies, i.e. octal SPI bus is capable of a much higher
throughput but we only achieve 50MB/s. I'd have expected a much higher
datarate (I mean it is advertised as high performance and it uses a 8 
bit
wide databus..). But anyway, it might make sense to go the other way, 
i.e.
find out the max datathroughput at lower frequencies and look if it 
makes
sense. Assuming no DDR, the throughput should be around your frequency. 
For
example, having 4 MHz should result in 4MB/s data throughput.

OTOH we already saw that after linux booted - with the current device 
tree
which has a setting of 50MHz max SCK frequency - the programmed divider 
by
my driver is the same as the former setting (0x13, div-by-32); so this 
series
doesn't change the SCK frequency.

-michael
