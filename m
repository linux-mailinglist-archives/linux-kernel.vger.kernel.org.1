Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBB269A89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgIOAmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgIOAmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:42:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EDEC21741;
        Tue, 15 Sep 2020 00:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600130533;
        bh=Qi+wZBAQJfjFjzNK36VfjuDr2/YFCbpYm+oub6MDfM4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mmmTSex8slsEgWeV3Wa9fiGtWNAWoMzbbOtA939NOCGpVgIBslx7Q2T7HrXDATMQp
         qhD7Yugzw+BULgoWPhMbWkeAhVLU5Z6u1rA5CWUjlk5RBqZ6QCYV3o9jeOgqgyF7YV
         QAgNsQFP2MkLD+YRDJvDBOi+xtAsebWBSUlhdDd8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200914022225.23613-5-zhangqing@rock-chips.com>
References: <20200914022225.23613-1-zhangqing@rock-chips.com> <20200914022225.23613-5-zhangqing@rock-chips.com>
Subject: Re: [PATCH v4 4/6] clk: rockchip: Export some clock common APIs for module drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Date:   Mon, 14 Sep 2020 17:42:12 -0700
Message-ID: <160013053207.4188128.5102937681760998236@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elaine Zhang (2020-09-13 19:22:23)
> This is used by the Rockchip clk driver, export it to allow that
> driver to be compiled as a module.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
