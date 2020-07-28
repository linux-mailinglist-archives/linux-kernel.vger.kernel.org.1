Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B140723123F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 21:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbgG1TPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 15:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgG1TPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:15:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98432065C;
        Tue, 28 Jul 2020 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595963721;
        bh=5bVk+PWqEcKnq9b9cFeWyNeWh3aCCKRe9dswXmFLev0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=neOa1iXWr9CSEYWqYKLGgWtqN0EfV17VVGmzmyZnbWq/Fp7pCnzUqQ5h7IjA9x5UT
         zIXkQpMScEHKM20Y8065BHpW3Mmmmu4A9maiZkTY11EQXCniHJ3riekiPn4YCAGvMk
         kHpbX11wLLYYYJ0ycqNarpYerX1721J06GhovEa4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595926999-14934-1-git-send-email-peng.fan@nxp.com>
References: <1595926999-14934-1-git-send-email-peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/2] clk: imx: imx8m: avoid memory leak
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To:     abel.vesa@nxp.com, festevam@gmail.com, peng.fan@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Tue, 28 Jul 2020 12:15:20 -0700
Message-ID: <159596372057.1360974.5467052516430145178@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peng.fan@nxp.com (2020-07-28 02:03:18)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Use devm_kzalloc() to avoid memory leak when probe fail.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
