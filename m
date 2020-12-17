Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D710F2DCE30
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgLQJUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgLQJUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:20:22 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608196781;
        bh=H90ALHr0RB53R1hF6/W/t+UgKZ2JnM4ogJ0fJrlcTnM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=N81ughe7GO/utaVFeWmOcvXcM6tPTYYmgG7Rqmw53NG6UgbHXj2kh7yhmiRN+TGGf
         83Uvtp5eaFx4oYP8LhNc+S0eEl1eC6chtUm/RaamHAFrnAvzFayebFKVSdhvs6b1ny
         uC+NbxBbPo2BMKBLTmuUgOXGwzewzagbibEr5D9NaWkyddwFN0Br88QeAwCJhYPEWi
         Kg/R4vAa9vWDXM9LFDFnXIJzILwDGyVt6MA5P++pV4nHRku8baXr1cCGkKrDu+bcpi
         zIBa7SXni5POUFjLMhj4uDM0qEfvCGh1Zk9EmFT1MXyua2HOLoFFFOAdLLzNbPU4ir
         nC5kqR1x69dZw==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v5 00/24] Mediatek MT8192 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>, Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Thu, 17 Dec 2020 01:19:40 -0800
Message-ID: <160819678048.1580929.17802518526715179114@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2020-11-08 18:03:25)
> This series is based on v5.10-rc1 and MT8192 dts v6[1].
>=20
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20201030092=
207.26488-2-seiya.wang@mediatek.com/

This series doesn't apply for me to clk tree. Please resend. Also,
please remove the dts patches from the series as they're not relevant to
clk tree and please get someone to review the patches on the list. I'm
only looking now because nobody has said anything in over a month.
