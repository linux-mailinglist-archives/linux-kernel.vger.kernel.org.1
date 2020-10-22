Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B0B295D92
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897442AbgJVLmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:42:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:44106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503029AbgJVLmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:42:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603366961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U/TEQOdMYbYjtth95CshJ8jvbzRyoAZQ22G8MKIsiHg=;
        b=M1aFCR1l6/A0bHaqSJkzL6QCK2YC0Vnv08L9aexs4yihtSB58RuDQTvv13vnXB6fT8bHfP
        YttZqf4dl1uwCPyC4M85q80Z1hh96WSAT2HnpoFN403xX4sF5hj3jmenvkga6Li2uDfSlb
        ZDMvt4bciwr70drA9o5KKbMJwMDgGaE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A286CABBE;
        Thu, 22 Oct 2020 11:42:41 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [RFC 0/2] printk: Official way to mute consoles
Date:   Thu, 22 Oct 2020 13:42:26 +0200
Message-Id: <20201022114228.9098-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The long discussion about handling empty console= came up with several
problems. This patchset tries to solve the two original problems
with empty console="" parameter:

  + Prevent the potential crash by registering console for /dev/console.
  + Prevent the performance regression by muting the consoles.

IMHO, the patchset makes sense on its own. It fixes a regression. It seems
that people want this functionality [1][2][3].

Note that there are still some problems that might be solved later:

  + Invalid console=bla name might still prevent registering any console.

  + The kernel should not crash even when /dev/console does not point
    to any real console. 

  + Should we add some fallback for stdin, stdout, and stderr when /dev/console
    can't be opened? For example, /dev/null?
    
  + How user space handle missing none-console associated with /dev/console?

[1] https://www.programmersought.com/article/19374022450/
[2] https://developer.toradex.com/knowledge-base/how-to-disable-enable-debug-messages-in-linux
[3] https://unix.stackexchange.com/questions/117926/try-to-disable-console-output-console-null-doesnt-work


Petr Mladek (2):
  printk: Add kernel parameter: mute_console
  printk: Restore and document obsolete ways to disable console output

 .../admin-guide/kernel-parameters.txt         | 11 +++++++
 kernel/printk/printk.c                        | 30 +++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.26.2

