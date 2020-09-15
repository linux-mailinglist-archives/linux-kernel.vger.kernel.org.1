Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2A269A82
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgIOAlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgIOAlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:41:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E61212CC;
        Tue, 15 Sep 2020 00:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600130506;
        bh=uxCPfJNVgMohbUsHKkLu93CrrC8rl/5bWo2Jsljjnso=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=A1e9GEM7+UQyGoPeKHeVcScMwYaIHNqDfSfbTd7eEpHzlVR9trnqZIJw16D4SCxZ+
         vd24TRd0YtIaquOqEcc4kfXgWzcpzRhnL61m3EXW5PIWkdPE0CRRZxMRx+tGeXl/y3
         XgVctsY13wUpy0C+IiSmkz+Xim/brzRqZYBNXAt0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200914022225.23613-2-zhangqing@rock-chips.com>
References: <20200914022225.23613-1-zhangqing@rock-chips.com> <20200914022225.23613-2-zhangqing@rock-chips.com>
Subject: Re: [PATCH v4 1/6] clk: rockchip: Use clk_hw_register_composite instead of clk_register_composite calls
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Date:   Mon, 14 Sep 2020 17:41:44 -0700
Message-ID: <160013050497.4188128.14223866096412684497@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elaine Zhang (2020-09-13 19:22:20)
> clk_hw_register_composite it's already exported.
> Preparation for compilation of rK common clock drivers into modules.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
