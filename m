Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35D32B30CC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKNUys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:54:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKNUys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:54:48 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB16622409;
        Sat, 14 Nov 2020 20:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605387287;
        bh=cE3qj2/4CwlQNpuMAyK8r2L5qjswJHbnUptf9S9E3Io=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BORxj4mynClyqsmCszaZu++rmmXi3S4gROmc/wjqY1aimmqnwzswL9WQqrY5AErX8
         qbX4IZNpH704ff00fsSb0grksSvbKgPEgWqKcJVHNpDdWr20rnV/8/2ZwM3+qKg7gI
         j8sCpPJx6LLj1s5Ov0Ic7JGuOjDYM2z0G40/A0qI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201021162147.563655-4-jbrunet@baylibre.com>
References: <20201021162147.563655-1-jbrunet@baylibre.com> <20201021162147.563655-4-jbrunet@baylibre.com>
Subject: Re: [PATCH v2 3/3] clk: meson: g12: drop use of __clk_lookup()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Nov 2020 12:54:46 -0800
Message-ID: <160538728665.60232.8766919681942166161@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-10-21 09:21:47)
> g12 clock controller used __clk_lookup() to get struct clk from a
> struct clk_hw. This type of hack is no longer required as CCF now provides
> the necessary functions to get this.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next
