Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE42826D7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgIQJlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:41:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54578 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgIQJlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:41:04 -0400
Received: from zn.tnic (p200300ec2f1053000730ae91ea344e59.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:730:ae91:ea34:4e59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29B441EC032C;
        Thu, 17 Sep 2020 11:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600335662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gSRn4R+wsZrRg7X+q05/zOo+dEqKEeyKAGD5yN2Wvyw=;
        b=IaeDatMSe+U4UkaBNx4hd+Tv+6elqn59PZgTfmavwQQ28/3FCxcHa685ADgPUvjpKT5oPn
        +hZUJBAnG/MUfZw5PQSuqVPVEVwP9eamUQ82b/PB5tyK1+Sl50R7DEfdTE0c8raLBodD73
        lR3q5YYMnm33Oi1/gnLhO0JWfWWIoqY=
Date:   Thu, 17 Sep 2020 11:40:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cmdline: Disable instrumentation of cmdline
 unconditionally
Message-ID: <20200917094055.GF31960@zn.tnic>
References: <20200906154637.1618112-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200906154637.1618112-1-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 11:46:37AM -0400, Arvind Sankar wrote:
> On 32-bit, cmdline_find_option_bool() is used before paging is enabled,
> from check_loader_disabled_bsp() in the early microcode loader.
> Instrumentation options that insert accesses to global data will likely
> crash or corrupt memory at this point.

What is the use case here, can you trigger an actual crash?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
