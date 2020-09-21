Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF35B2734D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgIUVVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgIUVVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:21:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E1B2067D;
        Mon, 21 Sep 2020 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600723304;
        bh=me2MwvSXd6QCYauBKe2+NNTCOKg4FSirkmBEwHjhjXw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BvR0zWSLjvHlg/r4m/rO1KpCtEZUV7RXwJ5JfBD6YkW19xyMuXZfTuYUM+q/zyk/A
         MHXnAEw6yU6NNf0UDS1KVOulGCtzeUb/NlOo0t2MoGHnb0zmiqjMstkZxQwhDTT7Gp
         VbxakiPIelqCcGSVLFPUIQGyIz22pLPCOxqIAslA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <160072319955.310579.4256832010356165092@swboyd.mtv.corp.google.com>
References: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com> <1598621996-31040-3-git-send-email-shubhrajyoti.datta@xilinx.com> <160072319955.310579.4256832010356165092@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v6 2/8] clk: clock-wizard: Add the clockwizard to clk directory
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:21:43 -0700
Message-ID: <160072330324.310579.14466423524100614935@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-09-21 14:19:59)
> Quoting Shubhrajyoti Datta (2020-08-28 06:39:50)
> > Add clocking wizard driver to clk.
> >=20
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
>=20
> Can this be combined with patch #6?

Sorry, I meant patch #8.
