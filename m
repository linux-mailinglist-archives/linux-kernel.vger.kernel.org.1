Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9651C201F20
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 02:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgFTAU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 20:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730804AbgFTAU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:20:26 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656C620675;
        Sat, 20 Jun 2020 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592612425;
        bh=p2V3pz6MGRWn+0XE8T3Abgd/qOk9UrSIMqV3HJOzcHE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tb4hQvTQgnv1PwqTflBrGghh7DlllJmBiKvHdtPCgRrzVnn5XUHb+W0L8MHGbHGhy
         QHicwJlitGJXjpYYv5vjGeziH+cfrH7F5zwg8fHinHIlMopQWOgP4QhDePZNTPpIoY
         c0efbkpD5BOJEwEK038fzTJZ7JpoPbQ2kyQXPrgk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <159261103077.62212.7410836804489183937@swboyd.mtv.corp.google.com>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <159255945796.62212.5838238989498858379@swboyd.mtv.corp.google.com> <bdc91c1b015d2f02bd0ea90ae81a122123c62b38.camel@suse.de> <159261103077.62212.7410836804489183937@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v5 00/27] clk: bcm: rpi: Add support for BCM2711 firmware clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, Tim Gover <tim.gover@raspberrypi.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Fri, 19 Jun 2020 17:20:24 -0700
Message-ID: <159261242477.62212.2251732478648139482@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-06-19 16:57:10)
> Quoting Nicolas Saenz Julienne (2020-06-19 02:44:54)
> > On Fri, 2020-06-19 at 02:37 -0700, Stephen Boyd wrote:
> > > Quoting Maxime Ripard (2020-06-15 01:40:40)
> > > > Hi,
> > > >=20
> > > > Since the whole DRM/HDMI support began to grow fairly big, I've cho=
sen
> > > > to split away the two discussions between the firmware clocks and t=
he
> > > > HDMI support.
> > > >=20
> > > > Let me know what you think,
> > > > Maxime
> > >=20
> > > Do you want this to go through clk tree? Or looking for acks/review
> > > tags?
> > >=20
> >=20
> > FWIW I don't mind taking the device tree changes trough the RPi soc tre=
e.
> >=20
>=20
> Sounds good.
>=20

Just to clarify, that is just the dts patch? Or the binding patches too?
