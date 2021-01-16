Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D38D2F8F9F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 23:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbhAPWKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 17:10:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbhAPWKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 17:10:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2972D22C7D;
        Sat, 16 Jan 2021 22:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610834999;
        bh=u79Br5glQK1ccWD/xx79tThGH4hD34t28fh9rxyEb8M=;
        h=From:To:Subject:Date:From;
        b=f69Njp1NlXa9j/fuhP9196gVY0/nbJruTQA+JAUwO0CDob/agqcdm//o9mm8vlAcE
         GUI3YvzZeLC+8IZa3UWe64Vpv+sjuUJP6wmixxVVmPZ6VlMd5Z2zh8UoAy1QzhYeQD
         kr4O5CQbpG2CQSNAg9M8imllEQgx9Vb2jodAytZJGv5i95j6JjyMDzTyVlwyh/1sup
         UukCFSrQPl5OKlkxbasrSVpxe9l0AHpxOO/wR5/HJCq5oJY9o9JmlH0RnYaR/5bqIy
         HXfnvWW2uHNVnmbk/1lW4zMNxIfry2OxbR+28NwtroSLl8gHwUxGM8em00chU6hmBB
         zjgmxr6sF0GEw==
From:   Timur Tabi <timur@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Date:   Sat, 16 Jan 2021 16:09:48 -0600
Message-Id: <20210116220950.47078-1-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch updates print_hex_dump() and related functions to
allow callers to print hex dumps with unhashed addresses.  It
adds a new prefix type, so existing code is unchanged.

Second patch changes a page poising function to use the new
address type.  This is just an example of a change.  If it's
wrong, it doesn't need to be applied.

IMHO, hashed addresses make very little sense for hex dumps,
which print addresses in 16- or 32-byte increments.  Typical
use-case is to correlate an addresses in between one of these
increments with some other address, but that can't be done
if the addresses are hashed.  I expect most developers to
want to replace their usage of DUMP_PREFIX_ADDRESS with
DUMP_PREFIX_UNHASHED, now that they have the opportunity.

Timur Tabi (2):
  [v2] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for unhashed
    addresses
  mm/page_poison: use unhashed address in hexdump for check_poison_mem()

 fs/seq_file.c          | 3 +++
 include/linux/printk.h | 8 +++++---
 lib/hexdump.c          | 9 +++++++--
 lib/seq_buf.c          | 9 +++++++--
 mm/page_poison.c       | 2 +-
 5 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.25.1

