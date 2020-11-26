Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188A92C5729
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390156AbgKZOcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbgKZOcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:32:43 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A03C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QTfMxziQKyFbMgmeFNP3IA9HsryyERPG4sSiOy7QmlE=; b=Bn0ztgSnVbK9toWFFRICXgSTr
        t6YnPG2aLMUJj5PUMlZRs3G4pwsA+48lu+8xYfyGibqG6X5rfMCVCw3YBrBC5CSRZRcx98sGrNgJL
        RfxBV5WusWbmzfDoAnBPCrcGBNDliAFRN6EJxI+DUhnmOObZ+FHbtAqzb7h+d7t0J+SDsuGuzXYmN
        ODQ767RfEAZPUjFkTp2MwlNr3yu+Qegu1lo1GrzKNSYVYMWtfXZBCZ+6HBlVarZc16D02ykUZ4k43
        sJf+xbvrqsmH78aIR6s7/5WXQuBVFqjgnFoDyz7I64C5qDM5yt8VQy7socd25KBd/IOBimtMPYg7Q
        yAIKRv1mw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36356)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kiIK8-0001sP-Kk; Thu, 26 Nov 2020 14:32:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kiIK8-00010c-21; Thu, 26 Nov 2020 14:32:40 +0000
Date:   Thu, 26 Nov 2020 14:32:40 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next 20201126 - build error on arm allmodconfig
Message-ID: <20201126143239.GM1551@shell.armlinux.org.uk>
References: <24105.1606397102@turing-police>
 <20201126141429.GL1551@shell.armlinux.org.uk>
 <28070.1606400573@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28070.1606400573@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 09:22:53AM -0500, Valdis Klētnieks wrote:
> On Thu, 26 Nov 2020 14:14:29 +0000, Russell King - ARM Linux admin said:
> 
> > The real answer is for asm/kasan.h to include linux/linkage.h
> 
> Looking deeper, there's  7 different arch/../asm/kasan.h - are we better off
> patching all 7, or having include/linux/kasan.h include it just before
> the include of asm/kasan.h?

I wouldn't like to say definitively - it depends on what the policy
now is. However, linux/linage.h is way cheaper than linux/pgtable.h
so it probably makes sense for linux/kasan.h to include it given the
number of asm/kasan.h headers needing it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
