Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7644928CA13
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391301AbgJMIUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:20:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:14202 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391312AbgJMIUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:20:50 -0400
IronPort-SDR: N5FNXoKfYObfq3cEcarj5E+edOXFX1Doc+2FRjYwUHcujg1nYvkIqnnusKuXiN+Pxc6KsMYv4j
 BgGyVIiujb+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165084216"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="165084216"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 01:20:49 -0700
IronPort-SDR: Uc7FHbM4LhKxY5bag/3q5YPrKsHmd5AKwXFP7hap6KiBv/7mxQrhbJ9xZe5TJsHSxEduiEeQIx
 jNAxIRThL64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="356070969"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2020 01:20:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A4174379; Tue, 13 Oct 2020 11:20:47 +0300 (EEST)
Date:   Tue, 13 Oct 2020 11:20:47 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Message-ID: <20201013082047.ifigo5hua2qdrv75@black.fi.intel.com>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201010191110.4060905-1-nivedita@alum.mit.edu>
 <20201010192624.GA4062867@rani.riverdale.lan>
 <20201012140830.vrc25x2gwo7yo4kn@black.fi.intel.com>
 <20201012153501.GA559681@rani.riverdale.lan>
 <20201013081117.GA28215@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013081117.GA28215@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:11:17AM +0200, Borislav Petkov wrote:
> On Mon, Oct 12, 2020 at 11:35:01AM -0400, Arvind Sankar wrote:
> > > qemu supports it. -cpu "qemu64,+la57"
> >
> > Thanks! On QEMU, it does crash without this patch.
> 
> Works fine here. I gave this to qemu:
> 
> -cpu qemu64,+la57,vendor=GenuineIntel
> 
> it said:
> 
> qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.07H:ECX.la57 [bit 16]
> 
> because host is AMD, probably, and I have
> 
> CONFIG_X86_5LEVEL=y
> 
> enabled for the guest kernel and tip:x86/seves booted fine.
> 
> What am I missing?

With TCG or KVM? I use -machine "type=q35,accel=tcg".

-- 
 Kirill A. Shutemov
