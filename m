Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8161F2D1D02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgLGWOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbgLGWOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:14:41 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607379241;
        bh=X/PnSas8sLIZGzQjdY/GTgXT2nJNu4Cpd14sexT9VME=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MrFKKlhD74KF3Uq7NUCXhGBjOlNP8WVcHPtjXxp0d8XhyjiDC1H7BUhTgqsut18VB
         0YnphHJkhHorrsUtsTyCJRHm1/X71nnuqwtQTlCSbcYLqojghDczBxPYprLzAc5ATn
         5VnKzH8ipgNZUpm55LoylAZz/6I5eKRZkHQxktrOlvLei0yZAyPide3TyTr9xzXPTL
         l5HLb2DOhlj8QRNJRuUdV5Sio4R+k60OsPJ3p194dq9Fb66NcYxVk9ufyCCGmI6iKI
         583BjmuaZMFc7NjATjPY61MK9srivQU2kpJxDaTMp+fTkaH2tN6gEAgzl/WPTEeTJc
         jMST8rTtNmq9g==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201105192746.19564-4-michael@walle.cc>
References: <20201105192746.19564-1-michael@walle.cc> <20201105192746.19564-4-michael@walle.cc>
Subject: Re: [PATCH v2 3/3] clk: fsl-sai: use devm_clk_hw_register_composite_pdata()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>
To:     Michael Walle <michael@walle.cc>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Dec 2020 14:13:59 -0800
Message-ID: <160737923980.1580929.5525130660855551561@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Walle (2020-11-05 11:27:46)
> Simplify the driver by using that helper and drop the remove() function.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Applied to clk-next
