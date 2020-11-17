Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0B2B5B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKQJN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:13:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgKQJN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:13:26 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48CCD2463C;
        Tue, 17 Nov 2020 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605604405;
        bh=8AlKOG8fEQ4JTs0DRlID+uq0lo8YRoUx86hrBNnjL0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1EsK4i6I3XFfeTalM/IxwJNdjue+sAR/PsckqwShboRIPefMLKVBXVMhT/msEbyQ
         k7Q37R9F7vQ9Xas0zyiqRWp5GnUj/Yvb0bBWcdAgf/5LQevOfS0+x2RGEJE/CY4aMr
         a3T/Wovl5HpvmPj8D9qN5keuvqHfS6HeTDtUuFp8=
Date:   Tue, 17 Nov 2020 10:14:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     jiaxun.yang@flygoat.com, chenhc@lemote.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, lfy@google.com
Subject: Re: [PATCH] Update MAINTAINERS for goldfish-rtc
Message-ID: <X7OUZmlRAuwWWHEn@kroah.com>
References: <20201117003135.1749391-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117003135.1749391-1-rkir@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 04:31:35PM -0800, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> We (Android Studio Emulator, aka goldfish) do not
> support MIPS anymore but goldfish-rtc is still used
> by MIPS/RISCV QEMU.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4a34b25ecc1f..7f9216407ace 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1168,7 +1168,9 @@ F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.tx
>  F:	drivers/irqchip/irq-goldfish-pic.c
>  
>  ANDROID GOLDFISH RTC DRIVER
> -M:	Miodrag Dinic <miodrag.dinic@mips.com>
> +M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
> +M:	Huacai Chen <chenhc@lemote.com>
> +L:	qemu-riscv@nongnu.org

It would be nice to get an ack from the people you are removing and
adding to this entry :(

