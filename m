Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D832909AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410267AbgJPQ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410246AbgJPQ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:28:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E1C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:28:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d0d000a68ceadd6ffefc0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d00:a68:cead:d6ff:efc0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07B011EC0505;
        Fri, 16 Oct 2020 18:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602865689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hjWqlQ0EK6JQ2uFLQlqVAqPQkPmHrCRi+HGz7xb2tlc=;
        b=YBVNIm82ajhQirCJEJsTTNuL670VaY/ZjDwijWJKhl9gXSi45OFk1Ayq83uMGYfd+og3Iy
        RqvjlT8dWIeBc7wQnz9VCjO8mMSd1ISOooFED+KwP4xeV+uGCz+zxzYRHmG2eo1Ujt9ZsY
        w5aTUteLn0hJbw3P+mqj6aWi0tJOcBo=
Date:   Fri, 16 Oct 2020 18:27:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201016162759.GG8483@zn.tnic>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-5-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008191623.2881677-5-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:16:22PM -0400, Arvind Sankar wrote:
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/ident_map_64.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Ok, just pushed your two fixes here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=rc0%2b1-seves

Please rebase this one ontop and put the two cleanups last so that the
fixes can go into urgent while the two cleanups can follow later through
normal tip flow. And yes, pls do this in the future too: fixes should
be minimal so that they can be expedited first and normal cleanups and
features can be done later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
