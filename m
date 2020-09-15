Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9574A26AECC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgIOUml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728068AbgIOUlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600202484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/guuc+vEKgfUTOby/AHD8u3LLf1ZyNtwzF2yHFYNmo=;
        b=YF8taBJUE0LJYemYMHvz6QOz+ADYo6QXbrC9knCTo8xqLXvh08YuXmq3jJujf9pv+Z5c0Y
        v1NoMzka5lE9QmYJk/TsNqAKiboWDjM2PaHNSBNJlKA3tj4vSVTjV9DqUCxGjzdZyEvRQp
        I5HO49aLy9u4QNOk9mCrBnBz0cZ05QU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-2M-0hANuOWawycINBl01Hw-1; Tue, 15 Sep 2020 16:41:20 -0400
X-MC-Unique: 2M-0hANuOWawycINBl01Hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02D43186DD21;
        Tue, 15 Sep 2020 20:41:19 +0000 (UTC)
Received: from trippy.localdomain (ovpn-113-154.rdu2.redhat.com [10.10.113.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 722C8100164C;
        Tue, 15 Sep 2020 20:41:18 +0000 (UTC)
From:   Mark Salter <msalter@redhat.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drivers/perf: thunderx2_pmu: Fix memory resource error handling
Date:   Tue, 15 Sep 2020 16:41:10 -0400
Message-Id: <20200915204110.326138-2-msalter@redhat.com>
In-Reply-To: <20200915204110.326138-1-msalter@redhat.com>
References: <20200915204110.326138-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tx2_uncore_pmu_init_dev(), a call to acpi_dev_get_resources() is used
to create a list _CRS resources which is searched for the device base
address. There is an error check following this:

   if (!rentry->res)
           return NULL

In no case, will rentry->res be NULL, so the test is useless. Even
if the test worked, it comes before the resource list memory is
freed. None of this really matters as long as the ACPI table has
the memory resource. Let's clean it up so that it makes sense and
will give a meaningful error should firmware leave out the memory
resource.

Fixes: 69c32972d593 ("drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver")
Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/perf/thunderx2_pmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index aac9823b0c6b..e116815fa809 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -805,14 +805,17 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
 	list_for_each_entry(rentry, &list, node) {
 		if (resource_type(rentry->res) == IORESOURCE_MEM) {
 			res = *rentry->res;
+			rentry = NULL;
 			break;
 		}
 	}
+	acpi_dev_free_resource_list(&list);
 
-	if (!rentry->res)
+	if (rentry) {
+		dev_err(dev, "PMU type %d: Fail to find resource\n", type);
 		return NULL;
+	}
 
-	acpi_dev_free_resource_list(&list);
 	base = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(base)) {
 		dev_err(dev, "PMU type %d: Fail to map resource\n", type);
-- 
2.26.2

