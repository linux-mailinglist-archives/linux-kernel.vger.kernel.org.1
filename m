Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616521D7EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgERQjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:39:53 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFCCC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uxUQwkSwUxkH3FLsgT0bH6KrkNI2haRpYKPWpkc6Sm0=; b=wMsHcUTNr7cX72TtW/aR6d3qj
        sihvtTWT36DNfWX5S+rgkZi5x2OmVjlYn09iqSnfgWCgsXKj9Q90D1n9zohsc8wWkYi2ZOb1NaDXL
        UkTtzBicoI80s3K3Jx8i/1JLt3v/Kpa5GurNrhh91TLfXG1/ihRNzVkNVLbj8rUUwdv5gnbwhYKn5
        4tYOOUYw+n0G81FnfFRb5peB1d+Fmbo36CCdfnz4o2JUbw+1t5DGmLX9Csfila13MnaorGmSwpnBC
        HPfO3Hc/KS7dvjpA6piFC6LOOb64J3M85unRJS3HR8LACMiDhSJWH77FBZd4VnNtUleK2czCaUMog
        mGDYYZFHQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59612)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jainm-0002s0-FB; Mon, 18 May 2020 17:39:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jaink-0004qr-NU; Mon, 18 May 2020 17:39:40 +0100
Date:   Mon, 18 May 2020 17:39:40 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Fredrik Strupe <fredrik@strupe.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PING] [PATCH v2] arm: ptrace: Fix mask for thumb breakpoint hook
Message-ID: <20200518163940.GW1551@shell.armlinux.org.uk>
References: <20200413173841.29651-1-fredrik@strupe.net>
 <d7381f90-f597-2a9c-4387-5714b41e02e6@strupe.net>
 <20200518141858.GV1551@shell.armlinux.org.uk>
 <0afefde9-f121-c88c-2ceb-7c02f7561979@strupe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0afefde9-f121-c88c-2ceb-7c02f7561979@strupe.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 05:02:27PM +0200, Fredrik Strupe wrote:
> On 18.05.2020 16:18, Russell King - ARM Linux admin wrote:
> > On Mon, May 18, 2020 at 03:12:06PM +0200, Fredrik Strupe wrote:
> >> call_undef_hook() in traps.c applies the same instr_mask for both 16-bit
> >> and 32-bit thumb instructions. If instr_mask then is only 16 bits wide
> >> (0xffff as opposed to 0xffffffff), the first half-word of 32-bit thumb
> >> instructions will be masked out. This makes the function match 32-bit
> >> thumb instructions where the second half-word is equal to instr_val,
> >> regardless of the first half-word.
> >>
> >> The result in this case is that all undefined 32-bit thumb instructions
> >> with the second half-word equal to de01 (udf #1) work as breakpoints
> >> and will raise a SIGTRAP instead of a SIGILL, instead of just the one
> >> intended 16-bit instruction. An example of such an instruction is
> >> eaa0b650, which is unallocated according to Arm ARM and should raise a
> >> SIGILL, but instead raises a SIGTRAP.
> >
> > How can 0xeaa0b650 match 0xde01 when masked with 0xffff ?
> >
> 
> Sorry, that is a typo; it should say 0xeaa0de01.
> 
> For reference, this is similar to the problem with SETEND emulation that
> was fixed in commit fc2266011acc in the mainline kernel
> (or as discussed here: https://lkml.org/lkml/2020/4/8/274).

Thanks for the clarification.  Please update the patch description and
put it in the patch system, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
