Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F825F0F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 00:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgIFWpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 18:45:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38392 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgIFWpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 18:45:16 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kF3PM-0002dZ-EJ; Mon, 07 Sep 2020 00:45:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v3 1/6] clk: rockchip: Use clk_hw_register_composite instead of clk_register_composite calls
Date:   Mon, 07 Sep 2020 00:45:11 +0200
Message-ID: <5177967.q6s5TDtO4a@diego>
In-Reply-To: <20200904074405.24439-2-zhangqing@rock-chips.com>
References: <20200904074405.24439-1-zhangqing@rock-chips.com> <20200904074405.24439-2-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. September 2020, 09:44:00 CEST schrieb Elaine Zhang:
> clk_hw_register_composite it's already exported.
> Preparation for compilation of rK common clock drivers into modules.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


