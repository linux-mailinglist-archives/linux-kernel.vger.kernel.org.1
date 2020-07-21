Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A828227B11
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 10:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGUIwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 04:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGUIwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:52:10 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB44120717;
        Tue, 21 Jul 2020 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595321530;
        bh=0awrLeVY1QmIe/8JNAHk/JFSY9cKCJZuoJKUMnbhn84=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=yIv0Qohj30i1ms4SCuGxNflh5C0dIML89BnyKiYJ9Lbi1GdOQbhFfjp5QPRFJ5bLu
         X0Cd50EPKcht/X16d6CRmfRAqqI27HToF4DiytWFqQiGcOK+3EYdJu51xP74U7S4wU
         epdFtelzd/5D+XrRgdCqLhVjJ5SbdyFUKVP0Yikw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <67112af4f5bc0cc5e70ce8410feb369cc72972b8.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com> <67112af4f5bc0cc5e70ce8410feb369cc72972b8.1593788312.git.cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: clock: Add APB, DMAC, GPIO bindings for Actions S500 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
To:     Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Jul 2020 01:52:09 -0700
Message-ID: <159532152924.3847286.3765680910026512438@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Ciocaltea (2020-07-03 10:05:08)
> Add the missing APB, DMAC and GPIO clock bindings constants for
> Actions Semi S500 SoC.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---

Applied to clk-next
