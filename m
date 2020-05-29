Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AEC1E7479
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 06:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgE2ETn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 00:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgE2ETk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:19:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C252207D3;
        Fri, 29 May 2020 04:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590725979;
        bh=lPI6A83ttQ/c1j1m7UcKEFeIJazjx5XcZ050fvSwitM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FLoDt9ZaYlmcWVtsbov0qFpFQnYWpDrZlJE8pluEIXwGBFctnyQ70IBUVDMCHnTPC
         ySnCdMFeCBEQag+v9idxiHKADP31tRaLwg7xGqsD5++rkjuyvjLtAS7mWz8zzH+1oL
         RdrggKyTQ+m2k9Nwbzkj658elIKf729eZieXBJCg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582278742-1626-2-git-send-email-macpaul.lin@mediatek.com>
References: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com> <1582278742-1626-2-git-send-email-macpaul.lin@mediatek.com>
Subject: Re: [PATCH 1/5] dt-bindings: clock: mediatek: document clk bindings for Mediatek MT6765 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Joerg Roedel <jroedel@suse.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        mtk01761 <wendell.lin@mediatek.com>
Date:   Thu, 28 May 2020 21:19:38 -0700
Message-ID: <159072597842.69627.10940278621295452958@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Macpaul Lin (2020-02-21 01:52:18)
> This patch adds the binding documentation for apmixedsys, audsys, camsys,
> imgsys, infracfg, mmsys, pericfg, topckgen
>=20
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---

Applied to clk-next
