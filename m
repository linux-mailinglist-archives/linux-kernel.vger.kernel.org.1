Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE33265357
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgIJVct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728210AbgIJVau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:30:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3325F208E4;
        Thu, 10 Sep 2020 21:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599773450;
        bh=QikD1BFSNUNm4ToglG+Lo0WSIlxrcqgV8cxxoGs/s58=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IUpl8extBv+LUEdljc3is8DWs7GQjnngV3l5fBoXsWEPuPiFljubBYOS9T1S2DpaA
         9IG1hI1/umMIPOiEQ8fUpd1tlcOABgYcY03MZ7QTrK5mYm+wvNb1tWqVeJgrXqJ/qp
         76xvA1H2frEoMEK40uyf+yewFHxqlMkhnDU/j3pI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200905151017.1086353-1-j.neuschaefer@gmx.net>
References: <20200905151017.1086353-1-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2] clk: imx: gate2: Fix a few typos
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Thu, 10 Sep 2020 14:30:49 -0700
Message-ID: <159977344904.2295844.15214791228899912694@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2020-09-05 08:10:16)
> A few words were misspelled in this comment.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Presumably Shawn will pick this up.
