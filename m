Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C320E050
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389595AbgF2UpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731584AbgF2TN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:59 -0400
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Jun 2020 02:16:06 PDT
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78959C008778
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 02:16:06 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 0E59610EE6F;
        Mon, 29 Jun 2020 11:08:15 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Subject: [REGRESSION] 5.8-rc3: seccomp crash with Chromium, QtWebEngine and related browsers: seccomp-bpf failure in syscall 0072
Date:   Mon, 29 Jun 2020 11:08:10 +0200
Message-ID: <2293324.KF7j4Pszzj@merkaba>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andy, Kees, Will, dear kernel community,

With 5.8-rc3 there is a seccomp related crash which prevents Chromium and
QtWebEngine from starting:

Bug 208369 - seccomp crash with Chromium, QtWebEngine and related browsers: seccomp-bpf failure in syscall 0072

https://bugzilla.kernel.org/show_bug.cgi?id=208369

Reverting to 5.8-rc2 fixes the issue.

Best,
-- 
Martin


