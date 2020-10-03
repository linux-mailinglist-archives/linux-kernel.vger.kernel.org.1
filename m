Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7C2823A7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 12:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJCKjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 06:39:55 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:54452 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgJCKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 06:39:50 -0400
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id B89D9260EB;
        Sat,  3 Oct 2020 10:39:41 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 379573ECDF;
        Sat,  3 Oct 2020 12:39:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 13C142A504;
        Sat,  3 Oct 2020 12:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1601721579;
        bh=E7649IyCQuyRGfzApIhktnFuqMRxFFiazJNaGXsQzfg=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=vOKfQ5k1pZGTW8854nOwkV/86Zbt5DSEhzv2dMhMvqGeLhd/UeXVu/HAeWI39KAH+
         vtBpekQzMDmSS5b2rzWT6CUdwF9xxPUm8Q73WDp35FU8NvE5lTSiCyLL0DJnWoKT9t
         vA8rZg1SZV0DdXIDMrIO8amFR+vQkmz+TsvB5uUo=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K2Q-rOHx49m6; Sat,  3 Oct 2020 12:39:37 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat,  3 Oct 2020 12:39:37 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 533B241C9E;
        Sat,  3 Oct 2020 10:39:35 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="g56jyzaV";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 747EB41C9E;
        Sat,  3 Oct 2020 10:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1601721570; bh=E7649IyCQuyRGfzApIhktnFuqMRxFFiazJNaGXsQzfg=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=g56jyzaVDHHQKhUKGGQzT1F9m40VFnubKo9cUAt6qWO25N/xl19SFUzPU5UlKp8px
         rOnD625jQHYY7FWU44ewS2I+l0IfsBSitkhvFUWShRhUzcFImyw1Wt82QOu3HoJVpW
         Ni8FwuZDh5fzJBcgusH9Ra6tyDWSfbjalWRE1cMQ=
Date:   Sat, 03 Oct 2020 18:39:16 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJiuCceT3NxwYSZKkCbMy5kfxgyN+iZcRwtHEorg6xGNnFhZzw@mail.gmail.com>
References: <20200923005709.147966-1-icenowy@aosc.io> <20200925151241.kfmytlff4grswtzh@gilmour.lan> <CAJiuCceT3NxwYSZKkCbMy5kfxgyN+iZcRwtHEorg6xGNnFhZzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linux-sunxi] Re: [PATCH 0/7] Pine64 PineCube support
To:     peron.clem@gmail.com,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
CC:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <0BAFC9B7-DC42-469A-9C90-E25779678C07@aosc.io>
X-Rspamd-Queue-Id: 533B241C9E
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         FREEMAIL_TO(0.00)[gmail.com,cerno.tech];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B410=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=886=
:28:03, "Cl=C3=A9ment P=C3=A9ron" <peron=2Eclem@gmail=2Ecom> =E5=86=99=E5=
=88=B0:
>Hi,
>
>I was running dtbs_check and found this series introduced new warnings=2E
>
>  DTC     arch/arm/boot/dts/sun8i-s3-pinecube=2Edtb
>  DTC     arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml
>  CHECK   arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible: ['allwinner,sun8i-v3s-system-control',
>'allwinner,sun8i-h3-system-control'] is not valid under any of the
>given schemas (Possible causes of the failure):
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible: Additional items are not allowed
>('allwinner,sun8i-h3-system-control' was unexpected)
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun4i-a10-sram-controller' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun5i-a13-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun7i-a20-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun8i-a23-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun8i-h3-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun8i-r40-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun50i-a64-sram-controller' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun50i-a64-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun50i-h5-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,sun50i-h6-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:0: 'allwinner,suniv-f1c100s-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:1: 'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:1: 'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:1: 'allwinner,sun50i-a64-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: system-control@1c00000:
>compatible:1: 'allwinner,sun4i-a10-system-control' was expected
>
>From schema:
>/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-contro=
l=2Eyaml
>/arch/arm/boot/dts/sun8i-s3-pinecube=2Edt=2Eyaml: camera@1cb4000: port:
>'#address-cells', '#size-cells' do not match any of the regexes:
>'pinctrl-[0-9]+'
>From schema:
>/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi=2Eyaml

Is this broken schema?

>
>And also some other boards
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:
>['allwinner,sun8i-v3s-system-control',
>'allwinner,sun8i-h3-system-control'] is not valid under any of the
>given schemas (Possible causes of the failure):
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible: Additional items are not allowed
>('allwinner,sun8i-h3-system-control' was unexpected)
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun4i-a10-sram-controller' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun5i-a13-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun7i-a20-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun8i-a23-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun8i-h3-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun8i-r40-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-a64-sram-controller' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-a64-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-h5-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-h6-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,suniv-f1c100s-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun50i-a64-system-control' was expected
>/arch/arm/boot/dts/sun8i-s3-lichee-zero-plus=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun4i-a10-system-control' was expected
>
>From schema:
>/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-contro=
l=2Eyaml
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:
>['allwinner,sun8i-v3s-system-control',
>'allwinner,sun8i-h3-system-control'] is not valid under any of the
>given schemas (Possible causes of the failure):
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible: Additional items are not allowed
>('allwinner,sun8i-h3-system-control' was unexpected)
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun4i-a10-sram-controller' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun5i-a13-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun7i-a20-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun8i-a23-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun8i-h3-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun8i-r40-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-a64-sram-controller' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-a64-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-h5-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-h6-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,suniv-f1c100s-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun50i-a64-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun4i-a10-system-control' was expected
>
>From schema:
>/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-contro=
l=2Eyaml
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:
>['allwinner,sun8i-v3s-system-control',
>'allwinner,sun8i-h3-system-control'] is not valid under any of the
>given schemas (Possible causes of the failure):
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible: Additional items are not allowed
>('allwinner,sun8i-h3-system-control' was unexpected)
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun4i-a10-sram-controller' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun5i-a13-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun7i-a20-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun8i-a23-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun8i-h3-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun8i-r40-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-a64-sram-controller' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-a64-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-h5-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,sun50i-h6-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:0:
>'allwinner,suniv-f1c100s-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun4i-a10-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun50i-a64-system-control' was expected
>/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock=2Edt=2Eyaml:
>system-control@1c00000: compatible:1:
>'allwinner,sun4i-a10-system-control' was expected
>
>Regards,
>Clement
>
>On Fri, 25 Sep 2020 at 17:12, Maxime Ripard <maxime@cerno=2Etech> wrote:
>>
>> Hi,
>>
>> On Wed, Sep 23, 2020 at 08:57:02AM +0800, Icenowy Zheng wrote:
>> > Pine64 PineCube is an IP camera based on Allwinner S3 chip=2E
>> >
>> > This patchset tries to add support for it=2E
>> >
>> > In order to make sure the system do not hang when camera is brought
>up,
>> > a fix to AXP209 driver is needed (sent individually), otherwise the
>> > system will hang because it changes the voltage of LDO2 when LDO4
>> > tweaking=2E
>>
>> Queued all the patches for 5=2E11
>>
>> > Icenowy Zheng (7):
>> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add Ethernet support
>> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for UART2 RX/TX
>> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add CSI1 device node
>> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for 8-bit parallel
>CSI
>> >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for I2C1 at PE bank
>> >   dt-bindings: arm: sunxi: add Pine64 PineCube binding
>> >   ARM: dts: sun8i: s3l: add support for Pine64 PineCube IP camera
>>
>> However, I guess for the next patches to the v3s DTSI we should just
>> have a simpler prefix (like v3), it's really taking a lot of
>characters
>> here :)
>>
>> Maxime
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group=2E
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe@googlegroups=2Ecom=2E
>> To view this discussion on the web, visit
>https://groups=2Egoogle=2Ecom/d/msgid/linux-sunxi/20200925151241=2Ekfmytl=
ff4grswtzh%40gilmour=2Elan=2E
