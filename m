Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55C32B8B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKSGUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgKSGUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:20:09 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417EB246A5;
        Thu, 19 Nov 2020 06:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605766809;
        bh=ewVynSpX0/ViirPnVTI87nakm1E3WxX3hJ27qLPnf0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KruSxerzBdUygzbXq6Yn79+FYeyLwCa7OJzplJi1bd5YAMfCdQtGXYJbRvsUoKmM7
         9xmdB9H4GLzF+RgSWWxK8f4yrPAbL8Mg0Gs8NTmMz0F4ypOcFhy5dOydZ7hZvHML3C
         z6/bHzg9m5A0QVatcy7mpbfqheZDxDpk4ku/Cbb8=
Date:   Thu, 19 Nov 2020 11:50:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     tiny.windzz@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ondrej Jirman <megous@megous.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [RESEND PATCH 09/19] phy: allwinner: Convert to
 devm_platform_ioremap_* API
Message-ID: <20201119062004.GD50232@vkoul-mobl>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <e16729e3e19f4b1f401d6b62621d00ab3ee4ec3a.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16729e3e19f4b1f401d6b62621d00ab3ee4ec3a.1604988979.git.frank@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-20, 14:35, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> Use the devm_platform_ioremap_resource_byname() and
> devm_platform_ioremap_resource helper to simplify the code.

This fails to apply for me, pls rebase

-- 
~Vinod
