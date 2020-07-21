Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09C4227A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgGUIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 04:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgGUIFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:05:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4412080D;
        Tue, 21 Jul 2020 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595318750;
        bh=rDrP2X+jctT9/2IFGc57irZg4LC7++9ZmtdWwTjZFJI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gyX8m0JFqonaoBjIPJHKbjSzHj9ZpYOfX2o1OQQHma007mtt6L0I76MHwJDBtaX0J
         HxfgDniIcDnrfdY2jZdWOh9EIjcLQiCI+beSAJ1P8RGfjoahi8ot4A80hnVPXy6yJZ
         SNg/vAvwB6FJfCFhsRBTYVeAfKeoPH+1q0LWx9YU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200720050500.23357-5-akshu.agrawal@amd.com>
References: <20200720050500.23357-1-akshu.agrawal@amd.com> <20200720050500.23357-5-akshu.agrawal@amd.com>
Subject: Re: [v2 4/4] clk: x86: Support RV architecture
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     akshu.agrawal@amd.com
Date:   Tue, 21 Jul 2020 01:05:49 -0700
Message-ID: <159531874995.3847286.4010361856630371541@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akshu Agrawal (2020-07-19 22:04:59)
> diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
> index b252f0cf0628..d68bca7b213f 100644
> --- a/drivers/clk/x86/clk-fch.c
> +++ b/drivers/clk/x86/clk-fch.c
[...]
> =20
>  static int fch_clk_remove(struct platform_device *pdev)
>  {
> -       int i;
> +       int i, clks;
> +       struct fch_clk_data *fch_data;
> =20
> -       for (i =3D 0; i < ST_MAX_CLKS; i++)
> +       fch_data =3D dev_get_platdata(&pdev->dev);
> +
> +       clks =3D (!fch_data->is_rv) ? ST_MAX_CLKS : RV_MAX_CLKS;

Useless parenthesis and negation, just write:

	num =3D fch_data->is_rv ? RV_MAX_CLKS : ST_MAX_CLKS;

> +
> +       for (i =3D 0; i < clks; i++)
>                 clk_hw_unregister(hws[i]);
> +
>         return 0;
>  }
>
