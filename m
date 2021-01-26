Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36331303BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405319AbhAZLmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404229AbhAZLAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:00:21 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC28C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zxNMCtXliQ1UV7PXH/s1fAYCtYOC1OUZ5jx5WwFzVj4=; b=rnHi2H7Klf6UwcFvsAH0iDxVd
        CKnMn/0ZlVsH8q+a7O9XUlwNqDr3ylIx9M1KWtDK46OcJZPvviWAho9kUnAtD7vnnvlIsNg3Wa2ZH
        PufiuchMWzjBtv92avIpkJKoNj9guDwjvmGgv8Yex5SJZo2rZImQZcqTgwFI0Scg/opMWYQf1e0lu
        2COOKEH0vuv5ZUQoJty1SlKg5PfnAit72lB/fEyds2o/IwvhFMJiWmWNuUDusg0wAQTqNUmcqeRIh
        TjuwVdTRNu2ggFJr+vzHuVYDdYY4AurCizQ00aCD8+X0+EqEIAyBAFJtV81sx4G9fYeIh6oXBkLSb
        Fvs8fS1PQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52926)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l4M4P-0004Ig-0X; Tue, 26 Jan 2021 10:59:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l4M4K-0003jk-UC; Tue, 26 Jan 2021 10:59:32 +0000
Date:   Tue, 26 Jan 2021 10:59:32 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, peterx@redhat.com, rppt@kernel.org,
        walken@google.com, yj.chiang@mediatek.com
Subject: Re: [PATCH] ARM: mm: harden branch predictor before opening
 interrupts during fault
Message-ID: <20210126105932.GG1551@shell.armlinux.org.uk>
References: <20201203092738.11866-1-lecopzer.chen@mediatek.com>
 <20210126091708.3461-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126091708.3461-1-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 05:17:08PM +0800, Lecopzer Chen wrote:
> Hi all,
> 
> I don't see any fix for this issue now(maybe I missed it..?),
> could we fix this if there is better solution?
> This issue exists almost two years.

I don't think anyone provided an acceptable patch.

The first patch moved the hardening out of the translation/section
fault handling. Since the kernel is mapped with sections, these
are above TASK_SIZE, and the whole point of the branch prediction
hardening is to prevent the prediction in the kernel being exploited,
missing the hardening effectively makes the mitigation useless.

The discussion in February 2019 never concluded from what I can see.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
