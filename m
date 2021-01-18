Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EC72F984D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 04:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbhARDcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 22:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731812AbhARDbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610940609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=4oOV9uOT/R4L7lZw3/DtR5eifHD3mnxn+2EAfxBmyFk=;
        b=MLJdlC27cdgGHegSG7Oj5XB1VgSQiKlwMDgG3ys2MCWhm6zMSGMuoVQsm86bMiJgLyCdLZ
        itMDgU+FTEe9PQt6LOut/U3vZgKHmtmPrbVgMqV74H7iCRmcIveXBDYmki2HztG7OlWsV+
        D4EyOiOhN1uZI93x/yD/OyGuA4Ecpn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-BgJLvB03OdijkLPuOliroQ-1; Sun, 17 Jan 2021 22:30:05 -0500
X-MC-Unique: BgJLvB03OdijkLPuOliroQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A7D4107ACF5;
        Mon, 18 Jan 2021 03:30:03 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-112-152.rdu2.redhat.com [10.10.112.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 895FE629BF;
        Mon, 18 Jan 2021 03:30:02 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 7D7C73C00CE; Mon, 18 Jan 2021 00:30:00 -0300 (-03)
Date:   Mon, 18 Jan 2021 00:30:00 -0300
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
Subject: [ANNOUNCE] 4.9.252-rt167
Message-ID: <20210118033000.GA3656@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.252-rt167 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 7faa9ce183878ef770c049007634cbaffd8ec129

Or to build 4.9.252-rt167 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.252.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.252-rt167.patch.xz


Enjoy!
Luis

