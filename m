Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3285420594F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbgFWRjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 13:39:35 -0400
Received: from trent.utfs.org ([94.185.90.103]:44768 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbgFWRjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:39:32 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id A730F5FA38;
        Tue, 23 Jun 2020 19:39:26 +0200 (CEST)
Date:   Tue, 23 Jun 2020 10:39:26 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Kook <keescook@chromium.org>
cc:     linux-kernel@vger.kernel.org
Subject: process '/usr/bin/rsync' started with executable stack
Message-ID: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
User-Agent: Alpine 2.22.1 (DEB 446 2020-06-13)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

exactly this[0] happened today, on a 5.6.5 kernel:

  process '/usr/bin/rsync' started with executable stack

But I can't reproduce this message, and rsync (v3.2.0, not exactly 
abandonware) runs several times a day, so to repeat Andrew's questions[0] 
from last year:

  > What are poor users supposed to do if this message comes out? 
  > Hopefully google the message and end up at this thread.  What do you
  > want to tell them?

Also, the PID is missing from that message. I had some long running rsync 
processes running earlier, maybe the RWE status would have been visible in 
/proc/$PID/map, or somewhere else maybe?

Please advise? :-)

Thanks,
Christian.

[0] https://lore.kernel.org/patchwork/patch/1164047/#1362722


$ checksec --format=json --extended --file=`which rsync` | jq
{
  "/usr/bin/rsync": {
    "relro": "full",
    "canary": "yes",
    "nx": "no",
    "pie": "yes",
    "clangcfi": "no",
    "safestack": "no",
    "rpath": "no",
    "runpath": "no",
    "symbols": "no",
    "fortify_source": "yes",
    "fortified": "10",
    "fortify-able": "19"
  }
}

-- 
BOFH excuse #244:

Your cat tried to eat the mouse.
