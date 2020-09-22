Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2BC274998
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIVT4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgIVT4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:56:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33DE221E8;
        Tue, 22 Sep 2020 19:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600804604;
        bh=W+iHN5ru8hU8FsEqA6+NPs3FQxVIkYRCyEQVqaxXkJ8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X6JHUiS40tzdoFtmb2sTu1lvkBxyi+p4e6imhSrziuGXslhjEC7vYyyHXnN1hrBY2
         E27/saitvO3/e971ry5IX821KSajl/jC/BLmet2ex+rpY9pFpYM2rDuAi25PPg2bGN
         rBZz5hTDrqG/2iuoT6k6ala2DRlNIu2EkYrEmti8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200921082426.2591042-1-liushixin2@huawei.com>
References: <20200921082426.2591042-1-liushixin2@huawei.com>
Subject: Re: [PATCH -next] clk: mediatek: mt7629: simplify the return expression of mtk_infrasys_init
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liu Shixin <liushixin2@huawei.com>
To:     Liu Shixin <liushixin2@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 22 Sep 2020 12:56:43 -0700
Message-ID: <160080460341.310579.1203602714296917820@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liu Shixin (2020-09-21 01:24:26)
> Simplify the return expression.
>=20
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---

Applied to clk-next
