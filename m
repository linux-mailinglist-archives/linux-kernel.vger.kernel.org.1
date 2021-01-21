Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808432FEC67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbhAUN41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbhAUNqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:46:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04DBC061799;
        Thu, 21 Jan 2021 05:45:11 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:45:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611236710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=a8kgjGERZ38JPLnaj3ASvByW6hjRmOwa9piML4ZoDnU=;
        b=3nI32Xwb5is82sli24LA1343h30R/UpIqOrjEvSUx3dE4tqNdmL7hHgMUCU44BKbJUVv3M
        wFtrsuXUxRUgxh0dyQaIKbKuobIY9R50Y8qlrO0cl+nL0yLqfr4akWKCvTKPQ86ncC6u0F
        1vJ9hYs4iClvGumUZ1JDkxVC6q694i9eoz5/oFVtQDmNYyTyGEOnuoelXN8ANHjZq82jIC
        7IWWKBdcOVpRERcrKQB96YDo9XIJod3rn2rWSVzLNFb1ts5HGQNg5MFRIr30u9tHIbt9fy
        HlecdcVtXoxxMzYElDfvcwGkwEXXjmsum+xKkaPaZo1+H3dYoi9NesQRY6TZLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611236710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=a8kgjGERZ38JPLnaj3ASvByW6hjRmOwa9piML4ZoDnU=;
        b=J+JVE+jNG9lMGaB/fMBF3JOLHEoOEZkYa+MxI7ZMBff4jCpmkoky19luSBFzZAtGsSeG73
        LIugs93ao1KX1ECA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.11-rc4-rt1
Message-ID: <20210121134509.bagsesi4vdtwmdky@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.11-rc4-rt1 patch set. 

Changes since v5.10.8-rt24:

  - Updated to v5.11-rc4

Known issues
     - kdb/kgdb can easily deadlock.
     - kmsg dumpers expecting not to be called in parallel can clobber
       their temp buffer.
     - netconsole triggers WARN.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.11-rc4-rt1

The RT patch against v5.11-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/older/patch-5.11-rc4-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/older/patches-5.11-rc4-rt1.tar.xz

Sebastian
