Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF6E1F4844
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 22:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgFIUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 16:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgFIUpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:45:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E1632068D;
        Tue,  9 Jun 2020 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591735540;
        bh=FQIs4tePx//1D6KMmaz9yjlTM6qx4AFNCuoeejrUMEw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=D8UOBA0ZkKvIPyEePFqKdIjrx9XjAVdGw1ebjLdsP8+/K+FFbBvsSIDMdpet2Uq/Y
         L+4JUEDOWUY4i5ZWziYBiGEBBiSD7noxe7Nzm5Fl9xK0L9tcifeBbCbb2mRa/DsVr/
         ckoyKbJh9GTGI3M6vC6/w1af6Xq/w2+TXsLc28Sk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200602172435.70282-1-colin.king@canonical.com>
References: <20200602172435.70282-1-colin.king@canonical.com>
Subject: Re: [PATCH] clk: baikal-t1: remove redundant assignment to variable 'divider'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-clk@vger.kernel.org
Date:   Tue, 09 Jun 2020 13:45:39 -0700
Message-ID: <159173553955.242598.16478893358446362532@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2020-06-02 10:24:35)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable divider is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next
