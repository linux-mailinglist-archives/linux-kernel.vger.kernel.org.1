Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677AA1E345C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 03:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgE0BDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 21:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgE0BDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:03:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB2420888;
        Wed, 27 May 2020 01:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590541402;
        bh=L8D3Mt2ic80N/BfYGvtKAAnSlms9gGMG6yYwHNvf/JM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ePmFt/T05flUISMih64oKPY8Qdm0yPx466a1bP9trG2UQ2+Q1XJdr0SgQ3DFeJuBx
         JyPlAWB9KtlMahp+9yo47Ud98gEMDkpjBm91Jp5qXKm3Fp/hzji2HXTPK7xeAw+GOC
         Ed9Io2Jb5v/x7FlrY8GUZhzTYLUvATVXfCwWuvpI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200527010057.57877-1-sboyd@kernel.org>
References: <20200527010057.57877-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: zynqmp: Mark zynqmp_clk_get_max_divisor() static
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jolly Shah <jolly.shah@xilinx.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 26 May 2020 18:03:21 -0700
Message-ID: <159054140141.88029.6524841404404802642@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-05-26 18:00:57)
> This function isn't used outside this file. Mark it static to silence
> sparse.
>=20
> Cc: Jolly Shah <jolly.shah@xilinx.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
