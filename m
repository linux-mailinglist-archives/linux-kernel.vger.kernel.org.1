Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9A271F65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgIUJ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgIUJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:56:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B66C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:56:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so7187317pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kr1L/To5vjPhk6t21fy78qdPmEDkH9giF/By3sCv/FY=;
        b=ZP7ruwGufY7FrG5vqSbib7GRZmu+jAJzcULuAZ7kfymXH23Q1bxTl75itfnMlcT4lw
         L6caCw1+f7u9/G9oQ7CoiqD0yZefgstvb2eqMkYr/ECpo6cVFux5FFvik3PDpKQk2gKv
         QHbsiBoYpD7kZ4fv5wcmwtvoKX/o4lA05RCUr6nKvnXKDxoCXni5t6veiXbLjfr2SFg/
         AfzaoOuwIO/0K06KfJMXMCie2Xh7SBK4D4WK1Mc0j9hkTYifcNiLO5rcbjXnH8O8SOrg
         kVRFi7ayFdFTG4B/M4u7Y7Xxt+Hz/OUufwqtTu5qtp1RWjBD5iLKS5Msw1dkstuGN98x
         UXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kr1L/To5vjPhk6t21fy78qdPmEDkH9giF/By3sCv/FY=;
        b=qS9XCZ2gOrcKBa/m37FKbycLvryzlmpk14yoz6FKKHrYqCoupudMJLnn76Eu+R+olW
         ZYb/TdYO06nmKHdLWPnR13Mm6t0C+VMCHZlplyeY0ogiHP8NOFI5b3YTo3APRXa4eJIF
         80lzfEIZdIHgexqRYNa9PlcpCHDTzHvWLanvnvPH85+O6zZXx5lPzm2sjpBXtpMpeem7
         xLBP4/jQfuAmisNfTOoUvWQAiZ2+l2enUP3lMNs2imE5wmW3AuCeD1D+ovENF4i5iNj+
         wHKI7MW5nJLGfEaafuDhJXW6z5kp1SAbJFDIEkuceCol/m72vqvNmXo3OZzcl3qtUR/n
         pE4A==
X-Gm-Message-State: AOAM531q4TgwK5KDt6a9raC9p70eubY1OTwSAgxj+w+SWIg7bTnD7zAv
        bRUDiSYHnamUCjDRrWSZbSgzorUN2o+2Mw==
X-Google-Smtp-Source: ABdhPJzh9LZIBEyALgHoNHzqYrYWkw80kkQVhM3uUo6EWCiToPAxo1D88KDQavkRAwCugwhPP9fLLQ==
X-Received: by 2002:a17:90a:e64e:: with SMTP id ep14mr25225403pjb.173.1600682189681;
        Mon, 21 Sep 2020 02:56:29 -0700 (PDT)
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp. [210.141.244.193])
        by smtp.gmail.com with ESMTPSA id e13sm10007335pjy.38.2020.09.21.02.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 02:56:28 -0700 (PDT)
Date:   Mon, 21 Sep 2020 18:56:24 +0900
From:   Masami Hiramatsu <masami.hiramatsu@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: bootconfig: Fix parser bugs (Re: [PATCH 0/4] bootconfig: Fix a
 parser bug)
Message-Id: <20200921185624.9eafc08c6f8affd3b9fb47fb@gmail.com>
In-Reply-To: <160068147328.1088739.7282405187565509762.stgit@devnote2>
References: <160068147328.1088739.7282405187565509762.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, the title is wrong, there are 2 bugs.

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
Masami Hiramatsu
