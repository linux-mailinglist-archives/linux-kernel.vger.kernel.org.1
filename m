Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790682F3AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392934AbhALTcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392856AbhALTcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:32:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E032D21534;
        Tue, 12 Jan 2021 19:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610479930;
        bh=mUAkOBZTzdb8S3dWdIOR4OR/orktbk11HiQdzqY0GXs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pCVeJV0xB4NDMpHqUv43QJezEMMYaPDm002HQzIDteOdJ11g+dj9nMoudqV47LioG
         g5m3nJExgAkTbogc6n+QzLZNmpn2O3w6kOS9vpyyKu6xHCq0G+eck9wWtcdAqcesSw
         w97vbuvty/z1fL7QgnyV3f1QW6DkRgFEpTMGEv1vgq5iAsraDaprdZcn7geBXj1koP
         uktaeOC4vKsXzSVLV9gpCcmEdISs+Xr/oqPFzb5uSoolpTahbs8iW2ZhFysomXDS4Y
         sDMWikv7ogPOaeHvCydLb9dxJskoacHnMITjGmdVyWfSCQ26oTHpXnvykTzZVm29XG
         Jk8WCxCp/oR8w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210103135503.3668784-1-arnd@kernel.org>
References: <20210103135503.3668784-1-arnd@kernel.org>
Subject: Re: [PATCH] clk: mmp2: fix build without CONFIG_PM
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 12 Jan 2021 11:32:08 -0800
Message-ID: <161047992867.3661239.5060019380091996342@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2021-01-03 05:54:53)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> pm_clk_suspend()/pm_clk_resume() are defined as NULL pointers rather than
> empty inline stubs without CONFIG_PM:
>=20
> drivers/clk/mmp/clk-audio.c:402:16: error: called object type 'void *' is=
 not a function or function pointer
>         pm_clk_suspend(dev);
> drivers/clk/mmp/clk-audio.c:411:15: error: called object type 'void *' is=
 not a function or function pointer
>         pm_clk_resume(dev);
>=20
> I tried redefining the helper functions, but that caused additional
> problems. This is the simple solution of replacing the __maybe_unused
> trick with an #ifdef.
>=20
> Fixes: 725262d29139 ("clk: mmp2: Add audio clock controller driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-fixes
