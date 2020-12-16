Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B552DB99B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgLPDWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:22:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgLPDWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:22:40 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608088920;
        bh=zXOu3Dsa7PjAV8LCk/8JtIkNMtPqZuJsgeUbq9ntAms=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VHDiWkyzJG4AhGEdOpncZIfbEIH/5U1BsuFpYicphwvUt5qjm2OrLC5UQ1DdcAths
         JAMSvRaXgBVwEIV+cbu9Rk7wPINeZTHrbdW7ppqZXdLjyflvonplP5bXlOKeGwOQCX
         4t5xNVgSAJSobcmG4yOjaOt/BvFLkJDuaKorNe0aJNCLdmWwN6Z+TmbRKu+CBM3BUg
         Q8/2LgcioL/3inLo9UdzhQzwPR5AZ3+lviNbRtlMJpF5Hrf/AfLiA893nBhO7ueqH3
         q2yMpGMA/qSjRwuE0FntOmf3TwmX/acDBZ/8FoMRioVYvB21g/+RuUCIpq99xrJ2uM
         myEVxtqUjOM5w==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201126030043.67390-1-zong.li@sifive.com>
References: <20201126030043.67390-1-zong.li@sifive.com>
Subject: Re: [PATCH] dt-bindings: fu740: prci: add YAML documentation for the FU740 PRCI
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>
To:     Zong Li <zong.li@sifive.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Date:   Tue, 15 Dec 2020 19:21:58 -0800
Message-ID: <160808891852.1580929.2514120348145455057@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2020-11-25 19:00:43)
> Add YAML DT binding documentation for the SiFive FU740 PRCI. The
> link of unmatched board as follow, the U740-C000 manual would be present
> in the same page later.
>=20
>     https://www.sifive.com/boards/hifive-unmatched
>=20
> Passes dt_binding_check.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---

Applied to clk-next
