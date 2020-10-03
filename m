Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B9282397
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 12:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgJCK2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJCK2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 06:28:16 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DFAC0613D0;
        Sat,  3 Oct 2020 03:28:15 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z5so3521319ilq.5;
        Sat, 03 Oct 2020 03:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBsmjSqeSDnUq/wXsywhtKhAGsAUjZOjWyQ2zwJAJ+I=;
        b=gAxEMV/XHOdyJcTDCJD0AJ4BKE0x4hX/GlTKbyxoWjSpTs6XKvRlaf+b2Xl+kg1bK6
         rovQg3xugq3TmcKp4hyOUKJxAmVLOx/Lvm/AJcwNoNygmTNuYYgalQlj8nbv/ph8MlJ+
         yd4sVZw5qo2EHLOCv4mvvbhjDIAuNlTNpcA8RTg5QrLYJxk1uO85YqmayFh8VLmHUVJF
         A537ERm1QgKNOd66qPWvgykbkaha7EeK6cdDXBWpo6gwHzXdeUBX649eXcnYPmfSw48s
         mKBicFV2ToYzG6pyQyrMOUQ2b73tX++uh9JxgfBjCvaV8LGr/PmpHgMc9lx7e+4tVHDl
         //4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBsmjSqeSDnUq/wXsywhtKhAGsAUjZOjWyQ2zwJAJ+I=;
        b=O+WVL5PEGXy3j0ZQMrsv0DiLrtDQDDsEPCDN3YOTj0K2k7k31RSQj4Q1yOl9+vZBoO
         C6+kmQTdhe7IQa3lBfH/vktX2piLDQVljUz7FJQnyCK2gPiBOOAvvn6haZZfH38JyT0H
         Fiiby1bUgVkoUKyR6TMQ5sz+UmdWUUljeu0J4xaiENkc5T0X6GMrYKzAnZbvVc0GR88I
         RzJ+pqXG0nuvY5jF/UYMHMbK+vVsNNo3ZigxLV9wBygE9DYNB3MEpj8p7vHi+4RPZVA+
         d5/NmjhGjS7vdeM+olaz9FgTynqsAXcPJZdsqYnwVBT5QPxIB/uTTIz4zX/w50ZPtyZZ
         jbHw==
X-Gm-Message-State: AOAM531VMWb4gxcIpA/5shxzzR3lBZptZbowNIJ+yClzB1r66hZMpd+l
        wpQnmFxXFvC2Yz5JCrQrj5RaxTdnr2viHWOckH8=
X-Google-Smtp-Source: ABdhPJwjpz/AJCpQXQDHAkGoISZAtb6oqNV+fPGPz2JztJLv8YRazwu+iungfHHNUb5/qFAai88PVQagSl5us5kCuOA=
X-Received: by 2002:a92:d68b:: with SMTP id p11mr4781440iln.59.1601720895001;
 Sat, 03 Oct 2020 03:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200923005709.147966-1-icenowy@aosc.io> <20200925151241.kfmytlff4grswtzh@gilmour.lan>
In-Reply-To: <20200925151241.kfmytlff4grswtzh@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 3 Oct 2020 12:28:03 +0200
Message-ID: <CAJiuCceT3NxwYSZKkCbMy5kfxgyN+iZcRwtHEorg6xGNnFhZzw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 0/7] Pine64 PineCube support
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was running dtbs_check and found this series introduced new warnings.

  DTC     arch/arm/boot/dts/sun8i-s3-pinecube.dtb
  DTC     arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml
  CHECK   arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible: ['allwinner,sun8i-v3s-system-control',
'allwinner,sun8i-h3-system-control'] is not valid under any of the
given schemas (Possible causes of the failure):
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible: Additional items are not allowed
('allwinner,sun8i-h3-system-control' was unexpected)
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun4i-a10-sram-controller' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun5i-a13-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun7i-a20-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun8i-a23-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun8i-h3-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun8i-r40-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun50i-a64-sram-controller' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun50i-a64-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun50i-h5-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,sun50i-h6-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:0: 'allwinner,suniv-f1c100s-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:1: 'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:1: 'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:1: 'allwinner,sun50i-a64-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
compatible:1: 'allwinner,sun4i-a10-system-control' was expected

From schema: /Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: camera@1cb4000: port:
'#address-cells', '#size-cells' do not match any of the regexes:
'pinctrl-[0-9]+'
From schema: /Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml

And also some other boards
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:
['allwinner,sun8i-v3s-system-control',
'allwinner,sun8i-h3-system-control'] is not valid under any of the
given schemas (Possible causes of the failure):
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible: Additional items are not allowed
('allwinner,sun8i-h3-system-control' was unexpected)
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun4i-a10-sram-controller' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun5i-a13-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun7i-a20-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun8i-a23-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun8i-h3-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun8i-r40-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-a64-sram-controller' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-a64-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-h5-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-h6-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,suniv-f1c100s-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun50i-a64-system-control' was expected
/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun4i-a10-system-control' was expected

From schema: /Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:
['allwinner,sun8i-v3s-system-control',
'allwinner,sun8i-h3-system-control'] is not valid under any of the
given schemas (Possible causes of the failure):
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible: Additional items are not allowed
('allwinner,sun8i-h3-system-control' was unexpected)
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun4i-a10-sram-controller' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun5i-a13-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun7i-a20-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun8i-a23-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun8i-h3-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun8i-r40-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-a64-sram-controller' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-a64-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-h5-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-h6-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,suniv-f1c100s-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun50i-a64-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun4i-a10-system-control' was expected

From schema: /Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:
['allwinner,sun8i-v3s-system-control',
'allwinner,sun8i-h3-system-control'] is not valid under any of the
given schemas (Possible causes of the failure):
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible: Additional items are not allowed
('allwinner,sun8i-h3-system-control' was unexpected)
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun4i-a10-sram-controller' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun5i-a13-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun7i-a20-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun8i-a23-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun8i-h3-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun8i-r40-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-a64-sram-controller' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-a64-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-h5-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,sun50i-h6-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:0:
'allwinner,suniv-f1c100s-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun4i-a10-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun50i-a64-system-control' was expected
/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
system-control@1c00000: compatible:1:
'allwinner,sun4i-a10-system-control' was expected

Regards,
Clement

On Fri, 25 Sep 2020 at 17:12, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Wed, Sep 23, 2020 at 08:57:02AM +0800, Icenowy Zheng wrote:
> > Pine64 PineCube is an IP camera based on Allwinner S3 chip.
> >
> > This patchset tries to add support for it.
> >
> > In order to make sure the system do not hang when camera is brought up,
> > a fix to AXP209 driver is needed (sent individually), otherwise the
> > system will hang because it changes the voltage of LDO2 when LDO4
> > tweaking.
>
> Queued all the patches for 5.11
>
> > Icenowy Zheng (7):
> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add Ethernet support
> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for UART2 RX/TX
> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add CSI1 device node
> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for 8-bit parallel CSI
> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for I2C1 at PE bank
> >   dt-bindings: arm: sunxi: add Pine64 PineCube binding
> >   ARM: dts: sun8i: s3l: add support for Pine64 PineCube IP camera
>
> However, I guess for the next patches to the v3s DTSI we should just
> have a simpler prefix (like v3), it's really taking a lot of characters
> here :)
>
> Maxime
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200925151241.kfmytlff4grswtzh%40gilmour.lan.
