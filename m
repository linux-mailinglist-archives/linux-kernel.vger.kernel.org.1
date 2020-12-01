Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7D2C99F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgLAIxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLAIxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:53:08 -0500
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B7C0613CF;
        Tue,  1 Dec 2020 00:52:27 -0800 (PST)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id ADAB25C0930;
        Tue,  1 Dec 2020 09:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1606812744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZodXyawqfmhzApkl+PJz1fcLX5uRiTYHumDpkFd5hs=;
        b=HyZ5RtOinN2JFcNOxIy7mUwszPE8yBz2bTjXwSg7YI9AYhS48fwqgF7k63oSRljnqgXwaZ
        yDM7I0Ezu53i6IXgVoVE0eZFMFMFkcQymy1HHV3Sqee1tAq8d9Kxj0U3OKt6BrFtW0+VOT
        JtZ84kbZotnZ6EBMS1pT37Hz4VDeoMw=
MIME-Version: 1.0
Date:   Tue, 01 Dec 2020 09:52:24 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: fix PHY deassert timing requirements
In-Reply-To: <1j8sai7wr0.fsf@starbuckisacylon.baylibre.com>
References: <e4df74aed2a7cff09366e72c87d408f41317907f.1606782187.git.stefan@agner.ch>
 <1j8sai7wr0.fsf@starbuckisacylon.baylibre.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <fd174decc948aa7a9c8cf62d23371480@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-01 09:31, Jerome Brunet wrote:
> On Tue 01 Dec 2020 at 01:25, Stefan Agner <stefan@agner.ch> wrote:
> 
>> According to the datasheet (Rev. 1.4, page 30) the RTL8211F requires
>> at least 50ms "for internal circuits settling time" before accessing
>> the PHY registers. This fixes an issue where the Ethernet link doesn't
>> come up when using ip link set down/up:
>>   [   29.360965] meson8b-dwmac ff3f0000.ethernet eth0: Link is Down
>>   [   34.569012] meson8b-dwmac ff3f0000.ethernet eth0: PHY [0.0:00] driver [RTL8211F Gigabit Ethernet] (irq=31)
>>   [   34.676732] meson8b-dwmac ff3f0000.ethernet: Failed to reset the dma
>>   [   34.678874] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
>>   [   34.687850] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_open: Hw setup failed
>>
>> Fixes: 658e4129bb81 ("arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY reset line")
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
>> index 6982632ae646..a5652caacb27 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
>> @@ -413,7 +413,7 @@ external_phy: ethernet-phy@0 {
>>  		max-speed = <1000>;
>>
>>  		reset-assert-us = <10000>;
>> -		reset-deassert-us = <30000>;
>> +		reset-deassert-us = <50000>;
>>  		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>>
>>  		interrupt-parent = <&gpio_intc>;
> 
> Thanks for sharing this is Stefan,
> The title of your patch should probably be modified to show that it
> addresses the odroid n2 only, as it stands.

Yes make sense. Hm, are there other boards with RTL8211F? From the
comments in the DT it seems several other boards use the same PHY. Some
however do not have any reset timing data at all currently it seems.

> 
> I have checked the RTL8211F doc I have, v1.9, and this one mention
> "72ms at least - not including the 1.0V supply rise time" before
> accessing the PHY registers :/ ... so 80ms maybe ?

Uh interesting, so it seems they increased it over documentation
revisions. Yeah agreed 80ms is the safer value then.

FWIW, I did test it with 50ms in a continuous loop for an hour or so
without seeing any failure, but that was room temperature only.

--
Stefan
