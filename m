Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6528D6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgJMXMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387570AbgJMXMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:12:05 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C166321D40;
        Tue, 13 Oct 2020 23:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602630724;
        bh=0zBPSpHevmdq1uHIA4+p1uLGrJhk+puG39JIQUADrUY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E6uByxTkGm1IvcvRNNDMXxLnxPNWajuOd5IxZeTX3oPYVop6IH0EdSfk1GHxMq/Br
         rf4810ui9zUhVY/9HgSzwRmDpz2/pXn9csKjDtteXCYT3XjWanp9ium8O6e72aU3+t
         Zuve/TQOeQqaG74zVSEc716JxZ2yLbKaqCMoc4fU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200918132303.2831815-2-fparent@baylibre.com>
References: <20200918132303.2831815-1-fparent@baylibre.com> <20200918132303.2831815-2-fparent@baylibre.com>
Subject: Re: [PATCH v2 2/2] clk: mediatek: Add MT8167 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     krzk@kernel.org, masahiroy@kernel.org, ck.hu@mediatek.com,
        macpaul.lin@mediatek.com, owen.chen@mediatek.com,
        matthias.bgg@gmail.com, Fabien Parent <fparent@baylibre.com>
To:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Tue, 13 Oct 2020 16:12:03 -0700
Message-ID: <160263072366.310579.8925835742463532920@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fabien Parent (2020-09-18 06:23:03)
> Add the following clock support for MT8167 SoC: topckgen, apmixedsys,
> infracfg, audsys, imgsys, mfgcfg, vdecsys.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---

Applied to clk-next
