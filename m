Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4876828667A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgJGSFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727085AbgJGSFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602093911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=x/Tqa0d9nodar351Zfey/2sT9+zcJbqgkTtkMif06fY=;
        b=U8T7JcyS12Gu36NsdDkalVgRkjhirEskev6wOX5sDdRdhpZwXsquIkyAcw7fACaDcxblMp
        JUOLNK5SjVaSDaWQ6vbXR/zW0xv7zfC+hbNT7KlUY88/g68stPHIAIVetI2XwDYUDM6zO7
        pQ/YcGRSejJxRB1DzYPn00ULueHb9ak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-8wpLJ0giOneXwXnlY2T7eg-1; Wed, 07 Oct 2020 14:05:07 -0400
X-MC-Unique: 8wpLJ0giOneXwXnlY2T7eg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5B17801AFA;
        Wed,  7 Oct 2020 18:05:02 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44FC65D9F1;
        Wed,  7 Oct 2020 18:04:57 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 657D2416948A; Wed,  7 Oct 2020 15:04:33 -0300 (-03)
Message-ID: <20201007180151.623061463@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 07 Oct 2020 15:01:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: [patch 0/2] nohz_full: only wakeup target CPUs when notifying new tick dependency (v2)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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



