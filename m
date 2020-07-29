Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18523173A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 03:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgG2B0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 21:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgG2B0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 21:26:21 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 424712076E;
        Wed, 29 Jul 2020 01:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595985981;
        bh=lM1qoyC9U2MvHLoqOZySr1gdzsZp4g88KX7WlYp4ZDE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WSs68bzC4ZcGQRzgEOs9B27CLhm6J8YTcQu1Mrw//bzRF9VHR/rTz3eC+AQjj/KwJ
         RbhEJEq2iEAecXRYivAp/sxSNdTtFGwcnGfvFNWycPQf1xl/B/VSon8oOszaoEWpD3
         atceaCSGrhBFbgHHRT1JC7K1c7XQGp5qF4kQZDB8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728082857.10829-5-akshu.agrawal@amd.com>
References: <20200728082857.10829-1-akshu.agrawal@amd.com> <20200728082857.10829-5-akshu.agrawal@amd.com>
Subject: Re: [v3 4/4] clk: x86: Support RV architecture
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rafael@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     akshu.agrawal@amd.com
Date:   Tue, 28 Jul 2020 18:26:20 -0700
Message-ID: <159598598019.1360974.14904311637963668990@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akshu Agrawal (2020-07-28 01:28:56)
> There is minor difference between previous family of SoC and
> the current one. Which is the there is only 48Mh fixed clk.
> There is no mux and no option to select another freq as there in previous.
>=20
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
