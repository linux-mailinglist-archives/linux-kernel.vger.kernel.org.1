Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788E020D28E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgF2SuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbgF2SuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:15 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 973D423A9E;
        Mon, 29 Jun 2020 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593451898;
        bh=pZLE0/dEHdwtp1oF+MjAXEqXTqNgCVHIaSv2gtI5f9s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=f8qUjanzM6fLEdaY60FSVA2CwIpF7kO3WkjuSqnlYh2jAqvKu+o1wsZn6UNERVwIF
         d5ckFCxNes91ngGOaJMu6uCEBfCbVaipt8RQGri9T2gF+zuWrwVtmqNzy7jmm4wNgB
         LkU2C0N/4opuiae+izYpmAUFEmj7mr1ZBpWbIpd4=
Date:   Mon, 29 Jun 2020 10:31:37 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Xiaofei Tan <tanxiaofei@huawei.com>
cc:     sstabellini@kernel.org, linux@armlinux.org.uk,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, jgross@suse.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH] arm/xen: remove the unused macro GRANT_TABLE_PHYSADDR
In-Reply-To: <1593305826-28279-1-git-send-email-tanxiaofei@huawei.com>
Message-ID: <alpine.DEB.2.21.2006291031050.8121@sstabellini-ThinkPad-T480s>
References: <1593305826-28279-1-git-send-email-tanxiaofei@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jun 2020, Xiaofei Tan wrote:
> Fix the following sparse warning:
> 
> arch/arm64/xen/../../arm/xen/enlighten.c:244: warning: macro
> "GRANT_TABLE_PHYSADDR" is not used [-Wunused-macros]
> 
> It is an isolated macro, and should be removed when its last user
> was deleted in the following commit 3cf4095d7446 ("arm/xen: Use
> xen_xlate_map_ballooned_pages to setup grant table")
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  arch/arm/xen/enlighten.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index fd4e1ce1..e93145d 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -241,7 +241,6 @@ static int __init fdt_find_hyper_node(unsigned long node, const char *uname,
>   * see Documentation/devicetree/bindings/arm/xen.txt for the
>   * documentation of the Xen Device Tree format.
>   */
> -#define GRANT_TABLE_PHYSADDR 0
>  void __init xen_early_init(void)
>  {
>  	of_scan_flat_dt(fdt_find_hyper_node, NULL);
> -- 
> 2.7.4
> 
