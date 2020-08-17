Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9B2246883
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgHQOis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 10:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgHQOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:38:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7B8C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:38:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26be002467df2f56916710.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:2467:df2f:5691:6710])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 381461EC02C3;
        Mon, 17 Aug 2020 16:38:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597675125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=15hq07dH1anRg+ztwDYXnpbazDwOwphd7D+iH9Nk/H8=;
        b=nbmjiElnBFG/Zd6PQmMCVtSPMGciM2QPWRsnUjjAL9qwKNQzQxzSkIBqYNagdyI0x17he6
        QQGWSCXKG/ceOy/chqJekCW0rC/BdPtn5YbK9AcJqGB7y0dwCPt8xK/Li2jzE6GPCO58F2
        SoXsdQzFgLUndjaFfENuXTlbxXNGS0U=
Date:   Mon, 17 Aug 2020 16:39:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Gustavo A. R. Silva" <kernel.org@embeddedor>
Subject: Re: [PATCH] x86: Use fallthrough pseudo-keyword
Message-ID: <20200817143940.GJ549@zn.tnic>
References: <20200707200303.GA4680@embeddedor>
 <20200817130227.GI549@zn.tnic>
 <fafab4f8754a924a97e2115fbd95085dbf918a9b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fafab4f8754a924a97e2115fbd95085dbf918a9b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 07:23:05AM -0700, Joe Perches wrote:
> > What's the logic for those two to not get a fallthrough; marker?
>
> consecutive case labels do not need one.

Because?

Also, this along with the reason why needs to be documented here too:

https://www.kernel.org/doc/html/latest/process/deprecated.html#implicit-switch-case-fall-through

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
