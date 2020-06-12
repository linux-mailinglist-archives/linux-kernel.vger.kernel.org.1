Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946AC1F7F75
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 01:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFLXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 19:15:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52432 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgFLXPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 19:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592003741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mJF77wjfQf5PIjD3lW9RyfB0DRTR9vtehyxPDHs1NyY=;
        b=ag+7ZsZLlvRQcg/0xqPFiqPgMnYECchCjmldcNwM7dvBuMLs6D5gZ+DEnt2/c+emOmw/S0
        KHPLiDIFEPPp1ErQszcPbpOu6PPaDMspzACG69dYkjnSMV3E/wwUEeVAfYZgoSmzhqP/Gx
        ybj++02vN7qlhgklIGCftuGU2Z0VbtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396--ZHDImbMP6qk6IUguxNq8g-1; Fri, 12 Jun 2020 19:15:39 -0400
X-MC-Unique: -ZHDImbMP6qk6IUguxNq8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0271B464;
        Fri, 12 Jun 2020 23:15:39 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-112-134.phx2.redhat.com [10.3.112.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C22405D9C5;
        Fri, 12 Jun 2020 23:15:38 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 0/2] iommu: Move AMD and Intel Kconfig + Makefile bits into their directories
Date:   Fri, 12 Jun 2020 16:10:58 -0700
Message-Id: <20200612231100.293734-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset imeplements the suggestion from Linus to move the Kconfig
and Makefile bits for AMD and Intel into their respective directories.
It also cleans up a couple Kconfig entries to use the newer help
attribute instead of ---help--- (complaint from checkpatch).

Jerry Snitselaar (2):
      iommu/vt-d: Move Kconfig and Makefile bits down into intel directory
      iommu/amd: Move Kconfig and Makefile bits down into amd directory


