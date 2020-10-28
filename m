Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7AE29D2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgJ1Ve2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:34:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgJ1Ve0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:26 -0400
Date:   Wed, 28 Oct 2020 21:58:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603918734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lusoa8B5cer17XZ319sVN4k42HYGUzqhQNBpT0oGHpE=;
        b=qTysChxcGvzs8JdVNKgyGZiBFtI+JVKBJUG37wy5FK0XXD12Xr7IMLxvhWg+K2xPYheZvP
        Rw7fv2RK/yIFquBf8lY01YITp+/KA5VdfwomIphq3iQVvqiI69eBLT/djvKo9IcNa9YV3F
        i73xf8Qylx6GyPzf8VsrZyZS+06AiNKrp/oGlOjVfq67xQhU/u36aQWZFm7w5PrXPdxhOs
        B4s3a076/3Sbzc6M6WSNErdR2Ds6AKGBkvMwbkOb0XqD0UDuawckCzmVjxUrdT7W8dWgYB
        4Q9BwIUIL4DBFvk3SFTzwkvsD5OoYiMiJheYgEizaKJPImskpbzeglQj7abSwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603918734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lusoa8B5cer17XZ319sVN4k42HYGUzqhQNBpT0oGHpE=;
        b=yBKz18IvF0rVYyAwz7Hq6CWirisdVTosqT3dofDOagatUE0wb+EH6jibO54KZ+uJKe0b97
        /yII9F4VWpZQPJAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10-rc1-rt1
Message-ID: <20201028205853.rw2j3dtuyvup6lai@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10-rc1-rt1 patch set. 

Changes since v5.9.1-rt20

  - Rebase to v5.10-rc1.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc1-rt1

The RT patch against v5.10-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc1-rt1.tar.xz

Sebastian
