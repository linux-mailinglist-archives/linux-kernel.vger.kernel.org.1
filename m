Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07FD282452
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 15:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJCNhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgJCNhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 09:37:47 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091B0C0613D0;
        Sat,  3 Oct 2020 06:37:47 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m17so4507776ioo.1;
        Sat, 03 Oct 2020 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wYqZ60CRi7WWQ74ASFCAHaslnXG3wGOSLWDWZkKTjYo=;
        b=tPWJltg1jScIpFWxYL+05p6tCuq4yXeNokt99bo7HFw1ua3SsOw1Wno49JSsScY9IN
         /ifJ6mmNruhQFob+SpaGE/B+Pp3UAJP+4emb0r3FzrPrTe9pXnTfYGwfIdp5IXSkJSG2
         5n+e0FA6+J0xQvlpexsYrmnfT1CbejlPcSxP2gDPnAfmCoIOgpyh4C+Aijhk2dBrFd17
         Qw39N04i3J13RKL1xv2+VHelSKGPZnZ/H5tldckNYq+Rc2MeVVTa8rla/TpXiZRzR6O/
         5JY5yaggsLbrU9+OI9WqlUrZEO5GNenxsvYanUhqC2nbdDK27wXiB4CwVQPnRpoKvXm8
         VrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wYqZ60CRi7WWQ74ASFCAHaslnXG3wGOSLWDWZkKTjYo=;
        b=fl0svkYnb9PH8qVJWYJD0xJyyA0iaggmI5r9Ft76S26cXqfRTsoQ0yWsHV3e9s5v8d
         EjZTn8DS+aBtdXmBKaRFsyBXBxMFCfrBR7RGpe5pECj6WetYC6NgRmPaO1gEVmkNBlmx
         d50DSWphMiAMvfTshtlTkA9kYi7SI0Chq13KNB/ElNyCPdksmqXkKRwy5aBlBTzOXqhs
         zCMp92HPAVA/wCCer7H7F+RuvqrO2m4KenNUd1ck9r5TFGHOyWSBjezIfX5/aOT7BW3d
         aTavTzI1Zm7n9iXoDtQ+uVhqZKjkqO0juInuDsvoqi3KVMZlcwWqNAFKY/4JEOr0UMiO
         tv5Q==
X-Gm-Message-State: AOAM5322dWA6DcMLqmKemhWf+B7Vr0nLsIT77XAKmW41a5CE0ArS2wsJ
        rNXIHOJNSomgWO4/esLdEZs9I5lwKbz5lHW518Y=
X-Google-Smtp-Source: ABdhPJx5d4VojGRosUgPSFR6BdAe5SVBiaJXK+aM9zHdWEEEzYQf9FbVGI6VlrLXb2YaGo3FIcG+eWepM7XIsTZokcM=
X-Received: by 2002:a02:8791:: with SMTP id t17mr6046454jai.89.1601732265224;
 Sat, 03 Oct 2020 06:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200923005709.147966-1-icenowy@aosc.io> <20200925151241.kfmytlff4grswtzh@gilmour.lan>
 <CAJiuCceT3NxwYSZKkCbMy5kfxgyN+iZcRwtHEorg6xGNnFhZzw@mail.gmail.com> <0BAFC9B7-DC42-469A-9C90-E25779678C07@aosc.io>
In-Reply-To: <0BAFC9B7-DC42-469A-9C90-E25779678C07@aosc.io>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 3 Oct 2020 15:37:34 +0200
Message-ID: <CAJiuCcfB_cgP0YwWOeCtpbq+=SZi+12=BjaEe4ZSz2p8dHQZtg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 0/7] Pine64 PineCube support
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On Sat, 3 Oct 2020 at 12:39, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> =E4=BA=8E 2020=E5=B9=B410=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
6:28:03, "Cl=C3=A9ment P=C3=A9ron" <peron.clem@gmail.com> =E5=86=99=E5=88=
=B0:
> >Hi,
> >
> >I was running dtbs_check and found this series introduced new warnings.
> >
> >  DTC     arch/arm/boot/dts/sun8i-s3-pinecube.dtb
> >  DTC     arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml
> >  CHECK   arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible: ['allwinner,sun8i-v3s-system-control',
> >'allwinner,sun8i-h3-system-control'] is not valid under any of the
> >given schemas (Possible causes of the failure):
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible: Additional items are not allowed
> >('allwinner,sun8i-h3-system-control' was unexpected)
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun4i-a10-sram-controller' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun5i-a13-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun7i-a20-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun8i-a23-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun8i-h3-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun8i-r40-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun50i-a64-sram-controller' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun50i-a64-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun50i-h5-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,sun50i-h6-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:0: 'allwinner,suniv-f1c100s-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:1: 'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:1: 'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:1: 'allwinner,sun50i-a64-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: system-control@1c00000:
> >compatible:1: 'allwinner,sun4i-a10-system-control' was expected
> >
> >From schema:
> >/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-contr=
ol.yaml
> >/arch/arm/boot/dts/sun8i-s3-pinecube.dt.yaml: camera@1cb4000: port:
> >'#address-cells', '#size-cells' do not match any of the regexes:
> >'pinctrl-[0-9]+'
> >From schema:
> >/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
>
> Is this broken schema?

I think the #address-cells', '#size-cells' are not required here.
I had a quick look at other csi and nobody seems to specify this.

Just FYI This is what I did.
pip3 install git+https://github.com/devicetree-org/dt-schema.git@master
ARCH=3Darm make sunxi_defconfig
ARCH=3Darm make -j8 dtbs_check

Regards,
Clement

> >
> >And also some other boards
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:
> >['allwinner,sun8i-v3s-system-control',
> >'allwinner,sun8i-h3-system-control'] is not valid under any of the
> >given schemas (Possible causes of the failure):
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible: Additional items are not allowed
> >('allwinner,sun8i-h3-system-control' was unexpected)
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun4i-a10-sram-controller' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun5i-a13-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun7i-a20-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun8i-a23-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun8i-h3-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun8i-r40-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-a64-sram-controller' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-a64-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-h5-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-h6-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,suniv-f1c100s-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun50i-a64-system-control' was expected
> >/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun4i-a10-system-control' was expected
> >
> >From schema:
> >/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-contr=
ol.yaml
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:
> >['allwinner,sun8i-v3s-system-control',
> >'allwinner,sun8i-h3-system-control'] is not valid under any of the
> >given schemas (Possible causes of the failure):
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible: Additional items are not allowed
> >('allwinner,sun8i-h3-system-control' was unexpected)
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun4i-a10-sram-controller' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun5i-a13-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun7i-a20-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun8i-a23-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun8i-h3-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun8i-r40-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-a64-sram-controller' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-a64-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-h5-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-h6-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,suniv-f1c100s-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun50i-a64-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun4i-a10-system-control' was expected
> >
> >From schema:
> >/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-contr=
ol.yaml
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:
> >['allwinner,sun8i-v3s-system-control',
> >'allwinner,sun8i-h3-system-control'] is not valid under any of the
> >given schemas (Possible causes of the failure):
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible: Additional items are not allowed
> >('allwinner,sun8i-h3-system-control' was unexpected)
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun4i-a10-sram-controller' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun5i-a13-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun7i-a20-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun8i-a23-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun8i-h3-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun8i-r40-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-a64-sram-controller' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-a64-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-h5-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,sun50i-h6-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:0:
> >'allwinner,suniv-f1c100s-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun4i-a10-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun50i-a64-system-control' was expected
> >/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dt.yaml:
> >system-control@1c00000: compatible:1:
> >'allwinner,sun4i-a10-system-control' was expected
> >
> >Regards,
> >Clement
> >
> >On Fri, 25 Sep 2020 at 17:12, Maxime Ripard <maxime@cerno.tech> wrote:
> >>
> >> Hi,
> >>
> >> On Wed, Sep 23, 2020 at 08:57:02AM +0800, Icenowy Zheng wrote:
> >> > Pine64 PineCube is an IP camera based on Allwinner S3 chip.
> >> >
> >> > This patchset tries to add support for it.
> >> >
> >> > In order to make sure the system do not hang when camera is brought
> >up,
> >> > a fix to AXP209 driver is needed (sent individually), otherwise the
> >> > system will hang because it changes the voltage of LDO2 when LDO4
> >> > tweaking.
> >>
> >> Queued all the patches for 5.11
> >>
> >> > Icenowy Zheng (7):
> >> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add Ethernet support
> >> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for UART2 RX/TX
> >> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add CSI1 device node
> >> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for 8-bit parallel
> >CSI
> >> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for I2C1 at PE bank
> >> >   dt-bindings: arm: sunxi: add Pine64 PineCube binding
> >> >   ARM: dts: sun8i: s3l: add support for Pine64 PineCube IP camera
> >>
> >> However, I guess for the next patches to the v3s DTSI we should just
> >> have a simpler prefix (like v3), it's really taking a lot of
> >characters
> >> here :)
> >>
> >> Maxime
> >>
> >> --
> >> You received this message because you are subscribed to the Google
> >Groups "linux-sunxi" group.
> >> To unsubscribe from this group and stop receiving emails from it,
> >send an email to linux-sunxi+unsubscribe@googlegroups.com.
> >> To view this discussion on the web, visit
> >https://groups.google.com/d/msgid/linux-sunxi/20200925151241.kfmytlff4gr=
swtzh%40gilmour.lan.
