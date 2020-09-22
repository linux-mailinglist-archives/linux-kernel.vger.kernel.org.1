Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B22273A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 07:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgIVF4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 01:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgIVF4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 01:56:09 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C9023A84;
        Tue, 22 Sep 2020 05:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600754169;
        bh=IU8Osrx9ikXPTeNH2LlFGn9w+0hVNcQw4CIvV52PRYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnAtiod+1yb5H61zzfDrxz+My9CAJd2+MPyiUaL8peQF2Cm7FM3R0XsXIr/V/XxKS
         h+BVu9tSsYz6eDlf+dkrzKZqK2wjfdMYTpM2ePlpf84UI8RgFH63pTIoXNcpTNZmIT
         +2SG5WH3BGodZctz/jTi17e9wtCTTy5L4G2YtQaE=
Date:   Tue, 22 Sep 2020 13:56:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [Patch v2] arm64: dts: layerscape: correct watchdog clocks for
 LS1088A
Message-ID: <20200922055604.GZ25109@dragon>
References: <20200922033146.27118-1-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922033146.27118-1-qiang.zhao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:31:46AM +0800, Qiang Zhao wrote:
> From: Zhao Qiang <qiang.zhao@nxp.com>
> 
> On LS1088A, watchdog clk are divided by 16, correct it in dts.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>

Applied, thanks.
