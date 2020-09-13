Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BCE267D35
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 03:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgIMByV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 21:54:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49266 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725924AbgIMByU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 21:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599962058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QIDh4G/PGvPaMQJuhvU74zkMK08lHXRccI1BFEmlDJE=;
        b=evABLoPeT4SX1/HA6DjmgCKZ9dxXbG2bOdvrHb7r3smeqEvE1nQyzt4W0hp/KZUXsB835x
        gBPHINkT7OHTGEztE6tWB413I4VTVcNOAFLmlArg/YA7YXkJCNhvXwM79yAAYGyCXOCWG2
        KqPvLitLYKrbVqNAlFhShPmGz9wijy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-wmzrZIiSOLuLOsUAPXiD8w-1; Sat, 12 Sep 2020 21:54:14 -0400
X-MC-Unique: wmzrZIiSOLuLOsUAPXiD8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E6E01091063;
        Sun, 13 Sep 2020 01:54:13 +0000 (UTC)
Received: from ovpn-112-20.rdu2.redhat.com (ovpn-112-20.rdu2.redhat.com [10.10.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98C3275120;
        Sun, 13 Sep 2020 01:54:12 +0000 (UTC)
Message-ID: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
Subject: BUG: Bad page state in process dirtyc0w_child
From:   Qian Cai <cai@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 12 Sep 2020 21:54:12 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Occasionally, running this LTP test will trigger an error below on
s390:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/dirtyc0w/dirtyc0w.c
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c

this .config:
https://gitlab.com/cailca/linux-mm/-/blob/master/s390.config

[ 6970.253173] LTP: starting dirtyc0w
[ 6971.599102] BUG: Bad page state in process dirtyc0w_child  pfn:8865d
[ 6971.599867] page:000000001a8328d7 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8865d
[ 6971.599876] flags: 0x400000000008000e(referenced|uptodate|dirty|swapbacked)
[ 6971.599886] raw: 400000000008000e 0000000000000100 0000000000000122 0000000000000000
[ 6971.599893] raw: 0000000000000000 0000000000000000 ffffffff00000000 0000000000000000
[ 6971.599900] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[ 6971.599906] Modules linked in: loop kvm ip_tables x_tables dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
[ 6971.599952] CPU: 1 PID: 65238 Comm: dirtyc0w_child Tainted: G           O      5.9.0-rc4-next-20200909 #1
[ 6971.599959] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
[ 6971.599964] Call Trace:
[ 6971.599979]  [<0000000073aec038>] show_stack+0x158/0x1f0 
[ 6971.599986]  [<0000000073af724a>] dump_stack+0x1f2/0x238 
[ 6971.599994]  [<0000000072ed086a>] bad_page+0x1ba/0x1c0 
[ 6971.600000]  [<0000000072ed20c4>] free_pcp_prepare+0x4fc/0x658 
[ 6971.600006]  [<0000000072ed96a6>] free_unref_page+0xae/0x158 
[ 6971.600013]  [<0000000072e8286a>] unmap_page_range+0xb62/0x1df8 
[ 6971.600019]  [<0000000072e83bbc>] unmap_single_vma+0xbc/0x1c8 
[ 6971.600025]  [<0000000072e8418e>] zap_page_range+0x176/0x230 
[ 6971.600033]  [<0000000072eece8e>] do_madvise+0xfde/0x1270 
[ 6971.600039]  [<0000000072eed50a>] __s390x_sys_madvise+0x72/0x98 
[ 6971.600047]  [<0000000073b1cce4>] system_call+0xdc/0x278 
[ 6971.600053] 2 locks held by dirtyc0w_child/65238:
[ 6971.600058]  #0: 000000013442fa18 (&mm->mmap_lock){++++}-{3:3}, at: do_madvise+0x17a/0x1270
[ 6971.600432]  #1: 00000001343f9060 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: unmap_page_range+0x640/0x1df8
[ 6971.600487] Disabling lock debugging due to kernel taint

Once it happens, running it again will trigger in on another PFN.

[39717.085115] BUG: Bad page state in process dirtyc0w_child  pfn:af065 

Any thoughts?

