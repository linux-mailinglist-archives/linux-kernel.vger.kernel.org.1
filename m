Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C871CBB60
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 01:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEHXrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 19:47:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:21510 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgEHXrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 19:47:05 -0400
IronPort-SDR: qQAqKWwTDYPRUoHQD8UvVll2IubdOOpf2jXRhXwl5mbcivkMqCEyDrDy5VszM79VR9qwdEi4Rn
 Rc81C4UzM+sA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 16:47:04 -0700
IronPort-SDR: IgmrIChEafSOPxXY/UYw1Y2kWVyxeCtNJby66alTB8gI1u7A6peCARaxk9T6+QycGiiMk5J9/a
 peFREwyRD8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,369,1583222400"; 
   d="scan'208";a="279186642"
Received: from jbrandeb-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.217.221])
  by orsmga002.jf.intel.com with SMTP; 08 May 2020 16:47:03 -0700
Date:   Fri, 8 May 2020 16:47:03 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Ilie Halip" <ilie.halip@gmail.com>, <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v5] x86: bitops: fix build regression
Message-ID: <20200508164703.0000481d@intel.com>
In-Reply-To: <20200508202835.GA550540@ubuntu-s3-xlarge-x86>
References: <20200508182835.228107-1-ndesaulniers@google.com>
        <20200508183230.229464-1-ndesaulniers@google.com>
        <20200508202835.GA550540@ubuntu-s3-xlarge-x86>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 13:28:35 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> On Fri, May 08, 2020 at 11:32:29AM -0700, Nick Desaulniers wrote:
> > Use the `%b` "x86 Operand Modifier" to instead force register allocation
> > to select a lower-8-bit GPR operand.

This looks OK to me, I appreciate the work done to find the right
fix and clean up the code while not breaking sparse! I had a look at
the assembly from gcc 9.3.1 and it looks good. Thanks!

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
