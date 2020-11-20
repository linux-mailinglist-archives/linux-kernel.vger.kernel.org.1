Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7DF2BA6FE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgKTKFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:05:03 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:46247 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgKTKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:05:02 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6548122ED8;
        Fri, 20 Nov 2020 11:05:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1605866700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLNtQHPovGmP6KYC9ugg59vXCNbSx3IadlDGAURrO74=;
        b=t9nOOiZ1fumOIlmBHAZD5eUQjVFoV+AWmptcb6ybiiXcerX7fH2xKiqwZnHUY7lAnBx7c5
        l3+b6zUqnf0XHI6v3mcHcI8/CA7bd1KZzBP+Bnki7RkZvgUZVbQ6Skpv5D0sY7t79PJy07
        /b2Gs5Ebd/44Pp82Ybf6ql18DCcHvQ8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Nov 2020 11:05:00 +0100
From:   Michael Walle <michael@walle.cc>
To:     Ashish Kumar <ashish.kumar@nxp.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v3 4/9] arm64: dts: ls1028a: use constants in the clockgen
 phandle
In-Reply-To: <HE1PR04MB319630198F85E59B2547046095FF0@HE1PR04MB3196.eurprd04.prod.outlook.com>
References: <20201108185113.31377-1-michael@walle.cc>
 <20201108185113.31377-5-michael@walle.cc>
 <HE1PR04MB319684750CF7D1920DCCCDD095FF0@HE1PR04MB3196.eurprd04.prod.outlook.com>
 <08b751d01cfc82fcfe425833793dcda9@walle.cc>
 <HE1PR04MB319630198F85E59B2547046095FF0@HE1PR04MB3196.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <0e0970485dc410acc9c96962ef14bb38@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashish,

Am 2020-11-20 10:51, schrieb Ashish Kumar:
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: Friday, November 20, 2020 3:09 PM
>> To: Ashish Kumar <ashish.kumar@nxp.com>
>> Cc: linux-clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Michael
>> Turquette <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>;
>> Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Leo
>> Li <leoyang.li@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; Xiaowei Bao
>> <xiaowei.bao@nxp.com>; Vladimir Oltean <vladimir.oltean@nxp.com>
>> Subject: [EXT] Re: [PATCH v3 4/9] arm64: dts: ls1028a: use constants 
>> in the
>> clockgen phandle
>> 
>> Caution: EXT Email
>> 
>> Hi Ashish,
>> 
>> Am 2020-11-20 10:25, schrieb Ashish Kumar:
>> > I am not able to apply this patch cleanly, does it have any dependency
>> > patch that I have missed?
>> 
>> What is your base? I've just tried to apply this series (stand-alone) 
>> onto linux-
>> next and it applied cleanly.
> I used https://github.com/torvalds/linux.git should I try this
> git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git ?

Mh, I just tried clk-next. clk-next is missing some device tree changes. 
So,
parts of this series should go through the soc tree (shawnguo) and some 
through
clk-next (or acked by Stephen Boyd).

If you want to apply it, use the for-next branch of the soc tree:
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git

-michael
