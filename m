Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995802B7EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgKRODo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgKRODn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:03:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534162223D;
        Wed, 18 Nov 2020 14:03:42 +0000 (UTC)
Date:   Wed, 18 Nov 2020 09:03:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Chen Yu <yu.chen.surf@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 1/3] tools/bootconfig: Fix to check the write failure
 correctly
Message-ID: <20201118090340.573ea5b1@gandalf.local.home>
In-Reply-To: <20201118223708.4b196db7bc1030f7604876ad@kernel.org>
References: <160560676899.144950.4148778261999789656.stgit@devnote2>
        <160560677952.144950.8229834525319742454.stgit@devnote2>
        <CADjb_WS+tc-oHX7hXVoWGz9pP_e66DcMp1npKbdpcVa9DhPKPA@mail.gmail.com>
        <20201118223708.4b196db7bc1030f7604876ad@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 22:37:08 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> BTW, I found another bug in bootconfig error handling.
> Steve, did you already pick this series? If not yet, I will update the seires to add that fix.

No, I was about to pull it in today. I'll wait for your new series.

Thanks!

-- Steve
