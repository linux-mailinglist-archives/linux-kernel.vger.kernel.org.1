Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9EF2D1D00
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgLGWOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:14:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgLGWOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:14:35 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607379235;
        bh=b8c3gJSYNP+zyxef9OIN6OKC059zdhGdsicePnOOh5o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=p7zMtQYtnfdyNwspyUC25HCqrI8JY46ckYVc82NKB7EeeLsVcOOduy3vBg/HAOd2n
         MtOheHL3SKnLBx1lNAvnmSK/2sYelsU+olr7EXHTRqrXazZBldrhktX1D+4h5ctMAW
         jTEW1jqNyxHVF5f7h7INolvr4SFsS8N02kv+Fp3jSshdSSL8M70RXFMlqg4Mkyi41H
         t+Lpfyp9dMWkziVUy+7sqFWg1BaR34bcPr7058uSutjmnK1Uh+0TQxYV3glYjNDEZn
         K1sR69aRpz1gYtLyWldVYBxvD2t0bdxDLNJWTZnFjdJhqWCLF0GAHuNVDCZLDZUGLE
         KB3q9uvYGfgPQ==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201105192746.19564-3-michael@walle.cc>
References: <20201105192746.19564-1-michael@walle.cc> <20201105192746.19564-3-michael@walle.cc>
Subject: Re: [PATCH v2 2/3] clk: composite: add devm_clk_hw_register_composite_pdata()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>
To:     Michael Walle <michael@walle.cc>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Dec 2020 14:13:53 -0800
Message-ID: <160737923399.1580929.5070466286090829142@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Walle (2020-11-05 11:27:45)
> This will simplify drivers which would only unregister the clk in their
> remove() op.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Applied to clk-next
