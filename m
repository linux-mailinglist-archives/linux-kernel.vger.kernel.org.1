Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4AC281DFC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgJBWED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBWED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:04:03 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA89420719;
        Fri,  2 Oct 2020 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601676242;
        bh=yybcndHOjmfwLTmM0mu6h5cJAPUOEJCSW1Ob8kRd5Pc=;
        h=Subject:From:To:Date:From;
        b=A4l5ehT6vbvxEWmJ4sNkUQv9cHJu4XKqHpL6YX1GlpN3NwElu6P5xzjj8tlZaRELZ
         SW0umMCTZZAPRZRydfsq95mnZeR3KBUOMVD0z+N+lYSWOI7mD5i9NPA+lSedXwATMN
         ZFpjSj8lBUA3Y+c2tgGysk0Pa2YpVpuPZOh0TeRU=
Message-ID: <ee85ed63067c9b681e62735d0491e25819da5dd0.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.148-rt64
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 02 Oct 2020 17:04:00 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.148-rt64 stable release.

This release is just an update to the new stable 4.19.148
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 0f0eda46246e76215f9056d17df7d964a2047cb8

Or to build 4.19.148-rt64 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.148.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.148-rt64.patch.xz

Enjoy!

   Tom

