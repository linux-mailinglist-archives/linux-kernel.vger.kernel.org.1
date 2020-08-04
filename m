Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB99E23B448
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 06:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgHDEtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 00:49:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37917 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbgHDEtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596516589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=7qceo5Ac5pw8FN//Zkg47pbNKHNVeomNG9fIClXDyOY=;
        b=ABOCdiceRhLc7KRFdxJjeFlAe64ud7zhs28sfqc9gtKCgeVIe8ZTIUQiaod0rLVaqhZVbo
        N/EyHp2qRPNkAD4XksYt6bthPQNnEx72Z10B9x3ILFc5fsq6Pg9r5xVwYvtRsqPTzESpoC
        Pc5BsUgASWdBedAwf3SkEdRHbFwanZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-FTerOuhxM02DECn9qnj0NQ-1; Tue, 04 Aug 2020 00:49:44 -0400
X-MC-Unique: FTerOuhxM02DECn9qnj0NQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F57DE918;
        Tue,  4 Aug 2020 04:49:43 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAB5B10013D7;
        Tue,  4 Aug 2020 04:49:35 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com, dyoung@redhat.com,
        bhe@redhat.com, k-hagio@ab.jp.nec.com
Subject: [PATCH 0/3] x86/kexec_file: Fix some corners bugs and improve the crash_exclude_mem_range()
Date:   Tue,  4 Aug 2020 12:49:30 +0800
Message-Id: <20200804044933.1973-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes the following patches, it fixes some corners bugs
and improves the crash_exclude_mem_range().

[1] [PATCH 1/3] x86/crash: Correct the address boundary of function
    parameters
[2] [PATCH 2/3] kexec: Improve the crash_exclude_mem_range() to handle
    the overlapping ranges
[3] [PATCH 3/3] kexec_file: correctly output debugging information for
    the PT_LOAD elf header

Lianbo Jiang (3):
  x86/crash: Correct the address boundary of function parameters
  kexec: Improve the crash_exclude_mem_range() to handle the overlapping
    ranges
  kexec_file: correctly output debugging information for the PT_LOAD elf
    header

 arch/x86/kernel/crash.c |  2 +-
 kernel/kexec_file.c     | 33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.17.1

