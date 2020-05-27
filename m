Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524BC1E353A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 04:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgE0CKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 22:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgE0CKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:10:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B232078C;
        Wed, 27 May 2020 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590545419;
        bh=ggUMHPDs88u+ULrbCRSr8oQzOvjkFR+m/Kbh3Ec5NFc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jRgz4Wy2RfW597/ZYL/LLE/Czl79NxxoIqCxCLWVV4i2oG10NM/rxaUU1xjHd7mh8
         v5nn9Q24EzyK9iPSk+NhrIuuGuNQCy/RiJZD0izBoJVQu2h20tdXPqyX2aPngirvJB
         zQiQvI7c8nEGkOiuM6DCxM6gf1uKR4jOW1Cw7OZ8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <42a4f71847714df482bacffdcd84341a4052800b.1587102634.git.rahul.tanwar@linux.intel.com>
References: <cover.1587102634.git.rahul.tanwar@linux.intel.com> <42a4f71847714df482bacffdcd84341a4052800b.1587102634.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v8 2/2] clk: intel: Add CGU clock driver for a new SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        rtanwar <rahul.tanwar@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Tue, 26 May 2020 19:10:18 -0700
Message-ID: <159054541872.88029.2954311426491011720@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-04-16 22:54:47)
> From: rtanwar <rahul.tanwar@intel.com>
>=20
> Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming
> Intel network processor SoC named Lightning Mountain(LGM). It provides
> programming interfaces to control & configure all CPU & peripheral clocks.
> Add common clock framework based clock controller driver for CGU.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---

Applied to clk-next
