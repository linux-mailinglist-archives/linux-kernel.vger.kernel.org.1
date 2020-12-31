Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC52E7DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 03:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgLaCsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 21:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgLaCsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 21:48:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A782C061573;
        Wed, 30 Dec 2020 18:47:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r4so6265630wmh.5;
        Wed, 30 Dec 2020 18:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uUa8PGFvQ1Nvv0Amw2GKK2Th/K2C6f4QRsmd3CKEORY=;
        b=ey6xHkgPn+Tbwb+3sSG8iMG/XpU0ZmYxL3+LyHDbS74QzKq++QTCgb49u+3wRngW7T
         jmWkyNX80fFkddKnguVV9HRJ6FCsejW8tIl2JFEmUsBerN8DpNSYzMpn5S3YUTxaxLaL
         UDYzqzZLaXN6lgsn5jHro0U9SCbFVqLApd5b68rarc3YtIl+5q5zk7WIdoa6IbOAsNS1
         dADrXtgoeN8omD1ggMma3kUNpwE6ZlH4kcLfAwg4dE1DENw3+B67zm3CCepmepeO7xkk
         3X/Ju7T4XTqonKd45s3tatTAFm8YdIZ5ZAYv2mf1/WvGGGVSM9kctFtwP8ggzNHbuYaz
         LP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uUa8PGFvQ1Nvv0Amw2GKK2Th/K2C6f4QRsmd3CKEORY=;
        b=qK7DifVZhNjMXm7WoEtxXtgH3KTFOSaU4gdbXK2SnqMHopf4Udycn74j7HuBh2ba6K
         B5bvaPpS0wMpPjJzOeIv7HfAQvgQVCnkaI10jOmgTUVz1m/z1lg5V8pRLYAePIYhXc9H
         fzj+4486KFJ2pBgwwziqjyhBuAOzapGKfMaNl92xfqtBPw36WU+NqV08PsizP4Lhwnci
         s2pCX4UdO9k8OGI+o0wdAnGnzWKs9DW3hzkSTpNSfOO5NigT7504OJu50lvsW6XYNTbc
         qULmfOFJD+f/AV2T969jSrUftWNJoQtnb3xLv42KM+Qb+bhXMDVC3khAc01qRqnWE+pP
         1XXg==
X-Gm-Message-State: AOAM530CV58H0cUFIo3t6CRqWpALbtWP85sMYLxJ8o9IuBlfY/LlvpFw
        z2aqrg5tZlZISnEktnJP59i/sqqKffE7fQ==
X-Google-Smtp-Source: ABdhPJzPfV+OGIvkTCps1CXTf5mzKRTCy/Z2ALL44icJEGXDlTvkk+WIigwKnH0fS1+hlozjejxO5A==
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr9849152wmj.160.1609382870942;
        Wed, 30 Dec 2020 18:47:50 -0800 (PST)
Received: from [10.127.0.11] ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id b83sm10526090wmd.48.2020.12.30.18.47.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2020 18:47:50 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH v2 2/2] arm64: dts: meson: add initial Beelink GS-King-X
 device-tree
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CAFBinCCUV4piTy7n83GsV9Tny+JYA9_AXS0uiv5FeNPYejNR-Q@mail.gmail.com>
Date:   Thu, 31 Dec 2020 06:47:46 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D798BA5-B2C4-4F9E-BFAE-658C982741D6@gmail.com>
References: <20201230103729.2272-1-christianshewitt@gmail.com>
 <20201230103729.2272-3-christianshewitt@gmail.com>
 <CAFBinCCUV4piTy7n83GsV9Tny+JYA9_AXS0uiv5FeNPYejNR-Q@mail.gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31 Dec 2020, at 4:23 am, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> On Wed, Dec 30, 2020 at 11:38 AM Christian Hewitt
> <christianshewitt@gmail.com> wrote:
>>=20
>> The Shenzen AZW (Beelink) GS-King-X is based on the Amlogic W400 =
reference
>> board with an S922X-H chip.
>>=20
>> - 4GB LPDDR4 RAM
>> - 64GB eMMC storage
>> - 10/100/1000 Base-T Ethernet
>> - AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
>> - HDMI 2.1 video
>> - S/PDIF optical output
> are you planning to enable this also?

I plan to add this later (after v1 comments).

>> - 2x ESS9018 audio DACs
>> - 4x Ricor RT6862 audio amps
>> - Analogue headphone output
> there's no driver for that DAC so I think that's why you are not =
enabling them

ESS9018 is used with some Raspberry Pi DAC boards so there may be some =
prior
art to build upon. However it=E2=80=99s not clear (even with schematics) =
how the DAC
and AMP are controlled (they look like dumb input/output devices) so =
this is
still to be explored.

>> - 1x USB 2.0 OTG port
>> - 3x USB 3.0 ports
>> - IR receiver
>> - 1x micro SD card slot (internal)
>> - USB SATA controller with 2x 3.5" drive bays
>> - 1x Power on/off button
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> I don't know/have this board but also I don't see anything problematic =
so:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thx!=
