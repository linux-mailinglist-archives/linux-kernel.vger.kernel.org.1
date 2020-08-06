Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B00223DD81
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgHFRLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:11:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:14881 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730251AbgHFRKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:22 -0400
IronPort-SDR: zmOkgAQFo0R5TmNM52kqE+5JWktUDdcpocInH71ELNsnC0h9P93I+/EEYFMlCQ69+pG3Y4x9os
 BoV4oOYb/hGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="140652630"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="140652630"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 04:19:58 -0700
IronPort-SDR: xIOUJrBJ1rKtlc+HSPNdHqgAQHnJi2SaKj0oFz+hOz8GE7v+TrhpQxf9EMNrxV2FBx44BNY0W4
 6QvIBpvzj7QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="367552340"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 06 Aug 2020 04:19:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1k3dw9-006qFH-Gl; Thu, 06 Aug 2020 14:19:53 +0300
Date:   Thu, 6 Aug 2020 14:19:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200806111953.GA1630647@smile.fi.intel.com>
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-5-nivedita@alum.mit.edu>
 <CAMj1kXHc4o91VkaChoyVzr4w-HOaashMPtkCKLaszMGCxhR_2A@mail.gmail.com>
 <20200526151623.GB2190602@rani.riverdale.lan>
 <20200526171340.pdbautbix5ygdvgp@google.com>
 <20200526191411.GA2380966@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526191411.GA2380966@rani.riverdale.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 03:14:11PM -0400, Arvind Sankar wrote:

Side question: are you going to submit a v3 of this?
Or i.o.w. what is the status of this series?

-- 
With Best Regards,
Andy Shevchenko


