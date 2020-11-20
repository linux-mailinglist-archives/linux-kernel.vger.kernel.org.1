Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270382BA65A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKTJjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgKTJjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:39:00 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36768C0613CF;
        Fri, 20 Nov 2020 01:39:00 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4D3CD22ED8;
        Fri, 20 Nov 2020 10:38:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1605865138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OH79VKiPwTHKvdKbU1089hjCnzkqbDxcW1xjlIlIFMA=;
        b=FWb+fHtiwaprOoFvehF5y5QFprDKkUdCM5Q8ZextMTs0yPgqkc3nVdn6bKdxXUR6ZG3uQ3
        fTdaj/z+Q40+GIcQkuZnK0pCAUTkYawiPWviBazKHpTetaYjRldQM0x1PUkgpjwWZqJ1tC
        R0/FkhhB+r1qsi4gL1vJdluQE4pq4oM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Nov 2020 10:38:58 +0100
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
In-Reply-To: <HE1PR04MB319684750CF7D1920DCCCDD095FF0@HE1PR04MB3196.eurprd04.prod.outlook.com>
References: <20201108185113.31377-1-michael@walle.cc>
 <20201108185113.31377-5-michael@walle.cc>
 <HE1PR04MB319684750CF7D1920DCCCDD095FF0@HE1PR04MB3196.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <08b751d01cfc82fcfe425833793dcda9@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashish,

Am 2020-11-20 10:25, schrieb Ashish Kumar:
> I am not able to apply this patch cleanly, does it have any dependency
> patch that I have missed?

What is your base? I've just tried to apply this series (stand-alone) 
onto
linux-next and it applied cleanly.

> My assumption is that this patch series is superset of
> Series 1: [1/4]  dt-bindings: clock: document the fsl-flexspi-clk 
> driver
> And
> Series 2:  [v2,1/5] clk: divider: add 
> devm_clk_hw_register_divider_table()

That is correct.

-michael
