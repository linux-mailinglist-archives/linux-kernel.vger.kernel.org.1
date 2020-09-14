Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9728268966
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgINKjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgINKjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:39:12 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAC1C06174A;
        Mon, 14 Sep 2020 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=wlDIRDEfQWNob552Fwn5LzRLZbzE03QEuC1qTEAINRc=; b=cIcaToVtgQV2EaIpn+9phQNfAf
        Xs+f1cwrLc7phMf80weTR9ISZSPzE0C4tpCZGbLV9An2Wpy9k9xjPSTziIN0UUSUxmthKj+TEGh4p
        JbrqNbMH5QnBvF8CCeIrt60XCHtye5EmobBMb3Fa1C64YZmeqCiisQHwknK9JDku02Hgu9b4R+SFt
        gbez+4TVMC+cQ9azI90zA50Vx4zry07F8glQ9yhqeF99KoxAi6N8Kyb7iCxi91my2VTfFzLOgwqiN
        SRKyU8CB5XZQ+MLWdfiJN3XRDUaXASQYhMY4wEHq1lufzoESIDrombnpb7FKjZ21PrndsJ/3Csbga
        hkmubpXA==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1kHlsb-0001fB-Oz; Mon, 14 Sep 2020 12:38:37 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
        (envelope-from <aurelien@aurel32.net>)
        id 1kHlsa-00Cx5R-Sz; Mon, 14 Sep 2020 12:38:36 +0200
Date:   Mon, 14 Sep 2020 12:38:36 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
Message-ID: <20200914103836.GB2705@aurel32.net>
Mail-Followup-To: Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Nick Hu <nickhu@andestech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
 <1593266228-61125-2-git-send-email-guoren@kernel.org>
 <20200911204512.GA2705@aurel32.net>
 <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-12 10:39, Guo Ren wrote:
> It's come from mm/usercopy.c
> /* Is this address range in the kernel text area? */
> static inline void check_kernel_text_object(const unsigned long ptr,
>                                             unsigned long n, bool to_user)
> {
>         unsigned long textlow = (unsigned long)_stext;
>         unsigned long texthigh = (unsigned long)_etext;
>         unsigned long textlow_linear, texthigh_linear;
> 
>         if (overlaps(ptr, n, textlow, texthigh))
>                 usercopy_abort("kernel text", NULL, to_user, ptr - textlow, n);
> 
> The __init_text/data areas will be freed after bootup, so I think it should be:
> -        unsigned long textlow = (unsigned long)_stext;
> +        unsigned long textlow = (unsigned long)_text;
> 
> That means _stext should include init_text/data and _text is only for freeable.

I have no idea if it is the right thing to do or not, but I can confirm
this fixes the issue.

How should we proceed to get that fixed in time for 5.9? For the older
branches where it has been backported (so far 5.7 and 5.8), should we
just get that commit reverted instead?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
