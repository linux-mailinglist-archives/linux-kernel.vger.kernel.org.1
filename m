Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA3D2C34AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbgKXXbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:31:14 -0500
Received: from relay3.mymailcheap.com ([217.182.119.155]:33902 "EHLO
        relay3.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbgKXXbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:31:14 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 9FEBC3F15F;
        Wed, 25 Nov 2020 00:31:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id C7DEC2A365;
        Tue, 24 Nov 2020 18:31:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1606260669;
        bh=DBqrNKR/Q9NCMag42Ouvl0axhCcPk0uK6vNXYyoOfbY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=y5J6VaXhTzq4FBHdcIqP3t4Iq0K7g2TQE67DE5OpuW4pozMntpcQpEiSj7z0HSZ7Q
         4pN89nxcY4D8buJWvmOJmIeD+V9vQgivfCQW1IzoGmrh00vwzklfGMMy6YGkRa79uJ
         q/MSQl4PLeQi/h+s+0XfWl2F4vYKmaIV1sYxrlxw=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9Bs2ZjAQznoD; Tue, 24 Nov 2020 18:31:09 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Tue, 24 Nov 2020 18:31:08 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id E04EF40FF4;
        Tue, 24 Nov 2020 23:31:07 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="tAUYc7AD";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 8FC5F40FF4;
        Tue, 24 Nov 2020 23:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1606260657; bh=DBqrNKR/Q9NCMag42Ouvl0axhCcPk0uK6vNXYyoOfbY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tAUYc7AD+hUA9g9ygr8w6y5fdfmySfroYZHIhZfGMLyDfwGcyBoQHv6uY87E4Rc+y
         tabaJC/25alqZTRLwhBm2l0LPjZOYAmLnu7iN0EREwissmZpq+LH2NkYNxitzUbL9Y
         7cB5ReOlrAcuXW3Vg3qO8KXMZtSnu70LN0+RRgOc=
Message-ID: <86cfbd41fe80b4936f20925aed0c9010806a0316.camel@aosc.io>
Subject: Re: [PATCH] ARM: dts: sun8i: s3: pinecube: add ethernet alias for
 Wi-Fi
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Date:   Wed, 25 Nov 2020 07:30:50 +0800
In-Reply-To: <20201124225940.3750388-1-icenowy@aosc.io>
References: <20201124225940.3750388-1-icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E04EF40FF4
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.143:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[7];
         DBL_PROHIBIT(0.00)[0.0.0.1:email];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-11-25星期三的 06:59 +0800，Icenowy Zheng写道：
> The PineCube board has a RTL8189ES Wi-Fi module on board, and the
> module
> doesn't have any MAC address programmed in.

Sorry, but now I'm unsure about this.

The module seems to have MAC address programmed.

> 
> Add a ethernet alias in the DT, thus the bootloader will then be able
> to
> generate a MAC address into the device tree node of Wi-Fi.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-s3-pinecube.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-s3-pinecube.dts
> b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
> index 4aa0ee897a0a..5086f713467a 100644
> --- a/arch/arm/boot/dts/sun8i-s3-pinecube.dts
> +++ b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
> @@ -13,6 +13,7 @@ / {
>  	compatible = "pine64,pinecube", "sochip,s3", "allwinner,sun8i-
> v3";
>  
>  	aliases {
> +		ethernet0 = &rtl8189es;
>  		serial0 = &uart2;
>  	};
>  
> @@ -156,6 +157,10 @@ &mmc1 {
>  	bus-width = <4>;
>  	non-removable;
>  	status = "okay";
> +
> +	rtl8189es: wifi@1 {
> +		reg = <1>;
> +	};
>  };
>  
>  &pio {
