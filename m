Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06C02B1379
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgKMAsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgKMAsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:48:11 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D58820B80;
        Fri, 13 Nov 2020 00:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605228490;
        bh=7OZk6DcwLgT8IsYjQ0csYsUk454k7bsiiq3YHgWHlwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q5ENrItELWyCOqNsZzAcCIo1zUsTIjzSIGNgk7uVex9CzIBS+mEMMQLJsmxxFEek8
         fI8manXRqSdQieiys9AfoOeMTp441k1/VdsWU6WhtfSSE1kUYHlq3P5j4VBzrSo3nF
         s+/UXrIU+QtrxLoMYXskkyvwFEUjYxVQvvr8EteY=
Date:   Thu, 12 Nov 2020 16:48:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <ansuelsmth@gmail.com>
Cc:     "'Al Viro'" <viro@zeniv.linux.org.uk>,
        "'Will Deacon'" <will@kernel.org>,
        "'Catalin Marinas'" <catalin.marinas@arm.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Pavel Tatashin'" <pasha.tatashin@soleen.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: R: [PATCH] arm64: fix missing include in asm uaccess.h
Message-Id: <20201112164809.81f1c14f5d1f1d998f279287@linux-foundation.org>
In-Reply-To: <000001d6b7c8$bfed23e0$3fc76ba0$@gmail.com>
References: <20201111004440.8783-1-ansuelsmth@gmail.com>
        <20201111005826.GY3576660@ZenIV.linux.org.uk>
        <20201111010910.GZ3576660@ZenIV.linux.org.uk>
        <000001d6b7c8$bfed23e0$3fc76ba0$@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 02:19:48 +0100 <ansuelsmth@gmail.com> wrote:

> > <asm/uaccess.h> ok ? */
> > include/linux/uaccess.h:11:#include <asm/uaccess.h>
> > 
> > The last one is the only such include that should exist; drivers/s390 one
> > is obviously a false positive.  And IMO the right thing to do is to
> > replace the remaining arch/* instances with includes of linux/uaccess.h.
> > 
> > All of those are asking for trouble; any change moving e.g. a common
> > variant of some primitive into linux/uaccess.h might end up breaking
> > those.
> 
> Thx for the quick response. I found this error while working on a qcom
> driver that
> use this include. I can confirm that by using linux/uaccess.h the problem is
> solved.

Thanks, all.

I queued up the below for sending to Linus Real Soon Now.  Please note
that I added the cc:stable, because the offending df325e05a6 ("arm64:
Validate tagged addresses in access_ok() called from kernel threads")
had a cc:stable.


From: Ansuel Smith <ansuelsmth@gmail.com>
Subject: arm64: fix missing include in asm/uaccess.h

Fix a compilation error as PF_KTHREAD is defined in linux/sched.h and this
is missing.

[viro@zeniv.linux.org.uk: use linux/uaccess.h]
  Link: https://lkml.kernel.org/r/20201111005826.GY3576660@ZenIV.linux.org.uk
Link: https://lkml.kernel.org/r/20201111004440.8783-1-ansuelsmth@gmail.com
Fixes: df325e05a682 ("arm64: Validate tagged addresses in access_ok() called from kernel threads")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm64/include/asm/uaccess.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/include/asm/uaccess.h~arm64-fix-missing-include-in-asm-uaccessh
+++ a/arch/arm64/include/asm/uaccess.h
@@ -7,6 +7,8 @@
 #ifndef __ASM_UACCESS_H
 #define __ASM_UACCESS_H
 
+#include <linux/uaccess.h>
+
 #include <asm/alternative.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/sysreg.h>
_

