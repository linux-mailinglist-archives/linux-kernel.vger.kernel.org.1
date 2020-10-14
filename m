Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C0128D8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgJNCyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgJNCyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:54:40 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F12621775;
        Wed, 14 Oct 2020 02:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602644080;
        bh=EKQgleS0X90DVJpSDecC+giPdCh+T5pBAVG7aaq6pgk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BFTsU0wdA4s4b5IOJyKoyCQEcSKqquTRqJ8FP8vUzBGFuMHcnaPeaGr0pAj6Okn0s
         KiFpGbn7LJlyua+zZjiv+sJd5/cazdHTxocB5wYZtqKPsw2C09qiNV7gLfA4qkffAX
         fANrHVmksA1HBlILEGFr/gPuur55+nrYcReeilvk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200921034522.9077-1-vulab@iscas.ac.cn>
References: <20200921034522.9077-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] clk: clk-prima2: fix return value check in prima2_clk_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
To:     Xu Wang <vulab@iscas.ac.cn>, baohua@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com
Date:   Tue, 13 Oct 2020 19:54:39 -0700
Message-ID: <160264407937.310579.8734202361386358321@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xu Wang (2020-09-20 20:45:22)
> In case of error, the function clk_register() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
>=20
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---

Applied to clk-next
