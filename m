Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8966274924
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIVT3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVT3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:29:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E5723787;
        Tue, 22 Sep 2020 19:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600802988;
        bh=zGDpR400lF8sS+w2f5hNi8KhZtffSJpAzGWhfrD8OzU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bS+Rzkl43sz53wzidHx/oul/Rhydw005z61pTAmsKzJZLANOqk+N929owXUth8KWt
         sFVFLqKdtb7vAC6D9IEizNy54CsCkl9gHvg3Er3icxdOCwjOGkMcuPbk2ncdYgdtgV
         txPA8ow67vjJcEKEXqyhK1RWO2ouOpc6/nieqPzk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200901040759.29992-2-hoegeun.kwon@samsung.com>
References: <20200901040759.29992-1-hoegeun.kwon@samsung.com> <CGME20200901040851epcas1p28f443c0e819bea756ebf9296491b32da@epcas1p2.samsung.com> <20200901040759.29992-2-hoegeun.kwon@samsung.com>
Subject: Re: [PATCH v2 1/4] clk: bcm: rpi: Add register to control pixel bvb clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, tim.gover@raspberrypi.com,
        mturquette@baylibre.com, kdasu.kdev@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org, hoegeun.kwon@samsung.com
To:     Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        dave.stevenson@raspberrypi.com, eric@anholt.net, maxime@cerno.tech,
        nsaenzjulienne@suse.de, stefan.wahren@i2se.com
Date:   Tue, 22 Sep 2020 12:29:47 -0700
Message-ID: <160080298755.310579.12537322885845907147@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hoegeun Kwon (2020-08-31 21:07:56)
> To use QHD or higher, we need to modify the pixel_bvb_clk value. So
> add register to control this clock.
>=20
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---

Applied to clk-next
