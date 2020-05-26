Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7071DBC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 20:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgETSM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 14:12:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726940AbgETSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589998372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xN2W+VHPdONngIsn/cmQXo9hulCtlz3Fu6VwpKF5hZ0=;
        b=aBA00A2GpeuBavHxIPHzsoYKg9bs94kTLTJaNgMC1v3xe0JqC180U74OdZzi3XjfIrxF4P
        2aoWuc+Nk3AudZKa76rIUKXkMqL64EVGhSjMPWuqiNkzMwh/dmK5+s2CBkqgNPpTNTzooX
        FuLBS+Q3MfWjvr4iQzDbDGt84NH5z0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-AYBkFoVVNAixcRnr5zIGOA-1; Wed, 20 May 2020 14:12:48 -0400
X-MC-Unique: AYBkFoVVNAixcRnr5zIGOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9C56184C5C0;
        Wed, 20 May 2020 18:12:46 +0000 (UTC)
Received: from starship.redhat.com (unknown [10.35.207.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 652A510640E1;
        Wed, 20 May 2020 18:12:44 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-usb@vger.kernel.org (open list:THUNDERBOLT DRIVER),
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org (open list),
        Jiri Kosina <trivial@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 1/1] thunderbolt: add trivial .shutdown
Date:   Wed, 20 May 2020 21:12:40 +0300
Message-Id: <20200520181240.118559-2-mlevitsk@redhat.com>
In-Reply-To: <20200520181240.118559-1-mlevitsk@redhat.com>
References: <20200520181240.118559-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my machine, a kexec with this driver loaded in the old kernel
causes a very long delay on boot in the kexec'ed kernel,
most likely due to unclean shutdown prior to that.

Unloading thunderbolt driver prior to kexec allows kexec to work as fast
as regular kernel boot, as well as adding this .shutdown pointer.

Shutting a device prior to the shutdown completely is always
a good idea IMHO to help with kexec,
and this one-liner patch implements it.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/thunderbolt/nhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 1be491ecbb45..4046642e6aec 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1285,6 +1285,7 @@ static struct pci_driver nhi_driver = {
 	.id_table = nhi_ids,
 	.probe = nhi_probe,
 	.remove = nhi_remove,
+	.shutdown = nhi_remove,
 	.driver.pm = &nhi_pm_ops,
 };
 
-- 
2.25.4

