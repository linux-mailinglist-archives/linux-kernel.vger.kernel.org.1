Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1541C223D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGQOEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:04:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43098 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727085AbgGQOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594994677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ngwVhwuIZ9N8nKS6j+ofJuXNHDXl3d76opbHIrcwguI=;
        b=V/p3Tl6UQKN7opakCp3LouEVsVGuvdPESD7CLijOlzfbwU/eVFo+wLW/DdxsV39VC4b+KV
        BK7slq8ta3FTJoQlM7svoiJHtytfLarLUyHy4rPtUKYx5jPB2/fM1wT9MiJSRhuXpOWQC4
        OK0djNlkQr8r5hq0w+5v9/GcDe6UGEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-Jbaj011tOHKhkci7uVfqMw-1; Fri, 17 Jul 2020 10:04:32 -0400
X-MC-Unique: Jbaj011tOHKhkci7uVfqMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 757FA18A1DE1;
        Fri, 17 Jul 2020 14:04:30 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-144.rdu2.redhat.com [10.10.118.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C117D6FEF8;
        Fri, 17 Jul 2020 14:04:29 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Subject: [PATCH 0/2] x86/unwind: A couple of fixes for newly forked tasks
Date:   Fri, 17 Jul 2020 09:04:24 -0500
Message-Id: <cover.1594994374.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of reliable unwinder fixes for newly forked tasks, which were
reported by Wang ShaoBo.

Josh Poimboeuf (2):
  x86/unwind/orc: Fix ORC for newly forked tasks
  x86/stacktrace: Fix reliable check for empty user task stacks

 arch/x86/kernel/stacktrace.c | 5 -----
 arch/x86/kernel/unwind_orc.c | 8 ++++++--
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.25.4

