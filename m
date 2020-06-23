Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0011F204720
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgFWCIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 22:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730328AbgFWCIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:08:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B7120720;
        Tue, 23 Jun 2020 02:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592878095;
        bh=uW4WusswhVLgizDySNr71wzxeIDhK+OWpYozxZaa52g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YMe9EAm8d/uA85dqa18gaLyV9Dsx2KPu/Nci9FKJ28x1qKY7FWOsTVqThq2DTKx+C
         TTfr1JQQjKxS6e19W00TTVHZADe3dGdzk4x2UVAwcD1LltPcAFgRBJNPynvzVffXS2
         eNsOWmH2q8zTFY7ywBonQn8q1i9F7XyBPUKFpk/k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1591155360-26173-3-git-send-email-peng.fan@nxp.com>
References: <1591155360-26173-1-git-send-email-peng.fan@nxp.com> <1591155360-26173-3-git-send-email-peng.fan@nxp.com>
Subject: Re: [PATCH V4 2/2] clk: imx8mp: add mu root clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To:     aisheng.dong@nxp.com, fabio.estevam@nxp.com, kernel@pengutronix.de,
        linux@rempel-privat.de, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Date:   Mon, 22 Jun 2020 19:08:14 -0700
Message-ID: <159287809463.62212.16531272768548193811@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peng.fan@nxp.com (2020-06-02 20:36:00)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add mu root clk for mu mailbox usage.
>=20
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
