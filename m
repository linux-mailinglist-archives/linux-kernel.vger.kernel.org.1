Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A91D2ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 10:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgENI6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgENI6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:58:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D68C061A0C;
        Thu, 14 May 2020 01:58:21 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jZ9gn-0008HP-U3; Thu, 14 May 2020 10:58:01 +0200
Date:   Thu, 14 May 2020 10:58:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
Message-ID: <20200514085801.uolf4amd3bd2aw7m@linutronix.de>
References: <20200513204848.1208864-1-christian.brauner@ubuntu.com>
 <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
 <79e58d9b-5a39-390c-2f0c-0d87b63442b4@physik.fu-berlin.de>
 <20200514074606.vkc35syhdep23rzh@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514074606.vkc35syhdep23rzh@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-14 09:46:06 [+0200], Christian Brauner wrote:
> > As for getting a working cross-compiler for ia64 in Debian, this has
> > been on my TODO list for a while now. Building a cross-compiler for
> > ia64 is a bit more tricky due to it's dependency on the external
> > libunwind.
> 
> I hit that roadblock as well but yeah, a cross-compiler would be
> helpful.

There is
   https://mirrors.edge.kernel.org/pub/tools/crosstool/

and I used the ia64 compiler from there while compile testing patches
for ia64.

> Christian

Sebastian
