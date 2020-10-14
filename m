Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422A928D8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgJNCpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgJNCpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:45:50 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8342221775;
        Wed, 14 Oct 2020 02:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602643549;
        bh=gINsJTbtdPDWPgjTes6IUgjqFgC2jZ+OFgtCHD75SEU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=1tTYhkKSi3BBNyN/XIgf/2lHp7R6xWLjUgyDde5zAYFHLaOoAmyHtdbQ2Cq3KgNIY
         fFbPASUIn9g3A4di+7K9i38WWsR1Q4A2hFFo7reu2ktBDdIXKpSmFv97zcVJU2Evha
         3phlZQ+kZHwyiYCTZ1ZP/foNdc4g3+OWCC5KXXzE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201001085948.21412-1-alexandru.ardelean@analog.com>
References: <20201001085948.21412-1-alexandru.ardelean@analog.com>
Subject: Re: [PATCH 1/2] clk: axi-clkgen: Add support for fractional dividers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     lars@metafoo.de, mturquette@baylibre.com, mdf@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Oct 2020 19:45:48 -0700
Message-ID: <160264354816.310579.11900737478542890087@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Ardelean (2020-10-01 01:59:47)
> From: Lars-Peter Clausen <lars@metafoo.de>
>=20
> The axi-clkgen has (optional) fractional dividers on the output clock
> divider and feedback clock divider path. Utilizing the fractional dividers
> allows for a better resolution of the output clock, being able to
> synthesize more frequencies.
>=20
> Rework the driver support to support the fractional register fields, both
> for setting a new rate as well as reading back the current rate from the
> hardware.
>=20
> For setting the rate if no perfect divider settings were found in
> non-fractional mode try again in fractional mode and see if better settin=
gs
> can be found. This appears to be the recommended mode of operation.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---

Applied to clk-next
