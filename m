Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB00A19E8C4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 05:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDEDII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 23:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgDEDII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 23:08:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B67C206A3;
        Sun,  5 Apr 2020 03:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586056087;
        bh=J0VEFs+7R2vxCSMV2q1Cw+ItQk4n9UVuF2vDsSAAL/0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QIl/rRjqQ87S2c1uQhTrQXlQndCNYiPRa51nZKaM39iK4MWtmYObXRDrMvF17SpwO
         5IfbHW9nh1tojQ+AeMrY3ceQDM0NRJrAYUnx+5fa9MNAVPIij1gDTZM8UIJBMfg+J9
         M1sHrrmR1y1wMP0gd/M/+DDo7G4uc1eAesgDPI/o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200331104532.12698-1-chunyan.zhang@unisoc.com>
References: <20200331104532.12698-1-chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] clk: sprd: don't gate uart console clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Sat, 04 Apr 2020 20:08:06 -0700
Message-ID: <158605608663.158626.7732167785990086489@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-03-31 03:45:32)
> Don't gate uart1_eb which provides console clock, gating that clock would
> make serial stop working if serial driver didn't enable that explicitly.
>=20
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---

Do you have a Fixes: tag?
