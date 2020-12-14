Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3462D9E52
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440524AbgLNR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:56:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502490AbgLNR4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607968473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=45PKN0u+6PU+HJHk6Jc+DgoEp0htkAnWfKxzeMiZZx0=;
        b=VFixxVEXh5bTldEiWHI5/lJe9H6/Nh9N05tKnPRrquJjXL+yHTWONIuhiAyMxRgkzZKH4v
        80256CGPyrleQp62wo8yg52aAXByHNSkjMvitvD2hQLRSJ8tuxtxkhzg4rBXG/BBcidjRN
        GvVxK2E4un5SimQaDC63GcDyvkZeNl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-ClbKa5GuN3eqkJU0NSZ_xQ-1; Mon, 14 Dec 2020 12:54:31 -0500
X-MC-Unique: ClbKa5GuN3eqkJU0NSZ_xQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEB54180A094;
        Mon, 14 Dec 2020 17:54:30 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C21A71C94;
        Mon, 14 Dec 2020 17:54:30 +0000 (UTC)
Date:   Mon, 14 Dec 2020 11:54:29 -0600
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.11
Message-ID: <20201214175429.GB9687@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.11

This set includes more low level communication layer cleanups.
The main change is the listening socket is no longer handled as
a special case of node connection sockets.  There is one small
fix for checking the number of local connections.
Thanks,
Dave

Alexander Aring (13):
      fs: dlm: fix proper srcu api call
      fs: dlm: define max send buffer
      fs: dlm: add get buffer error handling
      fs: dlm: flush othercon at close
      fs: dlm: handle non blocked connect event
      fs: dlm: add helper for init connection
      fs: dlm: move connect callback in node creation
      fs: dlm: move shutdown action to node creation
      fs: dlm: refactor sctp sock parameter
      fs: dlm: listen socket out of connection hash
      fs: dlm: fix check for multi-homed hosts
      fs: dlm: constify addr_compare
      fs: dlm: check on existing node address

 fs/dlm/lockspace.c |   2 +-
 fs/dlm/lowcomms.c  | 304 ++++++++++++++++++++++++++++-------------------------
 fs/dlm/lowcomms.h  |   2 +
 fs/dlm/member.c    |   2 +-
 fs/dlm/rcom.c      |   6 +-
 5 files changed, 168 insertions(+), 148 deletions(-)

