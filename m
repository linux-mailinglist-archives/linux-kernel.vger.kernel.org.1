Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE212E7280
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 18:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgL2RFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 12:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL2RFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 12:05:03 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A0C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 09:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FhCXE7slKDeIxopRDJZcSEDk1dcwjpLiihzO8A1DLYI=; b=AYhIRsKhcTRQMcw8YcP2xAlQP
        ZJ7L1gjPikShRcrMBIm+phM9DzBwgyb0v11vAj4qepLHcuoQCQ/NlJtACcoE85OrXpInyCAaBMdSK
        Td2Oykho2vQPWR407CJe6NN7DvuTOvf4sZVp/IqpijQq4Ql19Eth2DJJNXKEADW40L9qBSdzqth9B
        EFsTsXoylISXM1eFdZlh/4udhreDKyRgx2I56jZQ5P2Y9KY1s7hN0PXwTmxKSY1hBY9a8Zin52g22
        EXWzcXymEZ+3X3p4nwONwEJSJrHE8RtZQ5JTPQcg5BmKCwqOrdP16VOMLuXW4iPmd675vwWZ8D84Y
        UNTNCYeMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44878)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kuIPv-0005F2-Sw; Tue, 29 Dec 2020 17:04:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kuIPs-0001ON-Dm; Tue, 29 Dec 2020 17:04:12 +0000
Date:   Tue, 29 Dec 2020 17:04:12 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com, Will Deacon <will@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH] KVM: arm64: Allow PSCI SYSTEM_OFF/RESET to return
Message-ID: <20201229170412.GN1551@shell.armlinux.org.uk>
References: <20201229160059.64135-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229160059.64135-1-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 04:00:59PM +0000, David Brazdil wrote:
> The KVM/arm64 PSCI relay assumes that SYSTEM_OFF and SYSTEM_RESET should
> not return, as dictated by the PSCI spec. However, there is firmware out
> there which breaks this assumption, leading to a hyp panic. Make KVM
> more robust to broken firmware by allowing these to return.

Are you sure you should just return?

We've had issues in the past with Linux reboot(2) that returns
to userspace, allowing on 32-bit ARM for example watchdogs to
unexpectedly continue being serviced.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
