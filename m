Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0CB2CA894
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgLAQpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgLAQpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:45:20 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07454C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zclhRxSb9+y0XMSIjcT31hSNmgYF3XT/Tz4gRdIjVo8=; b=WuCviSTfjeYikqFDZu8+w6tn46
        Beueo3XPclImx5zS92/e1vvSm2omf3ZyGMlZElFrOvjo0/u1NxNusXMiKErqDcADfq09X8yHubnoD
        fnuLZUtPSSAD5W84Hbfv+aoDP0az/alAocHzsbIkRFAJZfRzaSLHpHBDEzyWyZkiTe0c=;
Received: from p200300ccff124e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:4e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kk8lW-00021b-05; Tue, 01 Dec 2020 17:44:34 +0100
Date:   Tue, 1 Dec 2020 17:44:33 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [Letux-kernel] [BUG] SPI broken for SPI based panel drivers
Message-ID: <20201201174433.2000c8a3@aktux>
In-Reply-To: <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
        <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
        <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com>
        <20201201121620.GB5239@sirena.org.uk>
        <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com>
        <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
        <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com>
        <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 11:10:49 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> Nikolaus,
> 
> On Tue, Dec 1, 2020 at 9:38 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >
> > Let's work on a fix for the fix now.
> >  
> 
> Are you quite sure the chip-select of the tpo,td028ttec1 panel
> is active-high? A quick google produced a datasheet which
> seems to indicate that XCS is active-low?
> 
Schematics is here:
https://projects.goldelico.com/p/gta04-main/downloads/48/

The display connector P204-LCD indicates some inversion at the XCS and
XRES pins.

This patch fixes things for a boot where the display was not
touched by the bootloader
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index c8745bc800f7..003202d12990 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -124,7 +124,6 @@
                        spi-max-frequency = <100000>;
                        spi-cpol;
                        spi-cpha;
-                       spi-cs-high;
 
                        backlight= <&backlight>;
                        label = "lcd";

So if that one is really active-low, why did it ever work?!

Regards,
Andreas
