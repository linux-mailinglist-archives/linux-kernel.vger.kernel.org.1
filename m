Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F3F2AD6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbgKJMqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:46:24 -0500
Received: from foss.arm.com ([217.140.110.172]:55172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732388AbgKJMqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:46:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34A58139F;
        Tue, 10 Nov 2020 04:46:18 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E09DC3F6CF;
        Tue, 10 Nov 2020 04:46:15 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 09/11] coresight: etm-perf: Disable the path before capturing the trace data
Date:   Tue, 10 Nov 2020 18:15:07 +0530
Message-Id: <1605012309-24812-10-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf handle structure needs to be shared with the TRBE IRQ handler for
capturing trace data and restarting the handle. There is a probability
of an undefined reference based crash when etm event is being stopped
while a TRBE IRQ also getting processed. This happens due the release
of perf handle via perf_aux_output_end(). This stops the sinks via the
link before releasing the handle, which will ensure that a simultaneous
TRBE IRQ could not happen.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This might cause problem with traditional sink devices which can be
operated in both sysfs and perf mode. This needs to be addressed
correctly. One option would be to move the update_buffer callback
into the respective sink devices. e.g, disable().

 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 534e205..1a37991 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -429,7 +429,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
 
 		size = sink_ops(sink)->update_buffer(sink, handle,
 					      event_data->snk_config);
+		coresight_disable_path(path);
 		perf_aux_output_end(handle, size);
+		return;
 	}
 
 	/* Disabling the path make its elements available to other sessions */
-- 
2.7.4

