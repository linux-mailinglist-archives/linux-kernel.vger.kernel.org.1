Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A890F2A73C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbgKEAaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:30:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732206AbgKEA3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:29:53 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB7E82080D;
        Thu,  5 Nov 2020 00:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604536193;
        bh=pwsIgIBSAjXexIaH9MrKCZNoDQPxrq7mUAOeqVWHGtQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mPVaCbOsvEkiPC/3AxURRqz1OQ/+xnl2g9pI6ydRR8CHxu+2qrpfdxzpvrjF9CfET
         OKez3BpQ8OP81pwaxwbGs/Cgg+ZrN37sXObo/NAGDpg04OhE/1tbHvZ4kHC1JVySUh
         nzo/zZ14xPrrHOq1dkRiCJDcMchulBOqrzT7WfUk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201101184818.2754-1-michael@walle.cc>
References: <20201101184818.2754-1-michael@walle.cc>
Subject: Re: [PATCH] clk: fsl-sai: fix memory leak
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>
To:     Michael Walle <michael@walle.cc>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Nov 2020 16:29:51 -0800
Message-ID: <160453619129.3965362.7473462251338349415@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Walle (2020-11-01 10:48:18)
> diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
> index 0221180a4dd7..1e81c8d8a6fd 100644
> --- a/drivers/clk/clk-fsl-sai.c
> +++ b/drivers/clk/clk-fsl-sai.c
> @@ -68,9 +68,20 @@ static int fsl_sai_clk_probe(struct platform_device *p=
dev)
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
> =20
> +       platform_set_drvdata(pdev, hw);
> +
>         return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
>  }
> =20
> +static int fsl_sai_clk_remove(struct platform_device *pdev)
> +{
> +       struct clk_hw *hw =3D platform_get_drvdata(pdev);
> +
> +       clk_hw_unregister_composite(hw);

Should we add a devm_clk_hw_register_composite() API and use it here?
That way we don't need a remove function and devm can be used
throughout.

> +
> +       return 0;
> +}
> +
>  static const struct of_device_id of_fsl_sai_clk_ids[] =3D {
>         { .compatible =3D "fsl,vf610-sai-clock" },
>         { }
