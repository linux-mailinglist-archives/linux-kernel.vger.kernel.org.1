Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6CF302EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbhAYWF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733205AbhAYWDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 17:03:49 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7D3C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 14:03:09 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id j12so9185917pfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9uTkelnkgdH1/h1qSEC3+KB2ZZOMZMIqxRYnkoanZM4=;
        b=e48pg2fnQuL945QN5H8Vqv7bjX7l4CQIY5iNiZMX75XZLI2m+HxbhLqfsgNifpr/SZ
         qaR8nCtuU+N+h4snOkvPLNyDR8PxaMl8kXfvWPiXP/auSxLP+ru06vivV0yQ5r/mJqDh
         Pq1GsRCAqqvXIL7IvnbcFpPZJMU3JssEpiHKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9uTkelnkgdH1/h1qSEC3+KB2ZZOMZMIqxRYnkoanZM4=;
        b=f2TYCv01wn//6ShnkZvSA/Ar4d8jYAx7dvdVEHtrcU9N8k5SXCHvZufLEimcrdvJIE
         aqpMQzOhWWEd6y1PHU0x9jPVlvFxK/Ka1cklTp6co5TvRSzPYb1Q7LGnJz7KOxKsPdfv
         Eeet9VqmwxdIk7TezoYcApOd0GuyMuFEXrhbcaiZ+vZCl8THJXzd8BP+NwyMRskNlwF/
         dIOY9zrJ2VEOLLqTMUTHG3NtRTe445VCLSBz4gBaE2qYspOoqjKdVVD6dBie119xy+b4
         SS218c0TS8fSR5pNdZRUFDSA8WHvEt0miDUnLJW3o2/B1/SyhEzoWpOaemv8GWWleH47
         aG8g==
X-Gm-Message-State: AOAM5305mM1T2p9MvR60XdJ0re+CB90vsY3UgR2pPpcLZuqc/i7l98tM
        XONBoLJBmPs4I56uB8RhOC53lv0VeCCWKg==
X-Google-Smtp-Source: ABdhPJxELKHojiOS5LE+ZaEcSNUqh2aAeWOTc0igtRFBcAtlACI3x+7qSajwJcaRvf2ETtq/yQ/s3A==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr2597849pgm.295.1611612189024;
        Mon, 25 Jan 2021 14:03:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a131sm18614270pfd.171.2021.01.25.14.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 14:03:08 -0800 (PST)
Date:   Mon, 25 Jan 2021 14:03:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Message-ID: <202101251401.F18409FDD1@keescook>
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 02:42:10PM -0600, Josh Poimboeuf wrote:
> When a GCC version mismatch is detected, print a warning and disable the
> plugin.  The only exception is the RANDSTRUCT plugin which needs all
> code to see the same struct layouts.  In that case print an error.

I prefer this patch as-is: only randstruct needs a hard failure. The
others likely work (in fact, randstruct likely works too).

Masahiro, are you suggesting to be a hard-failure for all plugins?

-- 
Kees Cook
