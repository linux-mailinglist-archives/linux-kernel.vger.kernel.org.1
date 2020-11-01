Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682D12A2118
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 20:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgKAT0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 14:26:09 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:55275 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgKAT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 14:26:09 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Nov 2020 14:26:08 EST
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4445622EDE;
        Sun,  1 Nov 2020 20:26:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604258767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwOicBjV46xtXtMgV/IJzP18ENIIoNPVjVzUDZtDg4Q=;
        b=m8yASFD3CWKKJk20mKVBVfBtgpKdycVQaCpsbNGWoHIyKD35XV0UYz6ymHuYZSK03QN9Bv
        2AXY3KHblomexAZ5ETutFR21fuk8hdYleeivMCT4Sud5oM+s9JPo6eoRlPrMz8EfBux0To
        BDukJpIuZ5SDJRUSgZ9+Kr69RmGiaPE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 01 Nov 2020 20:26:07 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 1/4] dt-bindings: clock: document the fsl-flexspi-clk
 driver
In-Reply-To: <20201101192053.18644-1-michael@walle.cc>
References: <20201101192053.18644-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <4011caa68fe04fcd41f44038bf6b6e5c@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I've forgot the cover letter. Next version will have one.

On Layerscape SoCs which feature the FlexSPI controller there is
a single register which can control the divider value. The base
frequency is the platform PLL.

Right now the LS1028A and the LX2160A aren't able to switch the
SCK frequency on the FlexSPI interface. Add a new clock driver
which operate on said register.

-michael
