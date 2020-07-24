Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9268522C184
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGXI56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 04:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgGXI56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:57:58 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0C4206EB;
        Fri, 24 Jul 2020 08:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595581077;
        bh=J3vRbMm5rZ/L4AsJd2FE+R4sPDDR9qHld5aJV0A56wI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NpHlnYgbzx4F5QHFswCBYtS+xY/pUuwuWCk5qobjybQ+potOW488YIprc7VPcS6KK
         CtX6h5JtgEJcREkW/hLHJzvKonXZGva9uLDogx+lpB28OXknAp9BN0tprREcAMwYFu
         faJpJuO1RGsSOkYh2/iyi/N8redk1fqgehv5E0JQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <79c0f5f9f5bc512a7e2b5f3c91f6341f28b5854c.1594880946.git.rahul.tanwar@linux.intel.com>
References: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com> <79c0f5f9f5bc512a7e2b5f3c91f6341f28b5854c.1594880946.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v2 2/3] clk: intel: Improve locking in the driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Fri, 24 Jul 2020 01:57:56 -0700
Message-ID: <159558107691.3847286.2009052831781257545@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-07-15 23:30:31)
> Remove/reduce unnecessary spin locking of the code.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---

Applied to clk-next
