Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AC928F3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbgJONwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:52:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:19132 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbgJONwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:52:12 -0400
IronPort-SDR: e0neHj+FGePa9ouo2JhGElysPM4mYy9e3kzbcirD4+e1xwnbEJTBvFs1vBTY/bnYi1RT/3Bjxg
 RtlMewlXXKug==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="251044040"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="251044040"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 06:52:12 -0700
IronPort-SDR: 6JVAFVKO2EtX3xfRD9ae15cufP6UhrtO+P+96TNK4FVyd8Qmvvt5cEb/XDheDxLBueClUedSzh
 x6rrPySWxnZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="346852164"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 15 Oct 2020 06:52:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 000DFFC; Thu, 15 Oct 2020 16:52:09 +0300 (EEST)
Date:   Thu, 15 Oct 2020 16:52:09 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Message-ID: <20201015135209.cojpqumlqntird2o@black.fi.intel.com>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201010191110.4060905-1-nivedita@alum.mit.edu>
 <20201010192624.GA4062867@rani.riverdale.lan>
 <20201012140830.vrc25x2gwo7yo4kn@black.fi.intel.com>
 <20201012153501.GA559681@rani.riverdale.lan>
 <20201013081117.GA28215@zn.tnic>
 <20201013082047.ifigo5hua2qdrv75@black.fi.intel.com>
 <20201013083358.GB28215@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013083358.GB28215@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:33:58AM +0200, Borislav Petkov wrote:
> On Tue, Oct 13, 2020 at 11:20:47AM +0300, Kirill A. Shutemov wrote:
> > With TCG or KVM? I use -machine "type=q35,accel=tcg".
> 
> Thx, that triggered it - it was KVM before.
> 
> Btw, are 5level boxes shipping already or not yet? Because I've not seen
> one yet. If you have access to the hw, I'd appreciate it if you could
> test Arvind's patch ontop of
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/seves
> 
> which does that early pagetable rework.

Yes, the patch helps to fix 5-level paging boot:

Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
