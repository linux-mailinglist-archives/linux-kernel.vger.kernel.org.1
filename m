Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72C20470F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 04:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgFWCHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 22:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbgFWCHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:07:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B771620720;
        Tue, 23 Jun 2020 02:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592878037;
        bh=ZI7gd+nSeICKMJNLtj/MV//eRvceMsbuRaIbnPAu+vs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LPl76Wm6zHofF8CUkuJmttcsmr3Oy3h1uHszoVPMUrhevFCD7LAZbzJZBo/WCVXll
         AlkbVI3nVTqB78iINkwmCZPt2BzEVV6jCDurdgj4leyfW2hA1CWiU8s3PlMSzj1fJq
         3vxcgtBjL982rN/hTCUrfUa/ZNhU5nZeUJAVce88=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200603154329.31579-1-aford173@gmail.com>
References: <20200603154329.31579-1-aford173@gmail.com>
Subject: Re: [PATCH V3 1/3] clk: vc5: Allow Versaclock driver to support multiple instances
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Date:   Mon, 22 Jun 2020 19:07:17 -0700
Message-ID: <159287803705.62212.1474913681833298395@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2020-06-03 08:43:27)
> Currently, the Versaclock driver is only expecting one instance and
> uses hard-coded names for the various clock names.  Unfortunately,
> this is a problem when there is more than one instance of the driver,
> because the subsequent instantiations of the driver use the identical
> name.  Each clock after the fist fails to load, because the clock
> subsystem cannot handle two clocks with identical name.
>=20
> This patch removes the hard-coded name arrays and uses kasprintf to
> assign clock names based on names of their respective node and parent
> node which gives each clock a unique identifying name.
>=20
> For a verasaclock node with a name like:
>    versaclock5: versaclock_som@6a
>=20
> The updated clock names would appear like:
>     versaclock_som.mux
>        versaclock_som.out0_sel_i2cb
>        versaclock_som.pfd
>           versaclock_som.pll
>              versaclock_som.fod3
>                 versaclock_som.out4
>              versaclock_som.fod2
>                 versaclock_som.out3
>              versaclock_som.fod1
>                 versaclock_som.out2
>              versaclock_som.fod0
>                 versaclock_som.out1
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---

Applied to clk-next
