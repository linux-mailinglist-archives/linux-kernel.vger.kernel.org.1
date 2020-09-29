Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E2227BCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgI2GJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgI2GJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:09:30 -0400
Received: from coco.lan (ip5f5ad5bc.dynamic.kabel-deutschland.de [95.90.213.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD3EC20BED;
        Tue, 29 Sep 2020 06:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601359770;
        bh=vato/ATkmRSyEajlKkDTPiR91f1ZuLn1H05fHRPJIXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hsBBarug0eTLR0DdQoJPu/by5DwGDQC7SYYDTOD27s61Vy0BOQHwQz4j7Xt1hVIiC
         rbpE8SLADwz5cHcQlG2g6xcfSRRL9dU3l8QskPH/1ccyc0wzBtrn1GKhpny08jTL9v
         FuTA4Jv7iX7W2T9whs/rt7MUyUNDD6WAwstmUrhQ=
Date:   Tue, 29 Sep 2020 08:09:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, Felipe Balbi <balbi@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: document a new quirk for dwc3
Message-ID: <20200929080923.2a365748@coco.lan>
In-Reply-To: <CAL_JsqLucKWwgBVAoyXpm1mCD5-OvFj2pM_q2+tcyA+K9fCnKg@mail.gmail.com>
References: <cover.1599549364.git.mchehab+huawei@kernel.org>
        <cb821a8b5ef2d44ce32c8ce1d01c34b7afb70eb2.1599549364.git.mchehab+huawei@kernel.org>
        <20200915163814.GA2084568@bogus>
        <20200917091821.0de18caa@coco.lan>
        <CAL_JsqLucKWwgBVAoyXpm1mCD5-OvFj2pM_q2+tcyA+K9fCnKg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

Felipe,

Em Thu, 17 Sep 2020 08:47:48 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Thu, Sep 17, 2020 at 1:18 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >

> > IMO, adding a new quirk is cleaner, and adopts the same solution
> > that it is currently used by other drivers with Designware IP.  
> 
> We already have a bunch of quirk properties. What's one more, sigh. So
> if that's what you want, fine.
> 
> Rob

It sounds that this is the last piece for us to have everything
needed at the drivers in order to provide upstream support for
the Hikey 970 USB hub.

Could you please merge it?

Thanks,
Mauro
