Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5781E3974
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 08:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgE0Glj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 02:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgE0Gli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:41:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49DA920776;
        Wed, 27 May 2020 06:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590561698;
        bh=aV8A8sLjaDOj/7AanTn0RtlrOOIqsNKRPjRHYtq5vE0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=o2RaZcvLGicVzdZAfBKYyCE0fgf5suFvdUtUTwKyZ7ckeSIcUDkYS9LY7YIwgBIxD
         HUEfkBOEtQbsQUFQFiIMPyyA/6q4t89VaDVJPT0YyS8qLgImWsmCfqdHiP3OF0AvFA
         4ZAQGOB94XhgaH13WSXjll1GEF9o0BqY4Toy5CJ8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200527053638.31439-2-zhang.lyra@gmail.com>
References: <20200527053638.31439-1-zhang.lyra@gmail.com> <20200527053638.31439-2-zhang.lyra@gmail.com>
Subject: Re: [RESEND PATCH v2 1/4] clk: sprd: check its parent status before reading gate clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 26 May 2020 23:41:37 -0700
Message-ID: <159056169760.88029.12084641394538099454@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-05-26 22:36:35)
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> Some clocks only can be accessed if their parent is enabled. mipi_csi_xx
> clocks on SC9863A are an examples. We have to ensure the parent clock is
> enabled when reading those clocks.
>=20
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---

Applied to clk-next
