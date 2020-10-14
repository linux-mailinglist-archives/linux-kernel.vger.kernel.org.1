Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755AB28D8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 05:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgJNDGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 23:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbgJNDGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 23:06:21 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F3DD21D81;
        Wed, 14 Oct 2020 03:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602644781;
        bh=a1qRdTz/lcqXNzkAmcqGL99L7xdzaI6+wrUHD6Z6AvM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=imfnQLpmJ2qLem0nSa5G4CDIaMjcguKbm8No2Z+ybZ8fNQcsonRbGMqe2lwSrabYM
         moJKO7+BW+CBF6ZMNMqn3qnorrRYV6gh8hKEjCNM9OYKUz8fmSYWDiq6cLjAO9eKH6
         ePQRNtftjDtutBB0SJv5ydK1+mrfQuijLNW22tO0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200903015048.3091523-2-paul@crapouillou.net>
References: <20200903015048.3091523-1-paul@crapouillou.net> <20200903015048.3091523-2-paul@crapouillou.net>
Subject: Re: [PATCH 2/5] clk: ingenic: Use readl_poll_timeout instead of custom loop
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
Date:   Tue, 13 Oct 2020 20:06:20 -0700
Message-ID: <160264478008.310579.11071970752908561687@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2020-09-02 18:50:45)
> Use the readl_poll_timeout() function instead of rolling our own
> busy-wait loops. This makes the code simpler.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next
