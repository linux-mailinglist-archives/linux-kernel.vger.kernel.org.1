Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2C2ACB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgKJCbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:31:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJCbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:31:17 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE161206D8;
        Tue, 10 Nov 2020 02:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604975477;
        bh=nIftRqukhiatVSV2khoi1WGKR8k8edurJsKXrq9yiUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2gYUUBm8IlZ674Gi8Ft8HSyaXlqX3T0S8YiFDHQFc/id1mI4gD2Qh8cL9F4NJLCy
         8TiJh516VBt+HxeeIKYmffVM2f3rCtKYMq+oN/myTnTvGFMVJVQQrIsmbE/9zZ+UNz
         vfRUoR52XuO3m8CjWeOl/zMnb8ecXztG9oqrciXc=
Date:   Tue, 10 Nov 2020 10:31:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: document LS1012A FRWY board
Message-ID: <20201110023111.GU31601@dragon>
References: <20201105184808.216384-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105184808.216384-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 07:48:07PM +0100, Krzysztof Kozlowski wrote:
> Document the compatible for LS1012A FRWY board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied both, thanks.
