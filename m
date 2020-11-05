Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B72A859B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbgKESCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:02:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:34930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKESCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:02:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604599336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LIAGOTKA4K4YSRkraVO7gZRH7usn+BgPOBPH886B/Q8=;
        b=bHyTk61KVwHVM3eXdtsdePY05K1EtrYGoPZsBtvpnTLpZIMw+0ku+wPThSEH56wsMqugpw
        S7wAgmh7GPF+otRGJ0hnrHYcjOpvF2Li6W+5eeYlIuzBDAPn8a1vLKwm+kgc8hRuMrmkrw
        gQbB90+7LASHmNipPdhjms+za6QeUGo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04B11AB8F;
        Thu,  5 Nov 2020 18:02:16 +0000 (UTC)
Date:   Thu, 5 Nov 2020 19:02:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/3] Revert "kernel/reboot.c: convert simple_strtoul
 to kstrtoint"
Message-ID: <20201105180215.GG1602@alley>
References: <20201103214025.116799-1-mcroce@linux.microsoft.com>
 <20201103214025.116799-2-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103214025.116799-2-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-11-03 22:40:23, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> This reverts commit 616feab753972b9751308f3cd2a68fc57eae8edb.
> 
> kstrtoint() and simple_strtoul() have a subtle difference which makes
> them non interchangeable: if a non digit character is found amid the
> parsing, the former will return an error, while the latter will just
> stop parsing, e.g. simple_strtoul("123xyx") = 123.
> 
> The kernel cmdline reboot= argument allows to specify the CPU used
> for rebooting, with the syntax `s####` among the other flags,
> e.g. "reboot=warm,s31,force", so if this flag is not the last given,
> it's silently ignored as well as the subsequent ones.
> 
> Fixes: 616feab75397 ("kernel/reboot.c: convert simple_strtoul to kstrtoint")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
