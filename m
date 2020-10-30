Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8673D2A05C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgJ3MtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgJ3MtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:49:09 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A47320725;
        Fri, 30 Oct 2020 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604062148;
        bh=vkZMqLmB71QJitrMnWduqHHKEwQk/NQKdnUGaEOJwkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDP9YZV4xvyY9KnbEO7z2JLjm3qbDYESMbM4KlaKCmwtXINjk1Giodnx7M3k835oN
         /ORc6gQ/NwEQY+8+bjWzHe2yxuqCe3svJW9s+mVv6+CQiqQF+HkaRZAFdfRrXdUJaX
         nBt/yG77qPVH6OPPlb7VTxxjk/HJ6KyHocq5X9nI=
Date:   Fri, 30 Oct 2020 13:49:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Zou Wei <zou_wei@huawei.com>, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        USB <linux-usb@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] usb: Make sync_all_pins static
Message-ID: <20201030124905.GA308715@kroah.com>
References: <1604050097-91302-1-git-send-email-zou_wei@huawei.com>
 <CAHp75Vd46nO9nXAZZ5-XKZR3_wq-o37MdmLNm_KUTSvhsq+whQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd46nO9nXAZZ5-XKZR3_wq-o37MdmLNm_KUTSvhsq+whQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 01:18:33PM +0200, Andy Shevchenko wrote:
> On Fri, Oct 30, 2020 at 11:18 AM Zou Wei <zou_wei@huawei.com> wrote:
> 
> The title can be more precise.
> 
> > Fix the following sparse warning:
> >
> > drivers/usb/misc/brcmstb-usb-pinmap.c:219:6: warning: symbol 'sync_all_pins' was not declared. Should it be static?
> 
> Do we really need to know the path?

That's the warning message from the tool, why complain about it?

thanks,

greg k-h
