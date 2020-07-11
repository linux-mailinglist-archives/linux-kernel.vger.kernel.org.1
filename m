Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18A321C537
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 18:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGKQ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 12:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgGKQ1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 12:27:00 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC81207D4;
        Sat, 11 Jul 2020 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594484820;
        bh=QdgmgyHsnWWDRikFOV9j9mPiLF+83cg5Wvfr+sH5Lko=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=w/AS+ZTGMx7OcgcjAco9fdtofh9wBp2cwTzG22wFz37i3qsrhrhAp++/4JQjUIWrX
         IHlAiTjXnZsEnNJL/4NaXIGIexggdDWHSCSpwG30E/QJfIMKT9iqVFDxL5rSUaHlKu
         Bg2fGzM/Obu3PjTbDieHbM8zXyg/QUO5Lz3S0ypk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1593588382-19049-3-git-send-email-wendell.lin@mediatek.com>
References: <1593588382-19049-1-git-send-email-wendell.lin@mediatek.com> <1593588382-19049-3-git-send-email-wendell.lin@mediatek.com>
Subject: Re: [PATCH 2/2] clk: mediatek: Add EXPORT_SYMBOL for kernel module support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>
Date:   Sat, 11 Jul 2020 09:26:59 -0700
Message-ID: <159448481956.1987609.4970524569331045099@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wendell Lin (2020-07-01 00:26:22)
> Export common APIs from Mediatek clock driver.
>=20
> Signed-off-by: Wendell Lin <wendell.lin@mediatek.com>

Is this needed for something? I'd prefer to see some sort of mediatek
modular patches that included this patch in it before this is applied.
