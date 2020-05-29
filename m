Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED61E70AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 01:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437724AbgE1XrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 19:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437651AbgE1XrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:47:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 714B72075F;
        Thu, 28 May 2020 23:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590709631;
        bh=K7UEakQMmDiaI6anpDZmkJkPrAeJdrORnVzDvLf0HvI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WJz80WagMi21dwiBieVUiY6W+qXCgOpLJiqn2V32Mb/0HpmrGv85FYNsjbLjyREiL
         TySnLygNhnztJLC7H8ERPLi0R6K7JVnU4Ng7rKQ/G2ZkoejyWutprTT4X6u2AQ4Kkr
         o3I/UxDaGbNbfBqI4xAMJv8wJkZ1vMiq0HM4SSbc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200528233837.70269-1-sboyd@kernel.org>
References: <20200528233837.70269-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: ingenic: Mark ingenic_tcu_of_match as __maybe_unused
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 28 May 2020 16:47:10 -0700
Message-ID: <159070963068.69627.14874637406897919086@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-05-28 16:38:37)
> This device id table is passed to of_match_node() later on in probe, but
> on CONFIG_OF=3Dn builds of_match_node() doesn't do anything with the
> arguments. Lets just mark the table unused so that the compiler doesn't
> complain about this.
>=20
> drivers/clk/ingenic/tcu.c:326:34: warning: unused variable 'ingenic_tcu_o=
f_match' [-Wunused-const-variable]
> static const struct of_device_id ingenic_tcu_of_match[] __initconst =3D {
> ^
> 1 warning generated.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
