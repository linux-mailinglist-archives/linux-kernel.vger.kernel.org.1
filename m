Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D162A74E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgKEBcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:32:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgKEBcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:32:36 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EBA120825;
        Thu,  5 Nov 2020 01:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604539955;
        bh=NTATuFLHYj2P99gRlZRu8waWXMa4l9/N7AKPJHUN6t0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kf6U5uO4VtsCz4uzsQhedbDVzC78Uy/myzXWU2GY4ZzTA2Wd3OaFLYMBUaLlt3R8l
         WCZ47Xi7UL+f6z7vJ8z3SJWqde1tVwkbQGZDL27EH8V+Ob/XQyDEn6oVqkCY96QsPu
         9Bd4oWwpzVKw4/Obhw9M1foo27xIkhGQVUaUDgjs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1604403134-32814-1-git-send-email-zou_wei@huawei.com>
References: <1604403134-32814-1-git-send-email-zou_wei@huawei.com>
Subject: Re: [PATCH -next] clk: imx: gate2: Remove unused variable ret
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zou Wei <zou_wei@huawei.com>
To:     Zou Wei <zou_wei@huawei.com>, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Wed, 04 Nov 2020 17:32:33 -0800
Message-ID: <160453995399.3965362.14567000960515993717@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zou Wei (2020-11-03 03:32:14)
> This patch fixes below warning reported by coccicheck:
>=20
> ./clk-gate2.c:57:5-8: Unneeded variable: "ret". Return "0" on line 68
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
