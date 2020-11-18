Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9A2B7E61
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgKRNhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgKRNhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:37:14 -0500
Received: from devnote2 (unknown [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6480C221FC;
        Wed, 18 Nov 2020 13:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605706633;
        bh=cV8xboE+vwduqcWKaW5/o9EZjaAnw20e+Iftri0evSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JsjIixJ2shQWmNKole/jMmGY4+SN8DDUZjk1byE2Tbflq3yOltSzHi0Yo94laStw3
         LzsW1GL80qOuyNFm3ODZeiMzBOs5tjFy9lTaNUNTVX7OKSgAzNFpgbBZeX0Pr1vWc2
         t43ojnPKdlWm3Wu9vYV/YOe6F/ccBu0wg6Km/+E0=
Date:   Wed, 18 Nov 2020 22:37:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 1/3] tools/bootconfig: Fix to check the write failure
 correctly
Message-Id: <20201118223708.4b196db7bc1030f7604876ad@kernel.org>
In-Reply-To: <CADjb_WS+tc-oHX7hXVoWGz9pP_e66DcMp1npKbdpcVa9DhPKPA@mail.gmail.com>
References: <160560676899.144950.4148778261999789656.stgit@devnote2>
        <160560677952.144950.8229834525319742454.stgit@devnote2>
        <CADjb_WS+tc-oHX7hXVoWGz9pP_e66DcMp1npKbdpcVa9DhPKPA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 20:10:10 +0800
Chen Yu <yu.chen.surf@gmail.com> wrote:

> On Tue, Nov 17, 2020 at 5:53 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Fix to check the write(2) failure including partial write
> > correctly and try to rollback the partial write, because
> > if there is no BOOTCONFIG_MAGIC string, we can not remove it.
> >
> > Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> For [1/3] and [2/3]
> Tested-by: Chen Yu <yu.chen.surf@gmail.com>

Thank you Chen,

BTW, I found another bug in bootconfig error handling.
Steve, did you already pick this series? If not yet, I will update the seires to add that fix.

Thank you,

> 
> -- 
> Thanks,
> Chenyu


-- 
Masami Hiramatsu <mhiramat@kernel.org>
