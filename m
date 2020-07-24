Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979FB22C187
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 10:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgGXI6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 04:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXI6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:58:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9522206EB;
        Fri, 24 Jul 2020 08:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595581082;
        bh=tzkyofJZ83xu4Dq5g+CzcXfmkcFYKwcnP4l8Hcgbzi0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JmwZsWL9ufg4Nclx28FhOXoT/jbgancmEtRdpD63spixXt6/mOuk/7iQIun5njbdD
         aCrswaoFV40Ip68Zb23JDBPtGlzEVxVHtoqFQkAMGIIdA2ZBDmpZI27xtlCNFFSLOY
         6LwxqK7YxB0SqIc3PdfB5Fp0DpeavRsJBvMPGfjk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <26624b65d0e6b958c4765a406b9929d1a9ce1c2c.1594880946.git.rahul.tanwar@linux.intel.com>
References: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com> <26624b65d0e6b958c4765a406b9929d1a9ce1c2c.1594880946.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v2 3/3] clk: intel: Avoid unnecessary memset by improving code
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Fri, 24 Jul 2020 01:58:01 -0700
Message-ID: <159558108119.3847286.13508421250919573847@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-07-15 23:30:32)
> memset can be avoided in a loop if the variables used are declared
> inside the loop. Move such variables declaration inside the loop
> to avoid memset.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---

Applied to clk-next
