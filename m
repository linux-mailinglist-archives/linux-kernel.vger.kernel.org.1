Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F1B274292
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIVNEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zYrq0SQgB2it8jTqnWHIu8ZhXX5avMcb4F7vxXt9Ivs=;
        b=FwZMYk3p4r0/rsv7MHmGW3oH7qlP2baCB5JU8uwEbG2SLo6rbkf0qfzUKpep5AL4B3dVcf
        dhEkKnwIbSX4z0qxlF977isEezKkl5ekhxsE2AOBG8TO46KgH9B3zQAbMcY0ViqJ7pGC8Y
        UBCa2OXQYFEPulMMPqPjiiLBKuMskIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-HB9WwhaZP0-4Jtgt_KGoVw-1; Tue, 22 Sep 2020 09:04:43 -0400
X-MC-Unique: HB9WwhaZP0-4Jtgt_KGoVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9938ADC00;
        Tue, 22 Sep 2020 13:04:41 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 337CC73670;
        Tue, 22 Sep 2020 13:04:38 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 00/13] Refactor SDEI client driver
Date:   Tue, 22 Sep 2020 23:04:10 +1000
Message-Id: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series bases on 5.9.rc5 and extracted from (v4) series of "Refactoring
SDEI client driver", which is prepatory work to support SDEI virtualizaton.
This series can be checkout from github.

   git@github.com:gwshan/linux.git (branch: "sdei_client")

Testing
=======
I have the SDEI virtualization code implemented as part of KVM module.
With that, the SDEI event can be registered/unregistered/enabled/disabled.
Also, the SDEI event can be injected from host and the guest handler runs
properly.

The code can be found from:

   git@github.com:gwshan/linux.git
   (branch: "sdei")

Changelog
=========
v5:
   Rebase to 5.9.rc5 and pick rbs from James                       (Gavin)
   Improved changelog                                              (James)
   Drop last two patches in v4 series and fold them to the series
   of "Support SDEI virtualization"                                (James)
   Fix use-after-free in sdei_reregister_shared()                  (James)  
v4:
   Rebase to last upstream kernel                                  (Gavin)
   Use @event_el for SDEI internal event and use @event to cache
   SDEI event if needed                                            (Jonathan)
   Rename @se to @event for APIs                                   (Jonathan)
v3:
   Rebase to 5.8.rc7                                               (Gavin)
   Pick rbs from Jonathan                                          (Gavin)
   Correct spellings in commit logs                                (Jonathan)
   Rename "out" to "unlock" tag                                    (Jonathan)
   Keep the empty line in sdei_event_unregister()                  (Jonathan)
   Drop tabs between type and field for struct sdei_crosscall_args (Jonathan)
   Use smp_call_func_t for @fn argument in CPU callbacks           (Jonathan)
   Split struct sdei_event into struct sdei_{internal,}_event      (Jonathan)
   Remove last two patches and get it reviewed later               (Jonathan)
v2:
   Rebase to 5.8.rc6                                               (Gavin)
   Improved changelog                                              (James/Gavin)
   Split patches for easy review                                   (Gavin)
   Drop changes to reorder variables                               (James)
   Drop unnecessary (@regs removal) cleanup in sdei_event_create() (James)
   Fix broken case for device-tree in sdei_init()                  (James)

Gavin Shan (13):
  firmware: arm_sdei: Remove sdei_is_err()
  firmware: arm_sdei: Common block for failing path in
    sdei_event_create()
  firmware: arm_sdei: Retrieve event number from event instance
  firmware: arm_sdei: Avoid nested statements in sdei_init()
  firmware: arm_sdei: Unregister driver on error in sdei_init()
  firmware: arm_sdei: Remove duplicate check in sdei_get_conduit()
  firmware: arm_sdei: Remove redundant error message in sdei_probe()
  firmware: arm_sdei: Remove while loop in sdei_event_register()
  firmware: arm_sdei: Remove while loop in sdei_event_unregister()
  firmware: arm_sdei: Cleanup on cross call function
  firmware: arm_sdei: Introduce sdei_do_local_call()
  firmware: arm_sdei: Remove _sdei_event_register()
  firmware: arm_sdei: Remove _sdei_event_unregister()

 drivers/firmware/arm_sdei.c | 305 ++++++++++++++++--------------------
 1 file changed, 136 insertions(+), 169 deletions(-)

-- 
2.23.0

