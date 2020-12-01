Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0E92CA684
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391669AbgLAPFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbgLAPFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:05:13 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F3C0613CF;
        Tue,  1 Dec 2020 07:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lQkIAITTxB6dPbZfefyPfQUOz6UBfNpX4sJm/fCoIDk=; b=hktHOsboRi8yvEDCwuTZGRu/0
        Ic45sRVJ42vTGFqx8/jXtEmFwBV0B1wnH0dWmOEYag1ty1hoLdZOR3luxSy7fiPPomQqz9XYOdXg2
        hCqAhFf16vnwili4UqxZsz+JU9GU02mX5mWZt2ughzQN0XemGkSN3XGC9QChj3S68TFYtuT3uaeE8
        ybi19YOI746dhucIHRDgV2lkWktLam4uc+HwMr7grrBw/9fVmrTD6d8MrSJAZ3x90t9fvQ/yXgwi5
        ku9iAeKsc2OAyDTTxrnnXw8on8WSl2riYClmz4jBqJ66JxlrO5XwXNJtFxI893mExu01ZfDB7YMet
        rfOZ+rTMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38450)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kk7Cc-0000Ec-PQ; Tue, 01 Dec 2020 15:04:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kk7Cb-00066C-Hx; Tue, 01 Dec 2020 15:04:25 +0000
Date:   Tue, 1 Dec 2020 15:04:25 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, arnd@arndb.de, robh@kernel.org, w@1wt.eu
Subject: Re: [PATCH v2 10/10] ARM: mstar: SMP support
Message-ID: <20201201150425.GC1551@shell.armlinux.org.uk>
References: <20201201134330.3037007-1-daniel@0x0f.com>
 <20201201134330.3037007-11-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201134330.3037007-11-daniel@0x0f.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:43:30PM +0900, Daniel Palmer wrote:
> +	np = of_find_compatible_node(NULL, NULL, "mstar,smpctrl");
> +	smpctrl = of_iomap(np, 0);
> +
> +	if (!smpctrl)
> +		return -ENODEV;

Wouldn't -ENOMEM be more appropriate here?
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
