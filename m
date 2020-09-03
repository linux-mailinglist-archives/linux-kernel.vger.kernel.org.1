Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC7725CBFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 23:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgICVSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 17:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgICVSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:18:03 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 816C0206CA;
        Thu,  3 Sep 2020 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599167883;
        bh=H+zisSn0FrInHXhGoTyvgsvnRNCUi468hEUisSJ0ngg=;
        h=Subject:From:To:Date:From;
        b=soemoY/r1RNQiVg/7DIajZG1+z+Iy97Jw9sRT2KzXXm0R6fpLxhAyncNFC3Nzxy66
         /prLiORA3GCXtVWLhP0hRLEQNpMAqZf55dECJaYU6v3aFE/0sTk63YvWCxBnMlqMXX
         DJpuMwsO3zNZkO8zAnXU5yGs06miFynCXPVmJp1E=
Message-ID: <e717ef103955ba2aea8ab58a0a53d12ef7b1a1c8.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.142-rt63
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
Date:   Thu, 03 Sep 2020 16:18:01 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.142-rt63 stable release.

This release is just an update to the new stable 4.19.142
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: ea94598e25b40fa394519bf9ece3f0032c6f3301

Or to build 4.19.142-rt63 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.142.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.142-rt63.patch.xz

Enjoy!

   Tom

