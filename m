Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BFB2DCEE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgLQJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgLQJxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:53:51 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608198790;
        bh=usPP9SaeAamb8nglviOVWGoU62GiIJ1WkK3NJY5Ee3o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rcSyiTMpK/CIUipGdT+d9hR6x2BLowDP07Qpb3cNE6cpTWXPccbgrVsaSfeV7WU8b
         zjWidbxGhm8bTYzVD4enYTxPvWrhmhxlI8GKZCxL8PAwiigf8j3hbqxEhqTeXs2ZzL
         pUqrQWKsibECGczX7hrgeeVjdUY1x+MN6BeWf+04lRLn7OHxP473q7qIt8iSFb6lPO
         lD50eituSkiWRLcWbu8CPVDC+rGTU9NsiXRIv3FDBeZ49ShrghdyVmQwlu9UHP47Vx
         Vs/EVlH6KU+mp9BvOCxKN8Ksri3eaeDXSYvzlCWIZy5s6n3wreZ71EIYau7uANhoVt
         uzrXfuEFlgNCg==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201203074037.26940-1-alexandru.ardelean@analog.com>
References: <20201203074037.26940-1-alexandru.ardelean@analog.com>
Subject: Re: [RESEND PATCH 1/2] clk: axi-clkgen: wrap limits in a struct and keep copy on the state object
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, mdf@kernel.org, lars@metafoo.de,
        ardeleanalex@gmail.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Dec 2020 01:53:09 -0800
Message-ID: <160819878921.1580929.15203556505418978794@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Ardelean (2020-12-02 23:40:36)
> Up until the these limits were global/hard-coded, since they are typically
> limits of the fabric.
>=20
> However, since this is an FPGA generated clock, this may run on setups
> where one clock is on a fabric, and another one synthesized on another
> fabric connected via PCIe (or some other inter-connect, and then these
> limits need to be adjusted for each instance of the AXI CLKGEN.
>=20
> This change wraps the current constants in 'axi_clkgen_limits' struct and
> the 'axi_clkgen' instance keeps a copy of these limits, which is
> initialized at probe from the default limits.
>=20
> The limits are stored on the device-tree OF table, so that we can adjust
> them via the compatible string.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---

Applied to clk-next
