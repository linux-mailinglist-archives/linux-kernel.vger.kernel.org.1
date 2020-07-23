Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA2F22B9A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgGWWfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 18:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgGWWfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:35:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED924206E3;
        Thu, 23 Jul 2020 22:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595543753;
        bh=FXS3WNs034HEwKFaTlLZA6ilyGyWGmu5EJNCgAeeSZo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hEaizzbp/KyCXnnaUhUvCrZ/qqgyLLVZvKfB236oW3Qis2tfho6m2H4U0mOP4QnBz
         zvDxTHcOnuTl8wPwqDDjZbMCp+bRzKcSpJvAEKJOusQMDS8TRNOeXSa/mlLiQ+88Mj
         BpxQ3Subjx70yTrPgFqwsD5cvHag9QlQZca6Lx+0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
Subject: Re: [PATCH v2 0/3] clk: zynqmp: Add firmware specific clock flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        linux-clk@vger.kernel.org, m.tretter@pengutronix.de,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        mturquette@baylibre.com, sboyd@codeaurora.org
Date:   Thu, 23 Jul 2020 15:35:52 -0700
Message-ID: <159554375224.3847286.3288318925600777669@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Sunil Dhamne (2020-07-21 23:55:29)
> This series adds supports for firmware specific flags. These include
> - Common Flags
> - Divider Flags
> - Mux Flags
>=20
> The intent is to remove firmware's dependency on CCF flag values by having
> firmware specific flags with independent values.
>=20
> Currently firmware is maintaining CCF specific flags and provides to
> CCF as it is. But CCF flag numbers may change and that shouldn't mean
> that the firmware needs to change. The firmware should have its own
> 'flag number space' that is distinct from the common clk framework's
> 'flag number space'. So use firmware specific clock flags in ZynqMP
> clock driver instead of CCF flags.
>=20

Thanks for doing this work. Please resend with fixes.
