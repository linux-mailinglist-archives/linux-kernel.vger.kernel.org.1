Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB55271F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgIUJoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgIUJoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:44:37 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 593862076B;
        Mon, 21 Sep 2020 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600681477;
        bh=Z92PhSiSGLZvxyCQXE5kB9pXKwvYFj4JCiDf0s9v4f0=;
        h=From:To:Cc:Subject:Date:From;
        b=Y0ffBdYA09c21nEEWgNXUtH/mH6JYQF9TPbRtWeoJ3rfO9tj76qouMjMz+IW0EKOD
         oty3cr7I0QPu5wd4CJaJpc2m1/L3KWOHvepLctneu3lM3UeJwp6dTU8uS4nTcsV6nZ
         36KSy//Sw/E4+wTSyZSQP1vej7gCro18a7vmCVHg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/4] bootconfig: Fix a parser bug
Date:   Mon, 21 Sep 2020 18:44:33 +0900
Message-Id: <160068147328.1088739.7282405187565509762.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are patches to fix 2 bugs in the parser. One issue happens
when a key has a siblings and the key repeated with brace after
sibling nodes. Another one is that the parser keeps tailing
spaces when we put a comment on the line.

For example, the minimum example of the 1st issue is here;

foo
bar
foo { buz }

This should be parsed as

foo.buz
bar

But the bootconfig parser parses it as foo.buz (no bar node)
because foo->bar link is unlinked when the brace ("foo {") was
found.

The second one is simpler, if we have

foo = val  # comment

The value's space after the word was not removed.

foo="val  "

But this also should be

foo="val"

If user needs tailing spaces, they can use quotes, e.g.

foo = "val  " # comment


Thank you,

---

Masami Hiramatsu (4):
      lib/bootconfig: Fix a bug of breaking existing tree nodes
      lib/bootconfig: Fix to remove tailing spaces after value
      tools/bootconfig: Add testcases for repeated key with brace
      tools/bootconfig: Add testcase for tailing space


 tools/bootconfig/test-bootconfig.sh |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
