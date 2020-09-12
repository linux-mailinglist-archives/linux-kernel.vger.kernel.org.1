Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D568C267877
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 09:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgILHIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 03:08:07 -0400
Received: from verein.lst.de ([213.95.11.211]:39054 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgILHIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 03:08:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC3BF68B02; Sat, 12 Sep 2020 09:08:02 +0200 (CEST)
Date:   Sat, 12 Sep 2020 09:08:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, hpa@zytor.com, bp@alien8.de,
        rric@kernel.org, peterz@infradead.org, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] x86: Simplify compat syscall userspace allocation
Message-ID: <20200912070802.GA19621@lst.de>
References: <20200912070553.330622-1-krisman@collabora.com> <20200912070553.330622-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912070553.330622-3-krisman@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 03:05:49AM -0400, Gabriel Krisman Bertazi wrote:
> When allocating user memory space for a compat system call, don't
> consider whether the originating code is IA32 or X32, just allocate from
> a safe region for both, beyond the redzone.  This should be safe for
> IA32, and has the benefit of avoiding TIF_IA32, which we want to drop.

This doesn't look wrong, by why bother (maybe Ccing me on the whole
seris as you always should instead of sending annoying out of context
single patches would have told..).

We will hopefully kill off compat_alloc_user_space in the next few
merge windows..
