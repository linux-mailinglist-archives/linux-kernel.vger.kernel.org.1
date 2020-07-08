Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37CF2185C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 13:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgGHLO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 07:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGHLO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:14:28 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E9220739;
        Wed,  8 Jul 2020 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594206868;
        bh=HuTn2+p7wIhJTjMMiQ1v3hdP2M2atw3I9rw/YACMxDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0wfsx9LQy82GvY+kxArYcegb6A8taFC77/zCYSD265KrweGPDC1hbb6VP9UkOwq17
         6Fd5qcb18RPRUAmwTL+DRgz6v4ocx8/E7UTYRQgB5kCej9jXiwke5iVQicuQ9dz8EG
         TgKY8XEEmLaTQ3Q2g2DhQXJK1xBig4BKXSycRFdM=
Date:   Wed, 8 Jul 2020 16:44:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] phy: core: fix code style in
 devm_of_phy_provider_unregister
Message-ID: <20200708111424.GE34333@vkoul-mobl>
References: <20200629145010.122675-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629145010.122675-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-20, 20:20, Vinod Koul wrote:
> Documentation/process/coding-style.rst says:
> "functions: they have the opening brace at the beginning of the next
> line"
> 
> devm_of_phy_provider_unregister() function has opening brace at same
> line, so fix it up.

Applied all these
-- 
~Vinod
