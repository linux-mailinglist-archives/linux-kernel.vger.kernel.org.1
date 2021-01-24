Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0063F30192C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 03:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbhAXCHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 21:07:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbhAXCHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 21:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611453948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=A5UmVTKDoiYfNesNyr3QYPvSARjlxC2oxETHoO/83GM=;
        b=dl7P9nvHghRA8ypzX+pWHejKp9TjNOWjvHAYAADbbAYbHO9ubcyppSSjWGwVwMw3Ez/bpS
        781a3saXTYe5jizFW9/oENju4osI19hXoUdVXxIFc9g8wba+5N8DLwspND5hIr9jY1EpX5
        prua7ZMSPaAa4u/b+mBfnOgHKGTvmGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-fh6r8fQLMiW2jwocOhevgQ-1; Sat, 23 Jan 2021 21:05:44 -0500
X-MC-Unique: fh6r8fQLMiW2jwocOhevgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1567D801817;
        Sun, 24 Jan 2021 02:05:43 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CF905C260;
        Sun, 24 Jan 2021 02:05:42 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 479003C00CE; Sat, 23 Jan 2021 23:05:40 -0300 (-03)
Date:   Sat, 23 Jan 2021 23:05:40 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.9.253-rt168
Message-ID: <20210124020540.GA83189@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.253-rt168 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 39c70c2a2244ca70ab61d2442b3c4136ed40d8ee

Or to build 4.9.253-rt168 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.253.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.253-rt168.patch.xz

Enjoy!
Luis

