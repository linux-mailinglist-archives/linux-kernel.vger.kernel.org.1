Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45826104E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 12:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgIHKyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 06:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgIHKxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:53:30 -0400
Received: from localhost (unknown [122.182.239.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 157C82087C;
        Tue,  8 Sep 2020 10:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599562407;
        bh=vvMiXR8spWwHMb+QxzD+PUuB6XpvOzXxHSAg0g2aaZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdZAcsVpxkSPQGIu7813LmCvxXjzLGMaw7vlVi3SEmYmA3z1MQdXymXxLgImz//i8
         wAynp+ut5Z8MiQsWWcv4fA+/J/ZRZtbkCEuXT0l5m9RLbUfwzp9PhEz6pHEKUnkKdI
         jI2ecwwAIKUPMSuNolJg7A/8dENgIjPJHjA0MNG8=
Date:   Tue, 8 Sep 2020 16:23:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Roger Quadros <rogerq@ti.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] phy: ti: am654: Fix a leak in serdes_am654_probe()
Message-ID: <20200908105319.GE77521@vkoul-mobl>
References: <20200905124648.GA183976@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905124648.GA183976@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-09-20, 15:46, Dan Carpenter wrote:
> If devm_phy_create() fails then we need to call of_clk_del_provider(node)
> to undo the call to of_clk_add_provider().

Applied, thanks

-- 
~Vinod
