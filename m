Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA328BA66
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgJLOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:08:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:56827 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731799AbgJLOIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:08:34 -0400
IronPort-SDR: YkfdJNv7f51CxYKqkUq4TDfpBFt7HnIZdcW6RBy9hOIjWS1Y2vyW0r40vr0pGpZV+rbK7pgqgO
 3SEju5/lnwyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="250439094"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="250439094"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 07:08:33 -0700
IronPort-SDR: wbAGRGWAXQa1ibfUea/jP7QJf6mUAd5tHGdH8L/hm79dKaKdKhvacleFkl0isuM7S5/3jrGBr8
 cTM3t7JAxeEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="356628626"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 12 Oct 2020 07:08:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0A663150; Mon, 12 Oct 2020 17:08:30 +0300 (EEST)
Date:   Mon, 12 Oct 2020 17:08:30 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Message-ID: <20201012140830.vrc25x2gwo7yo4kn@black.fi.intel.com>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201010191110.4060905-1-nivedita@alum.mit.edu>
 <20201010192624.GA4062867@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010192624.GA4062867@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 03:26:24PM -0400, Arvind Sankar wrote:
> On Sat, Oct 10, 2020 at 03:11:10PM -0400, Arvind Sankar wrote:
> > Commit
> >   ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
> > started using a new set of pagetables even without KASLR.
> > 
> > After that commit, initialize_identity_maps() is called before the
> > 5-level paging variables are setup in choose_random_location(), which
> > will not work if 5-level paging is actually enabled.
> 
> Note that I don't have hardware that supports 5-level paging, so this
> is not actually tested with 5-level, but based on code inspection, it
> shouldn't work.

qemu supports it. -cpu "qemu64,+la57"

-- 
 Kirill A. Shutemov
