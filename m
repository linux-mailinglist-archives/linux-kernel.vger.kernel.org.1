Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CFB274296
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIVNE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbgIVNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/IP+WfbcRNS1v69lsAcdAGpxaUiKFc+z2mIpWOTNxc=;
        b=VLAufAifFyvUtESozpMIOQN+jsLtng7yh3WAPIbo/yHo4OqKDXKCQbbJmc8VTi3XG8lYCV
        MHJyyISjOBW5zQFmkLZW3l4pcce6eypLei9/qwMlSZYe4maeKP9M1DB2Uc25B3NMKAbVYE
        6/JZ/P1GSXhiaJUZkx/o4Ue76pTu93k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-tBArJi8-P3K1MN4H_-Q5lA-1; Tue, 22 Sep 2020 09:04:51 -0400
X-MC-Unique: tBArJi8-P3K1MN4H_-Q5lA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC423801AE1;
        Tue, 22 Sep 2020 13:04:49 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 948B373670;
        Tue, 22 Sep 2020 13:04:47 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 03/13] firmware: arm_sdei: Retrieve event number from event instance
Date:   Tue, 22 Sep 2020 23:04:13 +1000
Message-Id: <20200922130423.10173-4-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdei_event_create(), the event number is retrieved from the
variable @event_num for the shared event. The event number was
stored in the event instance. So we can fetch it from the event
instance, similar to what we're doing for the private event.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index a126ab7e3490..0f49fff20cc7 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -217,7 +217,7 @@ static struct sdei_event *sdei_event_create(u32 event_num,
 			goto fail;
 		}
 
-		reg->event_num = event_num;
+		reg->event_num = event->event_num;
 		reg->priority = event->priority;
 
 		reg->callback = cb;
-- 
2.23.0

