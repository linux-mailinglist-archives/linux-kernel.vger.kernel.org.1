Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1F27385B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 04:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgIVCKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 22:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbgIVCKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:10:22 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD3623A60;
        Tue, 22 Sep 2020 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600740621;
        bh=XZczhTgAZGsIgbD+c4n4Fx0GFxASgQbi7YL69H71dtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cChWXxnic1ifw9fcFQnjouao3r5jlKa8WhdzhQy3BfhBeztcWU4WfarlIGIjzx6od
         aFtSvGa8noVzN3dZ+FymcCKVLLhwMVxaeIri14j6ZPCTh++iyku65qzPHJmoxO4MW1
         zLHtsWgNAi0t24XopjRsP4kdw+UoPyHl3bhcCsIY=
Date:   Tue, 22 Sep 2020 10:10:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wasim Khan <wasim.khan@oss.nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.sethi@nxp.com,
        Wasim Khan <wasim.khan@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: layerscape: Add label to pcie nodes
Message-ID: <20200922021015.GS25109@dragon>
References: <1599974476-10617-1-git-send-email-wasim.khan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599974476-10617-1-git-send-email-wasim.khan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 10:51:16AM +0530, Wasim Khan wrote:
> From: Wasim Khan <wasim.khan@nxp.com>
> 
> Add label to pcie nodes so that they are easy to
> refer.
> 
> Signed-off-by: Wasim Khan <wasim.khan@nxp.com>

Applied, thanks.
