Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6F02AACB5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgKHSA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:00:56 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43875C0613CF;
        Sun,  8 Nov 2020 10:00:56 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E7E6822F99;
        Sun,  8 Nov 2020 19:00:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604858450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5mdmJCjp3mWQK68q4UXJyoMZpxRwtUapcv3lDuVJZQ=;
        b=kxsySbbeaBZxeiWbEjD7dj0jUhLWxVscCHqHal5CeXliKmIzchULDHZy6Nifh7GocJqhTC
        4l+iS0yg5OFwpvuDFAgVYeV/7jeYxZKZv+J7QKi63xjCIgrDGmdmuH+YJHiurikIhSr5Q3
        d9ADQYoT3WHZbhYkHmVzSWKBFAjuh3A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 08 Nov 2020 19:00:46 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Ioana Ciornei <ioana.cionei@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] arm64: dts: fsl-ls1028a-kontron-sl28: specify in-band
 mode for ENETC
In-Reply-To: <20201101131905.8316-1-michael@walle.cc>
References: <20201101131905.8316-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <b2b33b89e0f363344fc3b036e58d5cdc@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2020-11-01 14:19, schrieb Michael Walle:
> Since commit 71b77a7a27a3 ("enetc: Migrate to PHYLINK and PCS_LYNX") 
> the
> network port of the Kontron sl28 board is broken. After the migration 
> to
> phylink the device tree has to specify the in-band-mode property. Add
> it.
> 
> Fixes: 71b77a7a27a3 ("enetc: Migrate to PHYLINK and PCS_LYNX")
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>

Ping. will this go through the net queue or Shawn's queue. In any case,
it should make it into a fixes queue, because this board is currently
broken in 5.10-rc2.

Thanks,
-michael
