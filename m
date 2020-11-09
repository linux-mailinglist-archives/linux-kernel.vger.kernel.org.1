Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E472AB551
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgKIKsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbgKIKsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:48:08 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B59C0613CF;
        Mon,  9 Nov 2020 02:48:08 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E941122F99;
        Mon,  9 Nov 2020 11:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604918886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ve1WZOzCwXpc+NCuMVGH5np7irgjes6c6130blo2a4=;
        b=qbDsg698naXNQksfB0IJQIyGQEf7wxsU0o7kSHL/KW10tgP6MkVdQVtHA5ar3/TMlBogPT
        iDbs8r2PoC0xoHHXKPkyjU1OJJ+r1EfAknyafNB6rK9BQhtNei5bK3vwFmc2unTKw+uLZZ
        /a5jnxOyAtsI4xzlVXZJnrgxCNViVtE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Nov 2020 11:48:05 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Ioana Ciornei <ioana.cionei@nxp.com>
Subject: Re: [PATCH net] arm64: dts: fsl-ls1028a-kontron-sl28: specify in-band
 mode for ENETC
In-Reply-To: <20201109104605.vzg2dt572krlijpk@skbuf>
References: <20201101131905.8316-1-michael@walle.cc>
 <b2b33b89e0f363344fc3b036e58d5cdc@walle.cc>
 <20201109104605.vzg2dt572krlijpk@skbuf>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <b73145462b236479629d6635533a6c0a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-09 11:46, schrieb Vladimir Oltean:
> On Sun, Nov 08, 2020 at 07:00:46PM +0100, Michael Walle wrote:
>> Hi,
>> 
>> Am 2020-11-01 14:19, schrieb Michael Walle:
>> > Since commit 71b77a7a27a3 ("enetc: Migrate to PHYLINK and PCS_LYNX") the
>> > network port of the Kontron sl28 board is broken. After the migration to
>> > phylink the device tree has to specify the in-band-mode property. Add
>> > it.
>> >
>> > Fixes: 71b77a7a27a3 ("enetc: Migrate to PHYLINK and PCS_LYNX")
>> > Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> > Signed-off-by: Michael Walle <michael@walle.cc>
>> 
>> Ping. will this go through the net queue or Shawn's queue. In any 
>> case,
>> it should make it into a fixes queue, because this board is currently
>> broken in 5.10-rc2.
> 
> Michael, this cannot go through the net queue, since you didn't copy
> netdev@vger.kernel.org to the email. It's not in Jakub's patchwork. My
> advice would be to resend it.

Oh damn. Thanks!

-michael
