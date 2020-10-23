Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB2297311
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbgJWQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374472AbgJWQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:06 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C78C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:01:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gs25so3106703ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DyGg3gcEdd7vVuYPrQClO5KAJpAA5gDXU1ptZfURHvY=;
        b=Pbf40pcHKFKlyOHLd4EWBv4sodfIgF8V+H8Cha+8allK4g0xU7Xi/r96ve1d9S3IGt
         XdHrwxPt8G8hHAq89DFOqm0Goiaqlh7gfvQbhXKXxCpCMcdlTTj6hVN9IbwAnwI1TR01
         IVvdDvndWDNG5vI1Rd11fLfltFfbMr5tLli0yW5tv/k6x5zZSrLS/3w2GvRpWtM+o7fU
         Lid78f2R+jyXr7k8239gfoDS0hKsKB7LL6pJGKbvB6iGX4Ljw29zSh8urdffBWCLcc4Z
         rXG+GebL5eyTPVRxs/1lJjsrQDUJacGL7XxICniTiAHlP2U+JB9gQkc9CwpqUhOY3M2k
         IN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DyGg3gcEdd7vVuYPrQClO5KAJpAA5gDXU1ptZfURHvY=;
        b=cC9NY7U9LHpWzqZL6Yst22uP3sLbyq3qkUUjosniYh9ut5Eb4s3FNixLwSztMiNW+g
         UAkRdmULkGndD4f2xdu10vxKAttJer7NP0raS/rOGLZQzuSHQ72CEYK2W1uh8QOxTbW3
         gW7Xdx8AGjpwh37MIRDEDlmUKg1hWV40ofEqYjhgt3zqXy5DVyxymI7sukXbM3P6PPUQ
         3hng+2R9tfEaKO6Axynv3fApVq35TKOFBexCztaWWLR6X3j4WWkvTBV/7XgO+v/65boI
         Hk+pZz2lk1Z+XbLazMqnX90MTy7TpmNvvqilzg3ymtLwuDv2zMLObmNYQy1GNCqiNzRr
         dz1A==
X-Gm-Message-State: AOAM532yMMdPdksXjY3NbJ060u/iYxrw4kl1LiAbKBAlosUrbH4w5C5p
        sK11EocAqGhAaxWy5mwxAhV8
X-Google-Smtp-Source: ABdhPJwO9EfnNYDyInb7p38bcKuoYTX7GZUUeRlfBrR0b8ekDAjjffa+KHcRQc16j6VvMf8sKb71bA==
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr2634614ejf.466.1603468864263;
        Fri, 23 Oct 2020 09:01:04 -0700 (PDT)
Received: from localhost.localdomain ([213.149.61.126])
        by smtp.gmail.com with ESMTPSA id u18sm1048504ejn.122.2020.10.23.09.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:03 -0700 (PDT)
From:   Vladimir Vid <vladimir.vid@sartura.hr>
To:     pali@kernel.org, a.heider@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tmn505@gmail.com,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, robh+dt@kernel.org,
        Vladimir Vid <vladimir.vid@sartura.hr>
Subject: Re: [PATCH] arm64: dts: marvell: add DT for ESPRESSObin-Ultra
Date:   Fri, 23 Oct 2020 18:18:02 +0200
Message-Id: <20201023161802.265575-1-vladimir.vid@sartura.hr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201009152710.316047-1-vladimir.vid@sartura.hr>
References: <20201009152710.316047-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 5:37 PM Pali Rohár wrote:
> Cannot you in this case include armada-3720-espressobin.dtsi and write
> only differences into DTS ultra file to reduce definitions?

> Currently there are pending patches for espressobin DTS files to
> simplify them and use common include file as much as possible to
> de-duplicate same parts.

Updated in v2.

> Looks like this is incorrect as on Armada 3720 at the beginning of the
> nor must be stored Marvell wtmi/secure firmware which is running on
> Cortex M3 processor. For sure there cannot be u-boot. Also on A3720 is
> u-boot loaded by ARM trusted firmware therefore I doubt that u-boot is
> stored at offset zero.

> I guess that on offset zero is stored concatenated binary of Marvell
> secure firmware for M3, ARM trusted firmware (for main CPU) and U-Boot.
> Can you verify it? In this case I would just call this partition as
> "firmware" to indicate what is stored here.

Correct. Concatenated binary you get from building u-boot and ATF, which
includes wtmi, is flashed to offset zero.
I agree that firmware is more appropriate name for the partition,
updated in v2.


On Mon, Oct 12, 2020 at 9:08 AM Andre Heider wrote:
> the other espressobin boards use "Globalscale Marvell ESPRESSOBin
> Board", so maybe "Globalscale Marvell ESPRESSOBin Ultra Board"?

Updated in v2.

>> > +                     partition@3e0000 {
>> > +                             label = "hw-info";
> any idea what's in there?

SPI is used insted of the EEPROM to save some hardware related info,
currently there are MAC addresses and serial number on that partition.

>> > +&usb3 {
>> > +     status = "okay";
>> > +     usb-phy = <&usb3_phy>;
>
> That node comes from armada-37xx.dtsi and has:
>
>        phys = <&comphy0 0>, <&usb2_utmi_otg_phy>;
>        phy-names = "usb3-phy", "usb2-utmi-otg-phy";
>
> Are those supposed to be mixed?

No, I don't think they should. I originally added dts for the 4.19
and there weren't usb2 related nodes there.
I'm disabling usb3 for the moment until I see what's going on,
as I'm currently working on adding u-boot support and a couple
of other things.

For the other comments, I think they are resolved by including
the espressobin dtsi instead of armada-37xx.
