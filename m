Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442BC2A2CEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgKBO1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgKBO1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:27:01 -0500
Received: from localhost (unknown [122.179.37.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE91206B7;
        Mon,  2 Nov 2020 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604327221;
        bh=2+l7P/0+p7hN/S7HNVXHorSTp3zzZhgUb+08NYI58js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHmWA0MojcJF0vb0SGVbAGNxdttGr4Vo3Tjmkd/X/Vz+ykG0YCYOBx/LMEeo74SCu
         vhktKwycEPB6+MXGag93yaNjQrsVUH5QP+sp1dV3186lRdrrVgAxrepnlJ3jNCpccA
         olcuAe9jx57opAeAtxYgXQQH7/2Dis6i49/mJzN4=
Date:   Mon, 2 Nov 2020 19:56:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND 2 PATCH v3 0/3] phy: Add USB HSIC PHY driver for Marvell
 MMP3 SoC
Message-ID: <20201102142655.GB2621@vkoul-mobl>
References: <20200925235828.228626-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925235828.228626-1-lkundrak@v3.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-09-20, 01:58, Lubomir Rintel wrote:
> Hi,
> 
> please consider applying this patch set. It adds the HSIC PHY driver for
> Marvell MMP3 along with related DT binding changes.
> 
> In response to previous submission it was suggested that a cast of
> private data be removed, but it actually serves a purpose:
> https://lore.kernel.org/lkml/20200903201404.GA115604@demiurge.local/

Applied, thanks

-- 
~Vinod
