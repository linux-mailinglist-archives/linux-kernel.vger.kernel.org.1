Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC841D3E15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgENT4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 15:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgENT4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:56:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75772065D;
        Thu, 14 May 2020 19:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589486204;
        bh=aHeXCtaeEq1afuAyJb7RmnyaILIx1MlUyt2nSELDpBQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hSeN54GkkVqzSDKsAe7toLrQk4fw9B0dfwXG85k85Sy2dKtaa6NOFz/nVxe1w8NSm
         N8ylDDRtIwAEGipqDoSY82bzzvR6yGVbCePB8HvCOIMo2YfgAlJs+4iOE7zWBwRc3d
         N2Lrk6GK6keurk4U1KZGzuHs6SA0jRJalyxv40Kw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200409064416.83340-4-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org> <20200409064416.83340-4-sboyd@kernel.org>
Subject: Re: [PATCH v2 03/10] arm64: tegra: Remove redundant CLKDEV_LOOKUP selects
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>,
        Thierry Reding <treding@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 14 May 2020 12:56:43 -0700
Message-ID: <158948620328.215346.17455122873404517531@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-04-08 23:44:09)
> The arm64 architecture selects COMMON_CLK at the toplevel ARM64 config.
> The COMMON_CLK config option already selects CLKDEV_LOOKUP so it's
> redundant to have this selected again for the Tegra specific config.
>=20
> Cc: Paul Walmsley <paul@pwsan.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
