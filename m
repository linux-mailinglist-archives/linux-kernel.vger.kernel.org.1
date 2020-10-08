Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E342287C58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgJHTSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbgJHTSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602184699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=WAjg58k6zysC55xXuQSmmv3IfCLTn65IVmudRZhOFxQ=;
        b=g/om7oVF1qQTVXzMD1hGBhMqjI1btWC5NI0Ii7Vu+teLVxBQLzTMhBqq010lz6SM4acXCc
        GeQpGYGYl0ANAyLsZ5hod+e16DEZw1Fhv2ffD1RjnOSM34ZBWSnenFG1dHNdMiYziHRx84
        p7fHVbnTlJrumQO39tZJi9XkwW/69wc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-sdhn-Y5_OnK1Vmbeb-y1Xw-1; Thu, 08 Oct 2020 15:18:17 -0400
X-MC-Unique: sdhn-Y5_OnK1Vmbeb-y1Xw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C2E118BE16D;
        Thu,  8 Oct 2020 19:18:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B7A9614F5;
        Thu,  8 Oct 2020 19:18:09 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 673DF4168BA3; Thu,  8 Oct 2020 16:17:42 -0300 (-03)
Message-ID: <20201008191129.152030255@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 08 Oct 2020 16:11:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: [patch 0/2] nohz_full: only wakeup target CPUs when notifying new tick dependency (v3)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling per-CPU posix timers, an IPI to nohz_full CPUs might be
performed (to re-read the dependencies and possibly not re-enter
nohz_full on a given CPU).

A common case is for applications that run on nohz_full= CPUs
to not use POSIX timers (eg DPDK). This patch changes the notification
to only IPI the target CPUs where the task(s) whose tick dependencies
are being updated are executing.

This reduces interruptions to nohz_full= CPUs.

---

v3: replace superfluous rcu_read_lock with lockdep_assert (PeterZ)


