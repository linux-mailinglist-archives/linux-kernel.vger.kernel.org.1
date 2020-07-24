Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD46C22C182
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 10:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgGXI5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 04:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXI5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:57:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A11E2070B;
        Fri, 24 Jul 2020 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595581070;
        bh=YsHTnsQITOYhjYePtzDhkv+cyLxkEuGGUYjPnpH6//c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PjBp02Fel9w9oeFcXZVzD1NeK0WgeSOzF73GDkSS1tOSfFPSi8gAVwc6P2Ra1DftJ
         Cb4FTjonIniOzi9rvYhKy0DVAbKFp1ct/lvNLX7QFMF6dXUVjFS83Y6SQwPx99VZZE
         wAXyBbs3aIMbWlnQzDOD08xgISSNunRh9/W/OTb4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
References: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v2 1/3] clk: intel: Use devm_clk_hw_register() instead of clk_hw_register()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Fri, 24 Jul 2020 01:57:49 -0700
Message-ID: <159558106988.3847286.6240833838779403056@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-07-15 23:30:30)
> To ensure that clks are unregistered in case of any failure, use
> devm_clk_hw_register() instead of clk_hw_register().
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---

Applied to clk-next
