Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B8419E185
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 01:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDCXjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 19:39:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42962 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgDCXjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 19:39:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKVuG-009xUJ-1w; Fri, 03 Apr 2020 23:39:24 +0000
Date:   Sat, 4 Apr 2020 00:39:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: signal: move save_altstack_ex out of generic
 headers
Message-ID: <20200403233924.GM23230@ZenIV.linux.org.uk>
References: <20200324220830.110002-1-ndesaulniers@google.com>
 <20200403231611.81444-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403231611.81444-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 04:16:06PM -0700, Nick Desaulniers wrote:
> In some configurations (clang+KASAN), sas_ss_reset() may emit calls to
> memset().  This is a problem for SMAP protections on x86, which should
> try to minimize calls to any function not already on short whitelist, in
> order to prevent leaking AC flags or being used as a gadget.
> 
> Linus noted that unsafe_save_altstack() only has callsites in the
> arch-specific arch/x86/kernel/signal.c, and shouldn't be defined in arch
> independent headers.
> 
> Split the logic of unsafe_save_altstack() into two, and move the definitions
> to arch/x86/include/asm/sigframe.h.  This does less work with the SMAP
> guards down.

Just move that into signal_delivered() and that's it.  SMAP or no SMAP -
doing that until the sigframe is set and we are committed to entering
the handler is wrong.
