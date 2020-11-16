Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9D2B3D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKPHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:24:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgKPHYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:24:06 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A7B2224F;
        Mon, 16 Nov 2020 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605511446;
        bh=ByHT9+UJJp/kgiPNG9XUcHm8nJKa853R/14JRHtTB2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udI4quK0a+CvExSFr/yBdF9HnI0RfdGMtbCQT9do8mPnzLjHUOJh8cCQzgeJjg0UQ
         IQig2N/qYYOFADmvT+3G9Rj8FPvElc5peF8juD80l2qtYXVC9Tz0mB9xUQE0zISpie
         DfpJBs2gtj7VZen1YFPY9h8Unh8GApEEH+JWb2Xg=
Date:   Mon, 16 Nov 2020 12:54:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     khilman@baylibre.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        p.zabel@pengutronix.de, repk@triplefau.lt,
        lorenzo.pieralisi@arm.com, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] phy: amlogic: Replace devm_reset_control_array_get()
Message-ID: <20201116072401.GG7499@vkoul-mobl>
References: <1604378274-6860-1-git-send-email-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604378274-6860-1-git-send-email-yejune.deng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-20, 12:37, Yejune Deng wrote:
> devm_reset_control_array_get_exclusive() looks more readable

Applied, thanks

-- 
~Vinod
