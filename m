Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7892C36A2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgKYCPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKYCPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:15:02 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D0F2075A;
        Wed, 25 Nov 2020 02:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606270501;
        bh=aNkhkC1HJ7u96zWRmzOGh8EchI0HxA2iC0PeVNtialg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Sif6kaXiKXeLp9f1dpVGuPEfTIqowSCmv2+Y2D2pBINKvoP6CIB4i25cyHbfV2KjJ
         rfMK1FXJTbFlUJey6olmPA/faigziofQh6dsn19wbbt+OZlRHzl9UA1Tl9DHCOw0tx
         ThS53v0hCjqCOj1kTHc1ZxxtpGMimCmByQJyvaNw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b362195a-665d-5e1d-4c6e-26cbc2459777@gmail.com>
References: <20201104134810.21026-1-digetx@gmail.com> <160538861846.60232.2236874455363048014@swboyd.mtv.corp.google.com> <b362195a-665d-5e1d-4c6e-26cbc2459777@gmail.com>
Subject: Re: [PATCH v1] clk: tegra30: Use 300MHz for video decoder by default
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Tue, 24 Nov 2020 18:15:00 -0800
Message-ID: <160627050023.2717324.14379148787162509458@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2020-11-15 06:10:04)
> 15.11.2020 00:16, Stephen Boyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Quoting Dmitry Osipenko (2020-11-04 05:48:10)
> >> The 600MHz is a too high clock rate for some SoC versions for the video
> >> decoder hardware and this may cause stability issues. Use 300MHz for t=
he
> >> video decoder by default, which is supported by all hardware versions.
> >>
> >> Fixes: ed1a2459e20c ("clk: tegra: Add Tegra20/30 EMC clock implementat=
ion")
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >=20
> > Should this go to clk-fixes? Thierry?
> >=20
>=20
> Either way should be good. The fix isn't critical because 600MHz seems
> to be working okay on unsupported hardware.
>=20
> Potentially this could vary depending on a board, but then I don't think
> that there are actively-supported boards which would notice this change.
>=20

Ok sounds like Thierry can pick it up.
