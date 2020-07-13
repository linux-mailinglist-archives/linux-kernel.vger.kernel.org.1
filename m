Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872AF21DDD4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgGMQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 12:47:56 -0400
Received: from muru.com ([72.249.23.125]:36674 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbgGMQr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:47:56 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DCF838106;
        Mon, 13 Jul 2020 16:47:53 +0000 (UTC)
Date:   Mon, 13 Jul 2020 09:47:53 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Chen Tao <chentao107@huawei.com>, linux-omap@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Fix possible memory leak in
 omap_hwmod_allocate_module
Message-ID: <20200713164753.GM5849@atomide.com>
References: <20200619104240.55978-1-chentao107@huawei.com>
 <alpine.DEB.2.21.999.2006191518380.26224@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.999.2006191518380.26224@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [200619 15:20]:
> On Fri, 19 Jun 2020, Chen Tao wrote:
> 
> > Fix memory leak in omap_hwmod_allocate_module not freeing in
> > handling error path.
> > 
> > Fixes: 8c87970543b17("ARM: OMAP2+: Add functions to allocate module data from device tree")
> > Signed-off-by: Chen Tao <chentao107@huawei.com>
> 
> Reviewed-by: Paul Walmsley <paul@pwsan.com>

Thanks applying into fixes.

Tony
