Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F24B2B30DD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKNU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:59:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgKNU7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:59:02 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E30C2242E;
        Sat, 14 Nov 2020 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605387541;
        bh=Q/efP1kGS+jsxpxCjbrpMp46zOMO6NBBfhlTQC48S3U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EulDwzCP91i3YffAk71DBxovy0/kqT0HY1Mdk00feZum6Iy7Ka21QsrpdKAg+dG+e
         gWfN6Xf5VrG3im/YqPohFdC7RA5Oji0pOX+dL8rzRYvj6nu8mZ2fzf3ESAwDgweDGJ
         ScbWIPHdztjPdGMmyD+rzVIQucbfow8zheeKNqkI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201021163847.595189-3-jbrunet@baylibre.com>
References: <20201021163847.595189-1-jbrunet@baylibre.com> <20201021163847.595189-3-jbrunet@baylibre.com>
Subject: Re: [PATCH 2/2] clk: meson: g12: use devm variant to register notifiers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Date:   Sat, 14 Nov 2020 12:59:00 -0800
Message-ID: <160538754041.60232.477564298644612511@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-10-21 09:38:47)
> Until now, nothing was done to unregister the dvfs clock notifiers of the
> Amlogic g12 SoC family. This is not great but this driver was not really
> expected to be unloaded. With the ongoing effort to build everything as
> module for this platform, this needs to be cleanly handled.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next
