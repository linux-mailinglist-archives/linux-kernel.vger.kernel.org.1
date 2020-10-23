Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FAE296C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461983AbgJWKNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461951AbgJWKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:13:03 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A535C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Etqkj2bfKGrEGoasEHlQF8c/aYVNaOVt7ntOYQjQy0U=; b=bb/ID+nt/J/pIMZmWsDKIuo9f
        jylxYWY6FzN4XPAxXyJTeSC6OgQs6+fzpVejDl1UozSPJSvSI8UKdW3pVUtRljaVybV4biSqDKMJ/
        JVTTaJk1IZknFfdMjEqGs3zD07xjeaJump4i1INPvETbcPy75j5Xh8AHgL6Uh16FaX3+YXxpg7EDU
        LnC4K8cohqxa40H7oWEqfG6MdtQElFWfiIM6z5m+3tZgWL1MJpmQ9a3bkNA8zfeENLphhDC0F9/gm
        8wpGlzFsijAwLCcZDGP7LUW5tbgvZkj9X0mkr5WRjRCJYMVrwS5jOgDxu3XGHAqKZeB7OTuSji26m
        DgThbypDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49922)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kVu4A-0003HE-Qn; Fri, 23 Oct 2020 11:12:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kVu4A-0008MK-4j; Fri, 23 Oct 2020 11:12:58 +0100
Date:   Fri, 23 Oct 2020 11:12:58 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 4/4] arm: replace vector mem type with read-only type
Message-ID: <20201023101257.GZ1551@shell.armlinux.org.uk>
References: <20201023091437.8225-1-miles.chen@mediatek.com>
 <20201023091437.8225-5-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023091437.8225-5-miles.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:14:37PM +0800, Miles Chen wrote:
> Since kernel no longer writes to the vector, try to replace
> the vector mem type with read-only type and remove L_PTE_MT_VECTORS.
> 
> from Catalin in [1]:
> "
> > I don't think this matters since the kernel no longer writes to the
> > vectors page at run-time but it needs cleaning up a bit (and testing in
> > case I missed something). IOW, do we still need a dedicated mapping type
> > for the vectors or we can simply use the read-only user page attributes?
> "

Catalin is incorrect. If CONFIG_KUSER_HELPERS is enabled, then the
vectors page is definitely written to - it's a user interface, so
it's not going to change:

#ifdef CONFIG_KUSER_HELPERS
                        /*
                         * User space must never try to access this
                         * directly.  Expect your app to break
                         * eventually if you do so.  The user helper
                         * at 0xffff0fe0 must be used instead.  (see
                         * entry-armv.S for details)
                         */
                        *((unsigned int *)0xffff0ff0) = val;
#endif

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
