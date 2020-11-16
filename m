Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB6C2B4044
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgKPJuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbgKPJuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:50:18 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7331D22314;
        Mon, 16 Nov 2020 09:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605520218;
        bh=PsOD6R91/tCtBguEd/kBbgBKJThdZGEnWUNGNjijS/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=go5PpPvekUihR/DmV7K7dEF+HPPSX5Fkz66KcBgwgI1Xl5chn0ctX7KzhyTjJN6uS
         aMGJMn6wIuVXiYjU+CbGt82XUgI4MrC/3tuuEneHSkc36x0LqVc0u9Z0L//cKtZa+h
         cD0m0dLZYpmw7JHiQus/9z3eEPoNNJCTu+BLIrRI=
Date:   Mon, 16 Nov 2020 15:20:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/2] phy: stm32: don't print an error on probe deferral
Message-ID: <20201116095014.GU7499@vkoul-mobl>
References: <20201110102305.27205-1-amelie.delaunay@st.com>
 <20201116073756.GL7499@vkoul-mobl>
 <1b91bea5-ffbf-37fb-98ac-6abc5f373375@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b91bea5-ffbf-37fb-98ac-6abc5f373375@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 09:02, Amelie DELAUNAY wrote:
> Hi Vinod,
> 
> On 11/16/20 8:37 AM, Vinod Koul wrote:
> > On 10-11-20, 11:23, Amelie Delaunay wrote:
> > > Change stm32-usbphyc driver to not print an error message when the device
> > > probe operation is deferred.
> > 
> > Applied all, thanks
> > 
> 
> I'm sorry for the mess, I sent a v2 for the patch 1/2:
> https://lore.kernel.org/patchwork/patch/1336206/
> Indeed, I forgot the "return" before dev_err_probe.

No worries, I have dropped this and picked v2.
Do check if the patches are fine.

Thanks for letting me know

-- 
~Vinod
