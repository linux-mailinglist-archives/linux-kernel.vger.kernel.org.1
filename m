Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BE52749CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVUHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgIVUHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:07:10 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC17221E7;
        Tue, 22 Sep 2020 20:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600805230;
        bh=8iswYPu27PYcGlTr8O09zocLUcfIkTWGoqABqHa5FAo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VIRKZd4PdH0+ucDTB4Q/dOS3oU9+8o3xpAM0FhwQSjwV5l+KfZlSxXS834A8vSZBM
         X3vy5kUH20IJYJhiBIyY7Ac84msnjfdZH+E5XqVCqPY4OSiDlk0sPrUmLhX1nqg8WA
         3W/SU6MydX6Yo5r7evQmlC5WT4nkmZHeysC3oQwY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1599684288-20917-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1599684288-20917-1-git-send-email-amit.sunil.dhamne@xilinx.com>
Subject: Re: [PATCH v4 0/3] clk: zynqmp: Add firmware specific clock flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        linux-clk@vger.kernel.org, m.tretter@pengutronix.de,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        mturquette@baylibre.com
Date:   Tue, 22 Sep 2020 13:07:08 -0700
Message-ID: <160080522837.310579.7160115709529621594@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Sunil Dhamne (2020-09-09 13:44:45)
> Currently firmware is maintaining CCF specific flags and provides to
> CCF as it is. But CCF flag numbers may change and that shouldn't mean
> that the firmware needs to change. The firmware should have its own
> 'flag number space' that is distinct from the common clk framework's
> 'flag number space'. So use firmware specific clock flags in ZynqMP
> clock driver instead of CCF flags.
>=20
> Changes in v4:
>  - Use if condition instead of ternary operator.
>=20

Thanks. This patch series doesn't apply for me though. What is the base
of the patches? Can you use the --base option when formatting patches
with git format-patch? That would help me.

Also, I think your MUA or SMTP server is mangling the format. I had
trouble trying to apply the patches from my local copy so I had to
fallback to lore but even that didn't work.

Please resend.
