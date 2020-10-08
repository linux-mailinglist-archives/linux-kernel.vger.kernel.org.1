Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335D0286FE4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgJHHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:53:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48802 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJHHxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:53:10 -0400
Date:   Thu, 8 Oct 2020 09:53:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602143588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d6e5h3nXDiUZysi8faWMTH7D87uAub5X1Dllrwi045c=;
        b=zUlnDws/VOI9VX+ssFPwoMHjjYizWUvG2lzByiwenmTUSEUig4lVUnFZDpsdlPWTdtl8Wl
        4Fxszx55HG3320F9Yt1I3vWVO650eSXMJPeVXX7pcv0EAX5YijRWxcDFn9kmL8V/oRuSQR
        L6I2CG/V7J6ziLZAvCFaj9x0p9dOxejxUDnjs+uO2NgZqXI9FNm8Y+ST90OUBH5/7iTmfC
        fjrbU3gRxWK/hfJLZK2Ws/O5qC/d7fg4VYHJ0G0DTQHgoEdqy6OaGZ2OpEopPoX2aTK79A
        e5Je3U+PnMaZDzknAm5HD4+ZA9c1ID4GshRQVkkw9kWdc2xTt2xKYSaKM37s3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602143588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d6e5h3nXDiUZysi8faWMTH7D87uAub5X1Dllrwi045c=;
        b=DkZjMZVpTvyqyx6IHiaEV6/4dShXrm3iFPr+PEpNKlfSAm0sDJo9WVvifXkFbe0j9ISwhz
        +KYT3F2Y9EepiVCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     linux@armlinux.org.uk, ndesaulniers@google.com, caij2003@gmail.com,
        tglx@linutronix.de, maz@kernel.org, valentin.schneider@arm.com,
        vincent.whitchurch@axis.com, nhuck@google.com,
        akpm@linux-foundation.org, 0x7f454c46@gmail.com, will@kernel.org,
        a.sahrawat@samsung.com, v.narang@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] IRQ stack support for ARM
Message-ID: <20201008075306.6j7sv3d4prn6lzed@linutronix.de>
References: <CGME20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811@epcas5p2.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-08 12:45:30 [+0530], Maninder Singh wrote:
> Observed Stack Overflow on 8KB kernel stack on ARM specially 
> incase on network interrupts, which results in undeterministic behaviour. 
> So there is need for per cpu dedicated IRQ stack for ARM.

You could try to look where this stack overflow is coming from. If this
is limited to softirq processing/NAPI (since you mentioned network) you
could try implementing do_softirq_own_stack().

Sebastian
