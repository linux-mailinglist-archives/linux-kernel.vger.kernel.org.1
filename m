Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4058F1C6106
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 21:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgEET2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 15:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEET2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:28:10 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E7E0206B9;
        Tue,  5 May 2020 19:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588706890;
        bh=usynuOR1E69N5AJk67ILaNhdKMo/Dyy/RKGLkmis1xo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Avl9qAu9qsa4YCgPnESVnktkOzDptTWX6NQHwh9lYOc2aJ7DhJG17FctXiT2JyEvW
         9zFKeFyDYRgQcaA9Bn9KYPyLAIkzocXgfD4eJVo33wK2MLz0WqtTiaAKbte0UIWMt+
         4T0CI5y6LNp7WKc+rFZtFesD+36ygm8Gf0YWc1Qo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200505083001.52564-1-yuehaibing@huawei.com>
References: <20200505083001.52564-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: Remove unused inline function clk_debug_reparent
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, mturquette@baylibre.com
Date:   Tue, 05 May 2020 12:28:09 -0700
Message-ID: <158870688968.26370.16781214256369290362@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2020-05-05 01:30:01)
> There's no callers in-tree anymore.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next
