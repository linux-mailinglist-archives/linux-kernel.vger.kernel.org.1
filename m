Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7350B28D8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgJNCp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgJNCpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:45:55 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2DD21D7F;
        Wed, 14 Oct 2020 02:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602643555;
        bh=Vmd0CmZFFvwgWUePY58hR4eTLv249vTRyUrqzaAvxe8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FRSW+qEsO/GLGv+eK7mShYFyeLPKGMhAbKvn3q/SVYxf49h5goMHNoKWiGD6V98/s
         lyima7z68raNoa9HrtSU/jX+11c5RfA3FwpMjIti1DKYKBGIvRjuA2WnMEptZyPkB6
         NbV2TqvjajjjFE/IG+3YOG97+dHZ7dr2PPjpSXXs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201001085948.21412-2-alexandru.ardelean@analog.com>
References: <20201001085948.21412-1-alexandru.ardelean@analog.com> <20201001085948.21412-2-alexandru.ardelean@analog.com>
Subject: Re: [PATCH 2/2] clk: axi-clkgen: Set power bits for fractional mode
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     lars@metafoo.de, mturquette@baylibre.com, mdf@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Oct 2020 19:45:53 -0700
Message-ID: <160264355396.310579.8796379397875326505@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Ardelean (2020-10-01 01:59:48)
> From: Lars-Peter Clausen <lars@metafoo.de>
>=20
> Using the fractional dividers requires some additional power bits to be
> set.
>=20
> The fractional power bits are not documented and the current heuristic
> for setting them seems be insufficient for some cases. Just always set all
> the fractional power bits when in fractional mode.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---

Applied to clk-next
