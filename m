Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DDB1E7448
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 06:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbgE2EFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 00:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgE2EFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:05:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C386920707;
        Fri, 29 May 2020 04:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590725101;
        bh=FlyUjyOP4FM41Bcscldp32wDJjQaZEJKpmRVmpZePso=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lCy5HLXTlg/Qt9DywquVvJP+RvqU017BYblNDIaMN+i3WVR2OF+sLDGP0iAeUgsK7
         wtbBGYuHA+V2IwfvtR64TPL9C4BYIz932iuFaNI7mGNTGDAap63XWu2bglx1LmULAs
         wB04d8EKPVeSM8ttTtewL66MfPAPeyq+BI8+i24U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200404161537.2312297-2-aford173@gmail.com>
References: <20200404161537.2312297-1-aford173@gmail.com> <20200404161537.2312297-2-aford173@gmail.com>
Subject: Re: [PATCH 2/2] dt: Add bindings for IDT VersaClock 5P49V5925
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Date:   Thu, 28 May 2020 21:05:00 -0700
Message-ID: <159072510097.69627.8792842688307323141@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2020-04-04 09:15:36)
> IDT VersaClock 5 5P49V6965 has 5 clock outputs, 4 fractional dividers.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt =
b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> index 05a245c9df08..bcff681a4bd0 100644
> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt

Applied to clk-next

BTW, the patch format threw my scripts off because there isn't a triple
dash after the SoB line.
