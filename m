Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8152835E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgJEMlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgJEMlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:41:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E5082085B;
        Mon,  5 Oct 2020 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601901666;
        bh=MxeNG5N+bM3eUhmakr5B2npIgpAfMPwHUv3TICzH90A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9JfpyobFCWkkntrf3cqiBSiexASGgN4lTlHveVeQRKIhoVh+2XDwAtXNScNGFe0q
         BhyxXVB4w4Z9EsVxaOO1IA2EIs2j6b5M3VuTUZGj4AQMRUPiFxx3eZxtFHql1DZLOc
         DxUsZdOsb1YDbqjymjGED1sTD0V2bn6/NEjuThQc=
Date:   Mon, 5 Oct 2020 14:41:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     b_lkasam@codeaurora.org
Cc:     broonie@kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v2] regmap: irq: Add support to clear ack registers
Message-ID: <20201005124152.GB800868@kroah.com>
References: <1601896560-27938-1-git-send-email-lkasam@codeaurora.org>
 <0f3da3b378ee9af7030d8bafa30b8dfd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3da3b378ee9af7030d8bafa30b8dfd@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:55:27PM +0530, b_lkasam@codeaurora.org wrote:
> <diff in v1 to v2 , addressed formatting and simplified logic >

That goes below the --- line, as the documentation says, right?

And this whole thing was attached, twice, why?  Can't you use 'git send-email'?

> For particular codec HWs have requirement to
> toggle interrupt clear register twice 0->1->0.
> To accommodate it, need to add one more field
> (clear_ack) in the regmap_irq struct and update
> regmap-irq driver to support it.

Nit, we have 72 columns to fill, might as well use it :)

thanks,

greg k-h
