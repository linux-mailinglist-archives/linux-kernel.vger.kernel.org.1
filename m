Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9BD1E528B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 03:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgE1BBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 21:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgE1BBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:01:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0CBB208B8;
        Thu, 28 May 2020 01:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590627697;
        bh=CxBnyEySoxB08leWTQx73PJ4rDx9yvuvCPRoL/+Ej7I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YrZvYmxkaX7ctkiek/h8zEef593zZ3+w0+yLIkdsuKI3thRyt2+Tklf2aWXkSLHs9
         wPitpsGSnOug3ONN78YxqDPa0INBnIn45bowt5ofxVLk2unMOELb0GhxWbBEyvz8z8
         wO139FLO1Gt436SHvCOGwmKDAEWAjo04K2+UHD8k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519224151.2074597-12-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk> <20200519224151.2074597-12-lkundrak@v3.sk>
Subject: Re: [PATCH v3 11/13] clk: mmp2: Add support for power islands
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Wed, 27 May 2020 18:01:36 -0700
Message-ID: <159062769688.69627.6085466493600393511@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-05-19 15:41:49)
> Apart from the clocks and resets, the PMU hardware also controls power
> to peripherals that are on separate power islands. On MMP2, that's the
> GC860 GPU and the SSPA audio interface, while on MMP3 also the camera
> interface is on a separate island, along with the pair of GC2000 and GC300
> GPUs and the SSPA.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-next
