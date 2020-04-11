Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943171A4D78
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 04:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDKCVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 22:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgDKCVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 22:21:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC16D206A1;
        Sat, 11 Apr 2020 02:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586571665;
        bh=9FXFgoWgktV3YzcubxYjcxavPodS9HRGdrHbO04bwv0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TFt33anl8qdBEz00Cs6WAqt2RGnbP4oHNDorno+yXiSJ+ouo92cimWPsnINvMnhDI
         DvwwCOMxZ8GRdD/dAAimAuj+rLJ2MF0/BXl1qmE8OjyilWaW6UGEPZyp3IzIHezY3R
         JAyQxn27YSwSnP5/vFSamEAyFDeH/JXHePp90Yv0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200408020234.31764-1-zhang.lyra@gmail.com>
References: <20200331104532.12698-1-chunyan.zhang@unisoc.com> <20200408020234.31764-1-zhang.lyra@gmail.com>
Subject: Re: [PATCH] clk: sprd: don't gate uart console clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Fri, 10 Apr 2020 19:21:04 -0700
Message-ID: <158657166498.199533.13770774815921736950@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-04-07 19:02:34)
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> Don't gate uart1_eb which provides console clock, gating that clock would
> make serial stop working if serial driver didn't enable that explicitly.
>=20
> Fixes: 0e4b8a2349f3 ("clk: sprd: add clocks support for SC9863A")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---

Applied to clk-fixes
