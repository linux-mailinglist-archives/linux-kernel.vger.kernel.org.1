Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6B2C8682
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgK3OTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgK3OTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:19:11 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A66CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sJ+ka9ehbBMVNS8y8pzP5FQoENz2n/b9KCNAkBAxDhQ=; b=xnZMQ0V1YxZf479NQX/Hty0e1
        RdUvqa8xWEV6UBmNosrUYJA4/H6Xb2XfD9/R7AaTCQZBVDVCpSrjN74OOctIeJcslawGoilxKGvIu
        r+fd5n5zixNmPKE8JHmCy4ijHZ+THoaoVAdFhIqAVJpaKh5BDl++2QC+6zZoITQa5g7SssnZI/KJK
        zDxvdShtAfbk8z5b66de1R7L/PyOURyMavqgnLOg0k1awvKYJH5VzW/La/meN3dUujalORgdOdxR2
        LsPlpXGUAeQ7GEc/8hLh2AiE6omz7nJ7DG3u3f6TxWtOvUher2QTDzzjn17iZKdXf7WICiZkpnZ9v
        ToayO/mxA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38012)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kjk0G-0006sS-IF; Mon, 30 Nov 2020 14:18:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kjk0C-00054X-SR; Mon, 30 Nov 2020 14:18:04 +0000
Date:   Mon, 30 Nov 2020 14:18:04 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Ard Biesheuvel' <ardb@kernel.org>, Antony Yu <swpenim@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with
 clang
Message-ID: <20201130141804.GV1551@shell.armlinux.org.uk>
References: <20201123073634.6854-1-swpenim@gmail.com>
 <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com>
 <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com>
 <20201130102122.GT1551@shell.armlinux.org.uk>
 <CAMj1kXHuERnB01sNrpY9w3C0ECOry7jCK=A2H0D4-_cBXbOmcw@mail.gmail.com>
 <ca83a5acdf514169b2fde3ec12ea59fd@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca83a5acdf514169b2fde3ec12ea59fd@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 01:58:27PM +0000, David Laight wrote:
> > And actually, the same applies on BE, but the other way around. So we
> > should mark __xl as an output register as well, as __xl will assume
> > the right value depending on the endianness.
> 
> Why not use "+r" to indicate than an 'output' parameter is also
> used as an input.
> 
> Rather cleaner than specifying the same C variable as both
> input and output.

You have an incorrect understanding. "__n" is the input operand in r0.
"__rem" is the output operand in r0/r1.

No single C variable is used as both an input and an output.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
