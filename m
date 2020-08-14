Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D3A244F87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 23:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHNVZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 17:25:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgHNVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:25:28 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597440326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eHLqjOXRKN2Sci9A7g2BRjRAHDUcFgA4mPG8Xtywr1c=;
        b=Ft/gVlB3yplJWUWW0YiqUsc232KeOSiYvsV8voC0/h8d6zkj3u94//C9R4/CmR8wuKohkH
        TmgidsOA+ZAFrVYAsybWBNe+UWIXNxCt/IfvaA1+woaCKVhDVtwUoaDG5RG8nBEDC/6NFi
        /UcRtE/5sdaVFQS7rOvty/PRrTbKWJf7owBuKTmwQqhBXOjK3wWEK5pDNngSR95Lxp1ve4
        +4n+JaGYeeqznqeu6VwAAK4l2b7kuG6LX2vhFf5LitZiklTb3t0XY3S7zePK6qFrRxFejd
        8vpNLxhfwr65YarLwa9VtIXbn2ghqMcmS0gzm+jKHmprR6PUxtiyxeWNtXR5mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597440326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eHLqjOXRKN2Sci9A7g2BRjRAHDUcFgA4mPG8Xtywr1c=;
        b=jOgeDRKxs+5sBrmxRzMTV8Ya2ZyCexukUz/E++/aSFaRV+pcOCKBEPpWuklo5SFTAjLUAz
        ZLopeNEJfnzx07BQ==
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kieran Bingham <kbingham@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2][next] update gdb scripts for lockless printk ringbuffer
Date:   Fri, 14 Aug 2020 23:31:23 +0206
Message-Id: <20200814212525.6118-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When we brought in the new lockless printk ringbuffer, we overlooked the gdb
scripts. Here are a set of patches to implement gdb support for the new
ringbuffer.

John Ogness (2):
  scripts/gdb: add utils.read_ulong()
  scripts/gdb: update for lockless printk ringbuffer

 Documentation/admin-guide/kdump/gdbmacros.txt | 153 ++++++++++++------
 scripts/gdb/linux/dmesg.py                    | 139 +++++++++++-----
 scripts/gdb/linux/utils.py                    |   7 +
 3 files changed, 216 insertions(+), 83 deletions(-)

-- 
2.20.1

