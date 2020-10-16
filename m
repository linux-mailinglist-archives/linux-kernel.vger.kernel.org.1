Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5CC29061A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407207AbgJPNP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407176AbgJPNP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:15:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F406C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:15:57 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d0d005de09972a775d667.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d00:5de0:9972:a775:d667])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AEAED1EC04D1;
        Fri, 16 Oct 2020 15:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602854155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TYPdxVlFdRW3EyXHSC36z3MQByrqASt7K9C7kSa2ZE=;
        b=QbRjdw0+/0pCwE/8MvwjOA1whLiIydNlckD/Ki/827WHX69Xfl/vhe37SEYDPCjYUsnPw8
        6N8eqiix2pnY5UBDCYCOrXeY2eKW1wg7ouhxXtOn93BkC0pEoBYXDUUFZ/FAU3p6cpRbFX
        dUQGE3lfSqZmCILT4xWscTdwzIeHCl0=
Date:   Fri, 16 Oct 2020 15:15:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] x86/head/64: Disable stack protection for
 head$(BITS).o
Message-ID: <20201016131545.GE8483@zn.tnic>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-6-nivedita@alum.mit.edu>
 <20201016111703.GD8483@zn.tnic>
 <20201016124301.GA1040839@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201016124301.GA1040839@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 08:43:01AM -0400, Arvind Sankar wrote:
> You need STACKPROTECTOR_STRONG -- I was testing with defconfig and the
> option is enabled by default.

And you need to write those things in the commit messages.

Please, for the future, always make sure that all required ingredients
for triggering a bug are documented in the commit message, before
sending a fix. Jörg and I were both scratching heads on how you're
reproducing this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
