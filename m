Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55DD25735C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 07:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHaFjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 01:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgHaFja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 01:39:30 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C302078D;
        Mon, 31 Aug 2020 05:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598852370;
        bh=TVpeHL8DztDQfIvpd7OpdvJo+IpYeML1Vs+qZ/+RMqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qi+PH2IfW3DE0E2RQ2mLUHKtKWw+SEuBhmSj+TJdRus1hS0Rcgxju0ZvVYZT7JkZ/
         UtErle750c2h2YF61Ai5ZayAC+zqBcbgxTJHZ9E5vN/iUMSGH4T5K2IQgMDaTa8OEa
         8kS+7hTs1BrkkR3seuGhZnz6YI+9vHnLk5AJnHnY=
Date:   Mon, 31 Aug 2020 13:39:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: fsl: Add binding for Variscite
 VAR-SOM-MX8MM module
Message-ID: <20200831053924.GJ4488@dragon>
References: <20200824191819.11057-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824191819.11057-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:18:16PM +0200, Krzysztof Kozlowski wrote:
> Add a binding for the Variscite VAR-SOM-MX8MM System on Module.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all, thanks.
