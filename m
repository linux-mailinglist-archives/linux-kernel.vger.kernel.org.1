Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68A42CC637
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgLBTIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLBTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:08:09 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01729C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:07:29 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t18so1667543plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CI9tZHSqVnZWg7RvQpMS4nqMXXIbLQ8Im7hlt6GJUiI=;
        b=E3P3K2PuL0LspLuFI2FjNETxSRdGUE4F1gu4RqXq8nl+CaW6y7wJ6D9rxKjHbDt6Sc
         d7fUnySi06CMlffhWQbR4QYybkRtQzVp/93HEURZexGt8CHlzLDuYhUHmv7TIKtwytUj
         lBatJbTznHe4/8k2Hz1YYRVTB6QqMHTxjX2jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CI9tZHSqVnZWg7RvQpMS4nqMXXIbLQ8Im7hlt6GJUiI=;
        b=bJT/uVG62xuosSxetDJANKAwFq7vgAjqBakXvV3TzXX0tOmqKeiVl9pbfj30RmfGeB
         CwGrJkqmkNvZmPElDDK3JwBaOU05PrdB4H9M7A1lfG1ZBVcOt/5rKTwgTwkjHR38KI+I
         0XVCVzcuGFYD5PSrH8WbmhJjYjxObloB2nt72FU2q7NW6QNADiqdSsA9vJjUAVFxY0uU
         L0s6/lEX7ex8c05++axypQ2+bAZpsQ0+ulMp/ejtFc2oJnCYCv9dHdVa/hSbBckfRr2G
         wQYry2wCpBkzMzKBa5DqCsp4AG9iR5MKVLvGc5H5I8eXlgu1IzyRobEWgSFlgJRWGyfp
         JFrg==
X-Gm-Message-State: AOAM530IB9MABlNhWkciEwnWOb9OevKkFGe2wf9zbqr85m8fs7asfx7W
        83N8lweSucv7BWvKpYbSteVrmQ==
X-Google-Smtp-Source: ABdhPJxRnidXbunIBUKjdgdVYvKvQLfbolT7fVvdUnvhBqIseLwtyxa0Lw7RIiEURkPqHmoR1U/2Pw==
X-Received: by 2002:a17:902:8ec7:b029:d8:e603:304c with SMTP id x7-20020a1709028ec7b02900d8e603304cmr3892158plo.85.1606936048527;
        Wed, 02 Dec 2020 11:07:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v24sm432906pgi.61.2020.12.02.11.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:07:27 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:07:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/sev-es: Fix not using prefixes.nbytes for loop
 over prefixes.bytes
Message-ID: <202012021104.0C38FB7FD@keescook>
References: <160689905099.3084105.7880450206184269465.stgit@devnote2>
 <160689906460.3084105.3134729514028168934.stgit@devnote2>
 <54417a56-241b-14f9-2540-11b23e40e2b2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54417a56-241b-14f9-2540-11b23e40e2b2@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 09:31:57AM -0600, Tom Lendacky wrote:
> On 12/2/20 2:51 AM, Masami Hiramatsu wrote:
> > Since the insn.prefixes.nbytes can be bigger than the size of
> > insn.prefixes.bytes[] when a same prefix is repeated, we have to
> > check whether the insn.prefixes.bytes[i] != 0 and i < 4 instead
> > of insn.prefixes.nbytes.
> > 
> > Fixes: 25189d08e516 ("x86/sev-es: Add support for handling IOIO exceptions")
> > Reported-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >   arch/x86/boot/compressed/sev-es.c |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
> > index 954cb2702e23..6a7a3027c9ac 100644
> > --- a/arch/x86/boot/compressed/sev-es.c
> > +++ b/arch/x86/boot/compressed/sev-es.c
> > @@ -36,7 +36,7 @@ static bool insn_has_rep_prefix(struct insn *insn)
> >   	insn_get_prefixes(insn);
> > -	for (i = 0; i < insn->prefixes.nbytes; i++) {
> > +	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {

You must test "i" before bytes[i] or you still do the out-of-bounds-read.

> 
> Wouldn't it be better to create a #define for the size rather than hard
> coding 4 in the various files? That would protect everything should the
> bytes array size ever change in the future.

Agreed, and perhaps instead of repeating the idiom in the for loop, add
a helper like:

#define insn_prefix_valid(prefixes, i) (i >=0 && i < 4 && prefixes->bytes[i])

to be used like:

	for (i = 0; insn_prefix_valid(&insn->prefixes, i); i++) {

> 
> Thanks,
> Tom
> 
> >   		insn_byte_t p = insn->prefixes.bytes[i];
> >   		if (p == 0xf2 || p == 0xf3)
> > 

-- 
Kees Cook
