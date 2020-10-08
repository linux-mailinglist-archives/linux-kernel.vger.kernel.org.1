Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804FF2870B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgJHIan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgJHIam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:30:42 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092A4C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cMmuoGSKgeD19xItCxRdhXtN+onzhgSlKtje6kSCEb8=; b=D+EEMj8FHV7ddNQuQolpI9MAF
        QnL44h2cIYtDfI65qxZegR3gQJArHvuUU1z5PyG23NR0GkAN2SawrQ9DPa3ioUcQgyMQYkJZGOI/s
        hJ2+yhRoLot8ipCdk/HKmCe3HyNYaCMX06/ycHZKyfoAQdlnYmA4fGonOudF2uEdMWW8sal4C7Bvq
        yG12VUERMMeD8xQH1Jn4K5LbrGu0Xzm/8NvxdCUfXOiJNZQrABZnJTg4ayZ8vpwnw55awYoxf/a2k
        g/NDzOr+2TAHZNNCL6LVQPoyiDuxmAV+OWqbqQ0A8cmYkKF1IGqOXZPExCTGsl9NbMI/s2TKwdyqy
        XCLvRJMtA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43404)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kQRJb-0006BR-Qy; Thu, 08 Oct 2020 09:30:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kQRJX-0001W9-PW; Thu, 08 Oct 2020 09:30:15 +0100
Date:   Thu, 8 Oct 2020 09:30:15 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     ndesaulniers@google.com, caij2003@gmail.com, tglx@linutronix.de,
        bigeasy@linutronix.de, maz@kernel.org, valentin.schneider@arm.com,
        vincent.whitchurch@axis.com, nhuck@google.com,
        akpm@linux-foundation.org, 0x7f454c46@gmail.com, will@kernel.org,
        a.sahrawat@samsung.com, v.narang@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] IRQ stack support for ARM
Message-ID: <20201008083015.GK1551@shell.armlinux.org.uk>
References: <CGME20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811@epcas5p2.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 12:45:30PM +0530, Maninder Singh wrote:
> Observed Stack Overflow on 8KB kernel stack on ARM specially 
> incase on network interrupts, which results in undeterministic behaviour. 
> So there is need for per cpu dedicated IRQ stack for ARM.
> 
> As ARm does not have extra co-processor register
> to save thread info pointer, IRQ stack will be at some
> performance cost, so code is under CONFIG_IRQ_STACK.
> 
> and we don't have much knowledge and set up for CLANG
> and ARM_UNWIND, so dependency added for both cases.
> 
> Tested patch set with QEMU for latest kernel
> and 4.1 kernel for ARM target with same patch set.

You need to investigate and show where and why this is happening. My
guess is you have a network driver that uses a lot of kernel stack
space, which itself would be a bug.

Note that there are compiler versions out there that mis-optimise and
eat stack space - the kernel build should be warning if a function
uses a large amount of stack.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
