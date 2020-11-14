Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5232B2EBC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 18:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKNREQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 12:04:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgKNREQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 12:04:16 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6980223FD;
        Sat, 14 Nov 2020 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605373455;
        bh=WO7tgLQ38QQNH+AlJMGx/LTDRQbX3PlKn/5JVtI3d2s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=U5qItgqp4soSY4sKftwC+juT+PXEfPWZWVb0GaqlDu8zL77L2xLWr0O8sucGNl5EX
         hsn+vIMPfc+e3YsaE3lCL+mnIs0dfJ9c8kpxGTdAGdU3MhF9ykaR1Js7KTAYpW8pJh
         qr1yRmPREXBFSU1S0kvk0EAuCssiz8mlNFczRPBA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201113101419.GC168908@mwanda>
References: <20201113101419.GC168908@mwanda>
Subject: Re: [PATCH] clk: qcom: lpass-sc7180: Clean up on error in lpass_sc7180_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Sat, 14 Nov 2020 09:04:13 -0800
Message-ID: <160537345343.60232.8506254322830181377@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dan Carpenter (2020-11-13 02:14:19)
> Clean up the first driver if the second driver can't be registered.
>=20
> Fixes: 4ee9fe3e292b ("clk: qcom: lpass-sc7180: Disentangle the two clock =
devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Applied to clk-next
