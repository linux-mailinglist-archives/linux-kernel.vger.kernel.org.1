Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA921C542
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgGKQaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 12:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgGKQaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 12:30:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72057207D4;
        Sat, 11 Jul 2020 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594485011;
        bh=VHmLfWZcjJdPPZiAxjZ1DKqW0gocqhU2LJB6V29kFig=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IJ1rPikHW/k4xBYin7EL35cOJ35HzmTbwEqTUUaXvftUCCSuEGlgcvddF86OKfmWm
         E1jIwPczDpiK8SeRo3o3ylnIJd340hrhAu9DjAPR68wfJ9CDpD+yQr9XsT4I58Ub9W
         Lz2Tb3kj7OoRBXdI8TUv8ljYrRUO7MSNqggDt7zQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200630044518.1084468-1-davidgow@google.com>
References: <20200630044518.1084468-1-davidgow@google.com>
Subject: Re: [PATCH] clk: staging: Specify IOMEM dependency for Xilinx Clocking Wizard driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devel@driverdev.osuosl.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
To:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Soren Brinkmann <soren.brinkmann@xilinx.com>
Date:   Sat, 11 Jul 2020 09:30:10 -0700
Message-ID: <159448501081.1987609.2376410636031633673@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Gow (2020-06-29 21:45:17)
> The Xilinx Clocking Wizard driver uses the devm_ioremap_resource
> function, but does not specify a dependency on IOMEM in Kconfig. This
> causes a build failure on architectures without IOMEM, for example, UML
> (notably with make allyesconfig).
>=20
> Fix this by making CONFIG_COMMON_CLK_XLNX_CLKWZRD depend on CONFIG_IOMEM.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> ---

This driver is in the process of being destaged to drivers/clk/

Greg, should I pick this one up?

>  drivers/staging/clocking-wizard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
