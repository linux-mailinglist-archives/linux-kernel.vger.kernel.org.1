Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255E6275049
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgIWFaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgIWFaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:30:19 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F320121974;
        Wed, 23 Sep 2020 05:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600839018;
        bh=VKNf7pcVHn3Vk/qGB21QR1LCfAkRtjsm0TzWPXBtDtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=blEgjPEAedKjmAk62c9zT7HCM9PoTgz2dpJ2gaIIb4vw66mcl/QvEg7CAF607B+IC
         sStIcZoPVG6WNvR2M6O8L3Q4qx/JNiNGZqU3sZtJa53gYNFgbhKIvWA0cXuSm1cmPi
         TZP9OJ99odeRqQJFXyvdCrQ7SJLuLgu1JFZc319w=
Date:   Wed, 23 Sep 2020 14:30:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 0/4] bootconfig: Fix a parser bug
Message-Id: <20200923143014.6c904389a4b20fe904144d3f@kernel.org>
In-Reply-To: <160068147328.1088739.7282405187565509762.stgit@devnote2>
References: <160068147328.1088739.7282405187565509762.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Thank you for merging previous 3 serieses!
Could you also pick this series as urgent-fix branch?

Thank you,

On Mon, 21 Sep 2020 18:44:33 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here are patches to fix 2 bugs in the parser. One issue happens
> when a key has a siblings and the key repeated with brace after
> sibling nodes. Another one is that the parser keeps tailing
> spaces when we put a comment on the line.
> 
> For example, the minimum example of the 1st issue is here;
> 
> foo
> bar
> foo { buz }
> 
> This should be parsed as
> 
> foo.buz
> bar
> 
> But the bootconfig parser parses it as foo.buz (no bar node)
> because foo->bar link is unlinked when the brace ("foo {") was
> found.
> 
> The second one is simpler, if we have
> 
> foo = val  # comment
> 
> The value's space after the word was not removed.
> 
> foo="val  "
> 
> But this also should be
> 
> foo="val"
> 
> If user needs tailing spaces, they can use quotes, e.g.
> 
> foo = "val  " # comment
> 
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (4):
>       lib/bootconfig: Fix a bug of breaking existing tree nodes
>       lib/bootconfig: Fix to remove tailing spaces after value
>       tools/bootconfig: Add testcases for repeated key with brace
>       tools/bootconfig: Add testcase for tailing space
> 
> 
>  tools/bootconfig/test-bootconfig.sh |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
