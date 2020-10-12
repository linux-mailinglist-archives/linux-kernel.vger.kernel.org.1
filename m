Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2296928BFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391359AbgJLSWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387669AbgJLSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602526863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TGKXah/Cz5smHPfpgTJAC3mAN6Yqghu5QabHEuhJVPM=;
        b=ORIQvBSzFSW3gE0K1PMMvyQcjkf05JZeQoT7g18VEoCgtUZv9IV810lqZ6L0Nfuo/egFII
        qFdoblbeoCUkynkllVD9C5Si3NHEDsFHC/q3sDUW5PJcnB0vKlmeOFrnh0x92Z2S54J269
        kedXU7RxyJuSRo802yrrUKoT9DNR6Pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-UG2oN96KMK-Iy6BmCjondg-1; Mon, 12 Oct 2020 14:20:56 -0400
X-MC-Unique: UG2oN96KMK-Iy6BmCjondg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9538D879517;
        Mon, 12 Oct 2020 18:20:55 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5633055760;
        Mon, 12 Oct 2020 18:20:55 +0000 (UTC)
Date:   Mon, 12 Oct 2020 13:20:53 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.10
Message-ID: <20201012182053.GA16029@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.10

This set continues the ongoing rework of the low level
communication layer in the dlm.  The focus here is on
improvements to connection handling, and reworking the
receiving of messages.

Thanks,
Dave

Alexander Aring (13):
      fs: dlm: synchronize dlm before shutdown
      fs: dlm: make connection hash lockless
      fs: dlm: fix dlm_local_addr memory leak
      fs: dlm: fix configfs memory leak
      fs: dlm: move free writequeue into con free
      fs: dlm: handle possible othercon writequeues
      fs: dlm: use free_con to free connection
      fs: dlm: remove lock dependency warning
      fs: dlm: fix mark per nodeid setting
      fs: dlm: handle range check as callback
      fs: dlm: disallow buffer size below default
      fs: dlm: rework receive handling
      fs: dlm: fix race in nodeid2con

 fs/dlm/Kconfig    |   1 +
 fs/dlm/config.c   |  66 ++++++-----
 fs/dlm/config.h   |   4 +-
 fs/dlm/lowcomms.c | 329 ++++++++++++++++++++++++++----------------------------
 fs/dlm/midcomms.c | 136 +++++++++-------------
 fs/dlm/midcomms.h |   3 +-
 6 files changed, 260 insertions(+), 279 deletions(-)

