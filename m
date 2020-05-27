Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B831E346E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 03:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgE0BIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 21:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgE0BIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:08:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F922088E;
        Wed, 27 May 2020 01:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590541697;
        bh=gEQCahnR2XMMiWuyGv9OLa98c7dUNuD50Z8vXWxnv1s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Pr3AovO/66JVsQ6pMOFxy3X3OQ2+GE39lheSQKMxSP/jIN6snMAwzNKg1bDAhZUJp
         tLPe/YEGL7n54na79S06oG9hjY3SBm7bQ3zYo7eV1aIu0A6W1ukXZIFA5x9vAH+Vol
         5CCJvEAtXiKHfrON8DlLGdYlwrplmm/iuOeptsNE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584048699-24186-3-git-send-email-jolly.shah@xilinx.com>
References: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com> <1584048699-24186-3-git-send-email-jolly.shah@xilinx.com>
Subject: Re: [PATCH v2 2/2] drivers: clk: zynqmp: Update fraction clock check from custom type flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
To:     Jolly Shah <jolly.shah@xilinx.com>, arm@kernel.org,
        linux-clk@vger.kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, olof@lixom.net
Date:   Tue, 26 May 2020 18:08:16 -0700
Message-ID: <159054169658.88029.371843532116000844@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2020-03-12 14:31:39)
> From: Tejas Patel <tejas.patel@xilinx.com>
>=20
> Older firmware version sets BIT(13) in clkflag to mark a
> divider as fractional divider. Updated firmware version sets BIT(4)
> in type flags to mark a divider as fractional divider since
> BIT(13) is defined as CLK_DUTY_CYCLE_PARENT in the common clk
> framework flags.
>=20
> To support both old and new firmware version, consider BIT(13) from
> clkflag and BIT(4) from type_flag to check if divider is fractional
> or not.
>=20
> To maintain compatibility BIT(13) of clkflag in firmware will not be
> used in future for any purpose and will be marked as unused.

Why are we mixing the firmware flags with the ccf flags? They shouldn't
be the same. The firmware should have its own 'flag numberspace' that is
distinct from the common clk framework's 'flag numberspace'. Please fix
the code.
