Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE71E34D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 03:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgE0BkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 21:40:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29857 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725801AbgE0BkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590543601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=s8b1sFICMI5A7PdJVz4IhbVxMortS5XfFgwiWiuDWQg=;
        b=GMzjp5jxHhkv2UWtvy1oETbiGrDV+W8hIaZTW+Et2azasGPjwIH7oX5uxj4g5urYp0usHZ
        Ti6EfGpFDwVS1/xvAfvlxs23yjCyhgvu/7sHwd+0lRC+HjEqyN7Fq3xAYN/xBcNvl4w+zc
        LrAKHhS8db21lgdxZiF2LAMVy0xmKhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-2G8aw3L8M0qtZ8UEq1XpvA-1; Tue, 26 May 2020 21:39:58 -0400
X-MC-Unique: 2G8aw3L8M0qtZ8UEq1XpvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44C1110524FF;
        Wed, 27 May 2020 01:39:57 +0000 (UTC)
Received: from localhost (ovpn-113-43.phx2.redhat.com [10.3.113.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81B8C6ED98;
        Wed, 27 May 2020 01:39:56 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.224-rt144
Date:   Sun, 24 May 2020 02:45:05 -0000
Message-ID: <159028830562.475413.6970946289050349925@theseus.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.224-rt144 stable release.
Note that since 4.9-rt is in maintenance mode, this is just the
merge/rebase to the latest upstream stable releases with no changes
to the RT patchset.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: e0d43c3f28cd182c191c76fcfe5578784d4566c6

Or to build 4.9.224-rt144 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.224.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.224-rt144.patch.xz


You can also build from 4.9.220-rt143 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.220-rt143-rt144.patch.xz

Enjoy!
Clark

