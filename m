Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C324227205
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 00:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGTWLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 18:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGTWLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:11:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2577720773;
        Mon, 20 Jul 2020 22:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595283097;
        bh=mp7rqCoERPxKbSLsXNuvtXLRpOJK597vkiWFBuYTInI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NXl5R15rldenuSTEFUAn/sdxHNhTokqGAv2bj/X1vxxKbwQsUHXNgx2kMsCQtIgVj
         RelQDDEyDsUS0ANyRP9rdVI9DjBYeujQiIDIMXCjlSZEJSJO3mmAF68YUwHABwDpv+
         gkKwVte7wEHlreD/ZGxTuN3ebojffHr4LXEYoqko=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200719002830.20319-1-rdunlap@infradead.org>
References: <20200719002830.20319-1-rdunlap@infradead.org>
Subject: Re: [PATCH] clk: <linux/clk-provider.h>: drop a duplicated word
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date:   Mon, 20 Jul 2020 15:11:36 -0700
Message-ID: <159528309635.1987609.2848027294515219304@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2020-07-18 17:28:30)
> Drop the repeated word "not" in a comment.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> ---

Applied to clk-next
