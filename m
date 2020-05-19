Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A01D9D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgESQ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 12:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgESQ4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:56:37 -0400
Received: from localhost (unknown [122.182.207.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4C5204EA;
        Tue, 19 May 2020 16:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589907396;
        bh=IupW7XaMJkYsAayJCAozFvTTvpKJWQQBm6o5U94IMBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wpq3faH0UEduYmM5h1fBDkA1ZA33Iw8GA1bwkOTlaDqWlOFKRjHIf/6rQ48aDkK1I
         +Dxj/G8unzQ6VJFUkh67Ufvbwuha8uSsHCPutEYuiMgAP+uCT/C2s/VRCUr5lCEpjx
         EOaHnn7jg/+WwcL8rnnHQ2sQThRvMPaFB1uj4QJk=
Date:   Tue, 19 May 2020 22:26:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        dan.j.williams@intel.com, thierry.reding@gmail.com,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra210-adma: Fix an error handling path in
 'tegra_adma_probe()'
Message-ID: <20200519165632.GQ374218@vkoul-mobl.Dlink>
References: <20200516214205.276266-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516214205.276266-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-05-20, 23:42, Christophe JAILLET wrote:
> Commit b53611fb1ce9 ("dmaengine: tegra210-adma: Fix crash during probe")
> has moved some code in the probe function and reordered the error handling
> path accordingly.
> However, a goto has been missed.
> 
> Fix it and goto the right label if 'dma_async_device_register()' fails, so
> that all resources are released.

Applied for fixes, thanks

-- 
~Vinod
