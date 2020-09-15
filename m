Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED03C26B7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgIPAcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgIONoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:44:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B12C061224
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vS9dprs3mRpIFhGU4DY0+D6/A+zkpO/AvSqyLXig3yE=; b=c/D6mpNks7dkDt8rnBwNZBIYI
        D4d5XIQubHBqCXCPpBhfsbdBPhrojbncg1BE7x/f7CNpUUt8ENvu9ntv/H+0Edr2XaRlroSHYh1Gj
        Bm/klpzijmvVONgPhJCN4nemrfihVaO0ftjHsCxcUcqKcjUB4H/JCUb3lO97DnCn7PiHPFuKn78lo
        S6rKk17hV9H/3jdil/OtZp7eplgddX+IYrrwPI98U71iLSNTjmAzayZb9ngOGTonXoWuWVmJQVbcx
        jN05vohgvMufYEEhtMx95cWxiBwAMYsKEXGQYn+XLytIIStuSFVyuDJ1KYAMWQE+lGmB4xk6h9IV5
        5/8ksjd+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33980)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kIB3k-0002xq-CM; Tue, 15 Sep 2020 14:31:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kIB3i-0003iD-T0; Tue, 15 Sep 2020 14:31:46 +0100
Date:   Tue, 15 Sep 2020 14:31:46 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: Re: [PATCH v2 0/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB
 boundary
Message-ID: <20200915133146.GN1551@shell.armlinux.org.uk>
References: <20200915131615.3138-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915131615.3138-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:16:13PM +0800, Zhen Lei wrote:
> v1 --> v2:
> Nothing changed, but add mail list: patches@armlinux.org.uk

It isn't a mailing list, it's a bot, and it should only be copied
when you're ready to submit the patches, and only after they've been
reviewed.  It queues the patches for me to eventually apply, so I
don't have to wade through tens of thousands of emails to find (and
likely miss) the appropriate patches.

It also wants to have a KernelVersion: tag somewhere in every patch
email, which has proven to be extremely valuable when applying.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
