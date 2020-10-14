Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5456028D8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgJNCsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgJNCsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:48:14 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1845F21775;
        Wed, 14 Oct 2020 02:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602643694;
        bh=Buh8s8YvleUtEPtzJRdWTPJ2//hJsQEqcjVcSpkwIFw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HoccovkMt8pHYm7azGQcEfCXGjlrZRuNoO79p3DDrif+z69zgJpRiGxone7IrotTL
         Bzk49klAgm6R/w7KsdJiUESV2GJvsU8AArzrSD4RPak/MlHOb1Sx7f9RQCiZSXhAMf
         RFnPWnMq61wib1GrLqVECMSmZHmh13a/nLOFwkpc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200916030311.17280-1-qiang.zhao@nxp.com>
References: <20200916030311.17280-1-qiang.zhao@nxp.com>
Subject: Re: [PATCH 1/2] clk: qoriq: modify MAX_PLL_DIV to 32
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     andy.tang@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Zhao Qiang <qiang.zhao@nxp.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>, mturquette@baylibre.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Date:   Tue, 13 Oct 2020 19:48:12 -0700
Message-ID: <160264369288.310579.9004484766033537806@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qiang Zhao (2020-09-15 20:03:10)
> From: Zhao Qiang <qiang.zhao@nxp.com>
>=20
> On LS2088A, Watchdog need clk divided by 32,
> so modify MAX_PLL_DIV to 32
>=20
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---

Applied to clk-next
