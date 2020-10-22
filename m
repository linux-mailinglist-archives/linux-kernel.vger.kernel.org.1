Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0551296137
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505378AbgJVO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504821AbgJVO5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:57:46 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DA3C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EI7SUHNGo9RIx0dNIUmbKVTRaF3ifnJ7HykDmE4g0kA=; b=GFfjiu0pPasi/OTB9R4P4Xoei
        YzMLcZbLe4gEsd8KmuTaYF6gh8hETygpFkKLT+Bsbune1Wbdu6kQ9McFVQiXzkZOU0QRdeGHCVz3y
        61Eu/CkXANq4VZCe71o6H5RBmympCmjkA0hC5QVzWmhEiGenFHJGYY5Edcm4Vnqj0V+8WkQRrYGsY
        9oo+aGAZMcMVQ6iqe+zRxzXlbQbgECiw+b/mQFarK/Ca9JyWdR+MbHQGXtnJKFFV1eW2KtdBoBtC6
        D4l+0rlgvHtazJfKlan4ZanxQFUjhx+RQ0EB5oP1TJmaDtkYSc9c3fmJhGilLDDt0piB8MKxuiAjk
        VSZYWFq2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49556)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kVc23-0002AJ-O3; Thu, 22 Oct 2020 15:57:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kVc23-0007UR-1g; Thu, 22 Oct 2020 15:57:35 +0100
Date:   Thu, 22 Oct 2020 15:57:35 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
Message-ID: <20201022145734.GO1551@shell.armlinux.org.uk>
References: <20201021225737.739-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021225737.739-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
> The vfp_kmode_exception() function now is unreachable using relative
> branching in THUMB2 kernel configuration, resulting in a "relocation
> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_exception'"
> linker error. Let's use long jump in order to fix the issue.
> 
> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

I guess the problem is that vfp_support_entry is in .text which tends
to be at the beginning of the text section, but vfp_kmode_exception
is in something like .text.vfp_kmode_exception ?

Would it be an idea just to change the section name that stuff like
vfp_support_entry ends up in, rather than making the code less
efficient?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
