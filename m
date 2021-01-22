Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189A42FFD65
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhAVH3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:29:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbhAVH3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:29:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0AE5238EE;
        Fri, 22 Jan 2021 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611300516;
        bh=lqTGiAzeVnU69nsh9uhXuZSOcB06SVDv5uoopOtJm8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8a3RnZsqeLsq8IsjadE+tar75O6p/c2fUGVgaGZ7k718HN8XUUF/NLuhnnWr0vzs
         TokSmN1v5SrLNlMruWNoSM589Uxwlm0TA2tHuJRpEmR7H5L0ngfljESD3CBHqDKkCQ
         x4wGJzPGJYgArehoyc9NGLxCJDqNYcr0VPfEq15A=
Date:   Fri, 22 Jan 2021 08:28:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, bhelgaas@google.com, vaibhavgupta40@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] misc: rtsx: init value of aspm_enabled
Message-ID: <YAp+oKwlqmgFOX9o@kroah.com>
References: <20210122033348.15187-1-ricky_wu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122033348.15187-1-ricky_wu@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 11:33:48AM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> v1:
> make sure ASPM state sync with pcr->aspm_enabled
> init value pcr->aspm_enabled
> v2:
> fixes conditions in v1 if-statement
> v3:
> more description for v1 and v2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Also, you forgot a "Fixes:" tag.

thanks,

greg k-h
