Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595BF2DCE29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgLQJRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgLQJRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:17:52 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608196631;
        bh=R6g6Z0pwtVwhv0Im1uYbyUOKndQuYTxtS1kTz8w3CJc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=O7Gyw1jcbJ/CpfCg4hWz3ZMw2SrNWUG/iITAIjuCC3tTZrMT6GXLS1c4sX58hOSqL
         unTtatDjyR7baUfWju+DhrS0Oak4C+arDvw+T6AWRhtmcvxi7vhh2qqoKFQreOgRQ1
         Nr44KiMSug9KTA+G5psEtpYcvgWArij2RPcA5NvpTTD3Ekb7G2qeCQcOJHUsrSxO3H
         w4TTIJvvXZzqPeNMXcy7Nn1m1Sd/9cZNK1ihR0inU8vQkF0NthUyHnoBQoEQPqRbwv
         3Y9YYSrYliYV0ZlGINCB7vyuFaL5svd2o3LY/gYlH9IJzGVoTxfnRoFeDh0Ut9gctf
         EXTx7aSuD7qtA==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1604888008-30555-1-git-send-email-weiyi.lu@mediatek.com>
References: <1604888008-30555-1-git-send-email-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v2 00/13] Clean up the pll_en_bit from en_mask on all the MediaTek clock drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Thu, 17 Dec 2020 01:17:10 -0800
Message-ID: <160819663020.1580929.10943444401319221382@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2020-11-08 18:13:15)
> This series is based on v5.10-rc1 and
> [v5,07/24] clk: mediatek: Fix asymmetrical PLL enable and disable control=
[1] in Mediatek MT8192 clock support series
>=20
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/1604887429-=
29445-8-git-send-email-weiyi.lu@mediatek.com/
>=20
> change since v1:
> - add patch for MT8167

The last patch doesn't apply. Also the whole series is base64 encoded
and confuses my MUA. Please resend.
