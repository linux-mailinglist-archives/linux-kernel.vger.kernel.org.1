Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5762DCDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgLQIm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgLQImw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:42:52 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608194531;
        bh=K5TpauZ4unbflmWR1wNk26qVBnFQLI8jNAWmDDLGxaw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Zo3fLIi50f3ruUiwUn0Kre3b1yecBzjdOvaWXxPG+e9FnyM4UFcFpa2CWh5a8JcVv
         +2/CI7j6S79OabM2VklORgz1neZcvOUOeknYcvGnL9+DD6/fh4GCSV3G1JyQj3QvRk
         hfJvQ6bkJFLLrHSGrE9wGiF1XTP76iMbgTPuLFYUuuJds7XYopccySkolFaV0ULmLv
         Np9g4prSycYyXkOPLdsri71ZPPTVUo9XLWkRw5W/2foK0Qmj8o5Oy5Au5Zqy7jDSOv
         JmG4KoI2u4AgK2bLJcFChBXse1vZh7UY8ZyA/TyCnEZPuh4KpC7dnfQVhUqAlAznak
         Bx5l8h3AvZpYA==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605256192-31307-1-git-send-email-weiyi.lu@mediatek.com>
References: <1605256192-31307-1-git-send-email-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v3] clk: mediatek: Make mtk_clk_register_mux() a static function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Thu, 17 Dec 2020 00:42:10 -0800
Message-ID: <160819453018.1580929.7663364756931158614@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2020-11-13 00:29:52)
> mtk_clk_register_mux() should be a static function
>=20
> Fixes: a3ae549917f16 ("clk: mediatek: Add new clkmux register API")
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-next
