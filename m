Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BAF1BA9B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 18:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgD0QD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 12:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0QD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:03:26 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9B2206B8;
        Mon, 27 Apr 2020 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588003405;
        bh=q36QjKLYRyVIxmZTydDEyFQg1pcE75EQUcnlgYcer68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSbbfGuP7fCD020/Rs2JW90doRjTaXpI5ir+BqWJnflvWvv1RqCGRLHRDGtpJarDE
         KQK8H4BUCA4fBU2TlTy5pDYYfe0Tc/0cgeFXFYppMkDao+1Qy5rF5EocwYChUzC0+w
         Y7Oz60bad9zvU5WC+Lvf/v/6psqdrXRvax2ZUM/s=
Date:   Mon, 27 Apr 2020 21:33:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: mmp_tdma: Validate the transfer direction
Message-ID: <20200427160321.GG56386@vkoul-mobl.Dlink>
References: <20200424215020.105281-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424215020.105281-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-20, 23:50, Lubomir Rintel wrote:
> We only support DMA_DEV_TO_MEM and DMA_MEM_TO_DEV. Let's not do
> undefined things with other values and reject them.

Applied, thanks

-- 
~Vinod
