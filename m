Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD342D17EB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLGRy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGRy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:54:27 -0500
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BE1C061749;
        Mon,  7 Dec 2020 09:53:46 -0800 (PST)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6CB545C0054;
        Mon,  7 Dec 2020 18:53:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1607363623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkGJj4xRtLjLHi9uk2lHu+eJLiMO4r8tHRe6lcpmSbI=;
        b=raPdImDDTIiegSJWjc9kp0oB2+0DxMTvr7V45zgBlwAyRvQvZJYeV65YXexfMT6YySjMio
        MGhyV6XVgfS3gjot5iY7Kan2RfqSx8D5JVuEZYvwkQiluiOdbExVol7zVEQkdAw6hGsPfm
        IP1eU/sZ3VORqVBeqt08uRn3tapwSQ0=
MIME-Version: 1.0
Date:   Mon, 07 Dec 2020 18:53:43 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, robh+dt@kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        christianshewitt@gmail.com, jian.hu@amlogic.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ARM: dts: meson: fix PHY deassert timing
 requirements
In-Reply-To: <CAFBinCA_eaJHv7e+8ZM=z=zUZ9uQY_JZ=618=LwJYM-Gi+OO+g@mail.gmail.com>
References: <14754fd95378b78eb9a0a3f8b6bab13f7263c7f1.1606828668.git.stefan@agner.ch>
 <6bfe17d86ead62c20d236e2ebbc7b7fe3354829d.1606828668.git.stefan@agner.ch>
 <CAFBinCA_eaJHv7e+8ZM=z=zUZ9uQY_JZ=618=LwJYM-Gi+OO+g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <1275fb519490b00a079ac832277585f1@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-05 14:04, Martin Blumenstingl wrote:
> Hi Stefan,
> 
> On Tue, Dec 1, 2020 at 2:21 PM Stefan Agner <stefan@agner.ch> wrote:
>>
>> According to the datasheet (Rev. 1.9) the RTL8211F requires at least
>> 72ms "for internal circuits settling time" before accessing the PHY
>> egisters. On similar boards with the same PHY this fixes an issue where
> there's a typo here: it should be "registers"
> this is the same for the other four patches also

Whoops, will send v3 shortly.

> 
>> Ethernet link would not come up when using ip link set down/up.
> I have never experienced that myself but gotten a few reports about this.
> thank you very much for coming up with info from the datasheet!
> 
> the following stmmac patch [0] has been added recently which may - or
> may not - have any impact also.

Thanks for the hint, wasn't aware of that.

--
Stefan

> 
>> Fixes: a2c6e82e5341 ("ARM: dts: meson: switch to the generic Ethernet PHY reset bindings")
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> with above typo fixed:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> and also:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
> on Odroid-C1+
> 
> 
> Best regards,
> Martin
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/ethernet/stmicro/stmmac?id=56311a315da7ebc668dbcc2f1c99689cc10796c4
