Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955BC29DCFC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbgJ1WUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731719AbgJ1WRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:42 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CAD24178;
        Wed, 28 Oct 2020 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603870851;
        bh=MPRNWsmlHlmPsByxRhqWUs0lMXiZSGUsW+ULFeJGgQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXPJGJSkKKWc5VG3TP2Duy4gSMFfng9JwE/+wBqPbtIRkDoW3m2zHjoglCd6BxK6U
         BfpD7XcTocgRgY91TWvEiWQvKX2+aWL+eWGuCaQxPI0y21addEGWv2QpfWpHFXpmup
         IKGUL74G5aBoAjxhNMX2qlRytwptvb3iLPxu8VUw=
Date:   Wed, 28 Oct 2020 15:40:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/13] ARM: dts: imx7-mba7: remove unsupported PHY LED
 setup
Message-ID: <20201028074045.GP9880@dragon>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
 <20200918112942.1367-5-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112942.1367-5-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:29:34PM +0200, Matthias Schiffer wrote:
> These properties were never supported by the DP83867, and a patch
> implementing them was rejected in favor of a different solution. Remove
> them.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied, thanks.
