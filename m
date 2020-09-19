Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBB9270AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 07:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgISFHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 01:07:42 -0400
Received: from verein.lst.de ([213.95.11.211]:34840 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgISFHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 01:07:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9EBB68BEB; Sat, 19 Sep 2020 07:07:39 +0200 (CEST)
Date:   Sat, 19 Sep 2020 07:07:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, kernel test robot <rong.a.chen@intel.com>
Subject: Re: [fs] 36e2c7421f:
 kernel-selftests.splice.short_splice_read.sh.fail
Message-ID: <20200919050739.GA7038@lst.de>
References: <20200917012542.GF28738@shao2-debian> <202009181443.C2179FB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009181443.C2179FB@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 02:49:19PM -0700, Kees Cook wrote:
> In response to my recent bug fix for splice vs sysfs binary handler[1],
> I added splice testing for other pseudo filesystems[2], for which the
> test output is seen above.
> 
> What is the final verdict on the "should splice have a fallback mode?"
> question[3]? Right now /proc and /sys reject splice attempts (which, as
> I mentioned in the thread, is fine by me, since it would have blocked
> the bug I had to fix from ever being exposed in the first place).

The verdict is: without a set_fs()-like mechanism that allows uaccess
routines to operate on kernel buffers, or even worse a
compat_alloc_user_space-like mechanism we can't have an entirely
generic fallback.

> Should I update the test to _expect_ that splice should fail?

I think so.  We can updated individual file operations to support splice
where actually used applications except it (even when they shouldn't),
but I'd rather not do it just for a test case.
