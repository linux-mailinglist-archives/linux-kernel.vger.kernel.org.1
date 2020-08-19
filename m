Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E078424933C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 05:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHSDIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 23:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgHSDIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:08:36 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E912065F;
        Wed, 19 Aug 2020 03:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597806515;
        bh=78bRBdzNhJujOebmg6DHCPilaIUZ2kw2kYPf/ZdhIoU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BfCO+1nvWe2PvoUyRco6OxFpDo9hk89LIVNNtHjbxejeXjYj8vKJ9vDWHt5lIlhfn
         9GqAe9c4ZNMqtJbCHM+MMsWOMYAGyOGrli6I3I8SKm3FQwO4nGu/xw1GLKcSAWMhB+
         +LD4DWrdsOPyHudVy5BWLH7/ShE1Xl7RO/GLQJwE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200809144959.747986-1-christophe.jaillet@wanadoo.fr>
References: <20200809144959.747986-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: davinci: Use the correct size when allocating memory
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        david@lechnology.com, mturquette@baylibre.com, nsekhar@ti.com
Date:   Tue, 18 Aug 2020 20:08:34 -0700
Message-ID: <159780651426.334488.4846081923924152334@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2020-08-09 07:49:59)
> 'sizeof(*pllen)' should be used in place of 'sizeof(*pllout)' to avoid a
> small over-allocation.
>=20
> Fixes: 2d1726915159 ("clk: davinci: New driver for davinci PLL clocks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-fixes
