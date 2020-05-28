Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A231E6FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 01:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391474AbgE1XBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 19:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgE1XAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:00:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B002074B;
        Thu, 28 May 2020 23:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590706855;
        bh=BjaPhLv7o3F9Baq35hcGqpi0Mk/SufIcuOaMQDHCS9c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=P1T6h3goNb5Pe3t56fZFSyff4JfuW/pOATL+5x9+iVegZ36QKcaKYkXyDv4SHfVni
         6kqffzJuvKhBpf2ykGLzze2sZd3t2q3qPKdPHu9zxEdxyGjY+Kh++JBtn/MOOK46yL
         jaGpjXBITmL//5+If8qr08n/sGIkENepKN4yDNws=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200528221219.535804-1-colin.king@canonical.com>
References: <20200528221219.535804-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] clk: intel: remove redundant initialization of variable rate64
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 28 May 2020 16:00:54 -0700
Message-ID: <159070685467.69627.16613075011399178571@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2020-05-28 15:12:19)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable rate64 is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next
