Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A163F2EFE50
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbhAIHpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:45:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C91C061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 23:44:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u4so5799023pjn.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 23:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nX/SNe+TxB6f8lmI1bQGRi2oTbVzOfaCD6cIbIE8/Uk=;
        b=v6dpzxmphrwoAzn+koiLQ4DLJbnmFtgocIbJ61Og8WWuiYYA/RE2GvvjcYRR5W42fa
         g9kh/1pntJ/Mk39rDTHyN8WjcIB5eyVmY90m8w4pJmfxhAzZOi+YhPWtZw6LES6GLIe3
         kQHrkooqI7tqoFM8YsPAUo43jEHhgqJm81ov3gEBrYKPBztXDCsuKL2lHUpQmkPH1Yl5
         O1scgwALnI1yc6XIzNVvcYCQdJgRynYQKcg3hbr2oeMgXNrEodiV7DBLBZg9vyNL2wRB
         qA/uhnhYFJ9Nyo0eEsriSRTwtK+vI8LbjxZH0GOMFblbY4TXigTlpjDRNXMa7TaP9EDp
         R2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nX/SNe+TxB6f8lmI1bQGRi2oTbVzOfaCD6cIbIE8/Uk=;
        b=GHrJHsG4KyQlvVbt/QZv3ooxWPr/qPvmdlAHg0E5a8r19Thb0J9Tu6/ofJvrpcbrkq
         9o1Psoo8+gxCATuK8PLaigtGeVj0Ec/9mNl6ooNToib1qoSGosF4PkQH/q+T/JSF/8Sc
         5iy+H92rM4gd3RCNEpsUcxrbWmihpwCst/ZlNl+Y5xvBS+HKjJq2ij3AkwUdRqt9gIEj
         VZZ5qzeaXRxJUqrRkmUR/oD9JpsUWI5FcjcQ2Ry2lyZmGUhCPd3G8B5y+4FcbHVIsNg/
         WdyCsYsqBK2JbTLKkveiROQFRSPWv2+c3ntxd0q049jP/qP84w02NBt+/5TwzCE0z4NO
         jYwQ==
X-Gm-Message-State: AOAM530ECsBGdMX5VF9pc37jvGpGHumJWhsOmfB7oGKm5of2j90TuHn4
        7X6R9kMxXd5ujYQb4fM/Uw7dUA==
X-Google-Smtp-Source: ABdhPJye7ygbaULPOsmC5QRLmfGuYKmQv8j2UOcOrcCHh+/y45YGja52AMjVlYduiXIF1QK47UcxvA==
X-Received: by 2002:a17:902:b781:b029:db:e4ee:b8c7 with SMTP id e1-20020a170902b781b02900dbe4eeb8c7mr7529405pls.69.1610178293251;
        Fri, 08 Jan 2021 23:44:53 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id 8sm12443280pgx.48.2021.01.08.23.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 23:44:52 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/7] coresight: etm-perf: Fix pid tracing with VHE
Date:   Sat,  9 Jan 2021 15:44:28 +0800
Message-Id: <20210109074435.626855-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a following up for the previous version which was
delivered by Suzuki [1].  Below gives the background info for why we
need this patch series, directly quotes the description in the cover
letter of the previous version:

"With the Virtualization Host Extensions, the kernel can run at EL2.
In this case the pid is written to CONTEXTIDR_EL2 instead of the
CONTEXTIDR_EL1. Thus the normal coresight tracing will be unable
to detect the PID of the thread generating the trace by looking
at the CONTEXTIDR_EL1. Thus, depending on the kernel EL, we must
switch to tracing the correct CONTEXTIDR register.

With VHE, we must set the TRCCONFIGR.VMID and TRCCONFIGR.VMID_OPT
to include the CONTEXTIDR_EL2 as the VMID in the trace. This
requires the perf tool to detect the changes in the TRCCONFIGR and
use the VMID / CID field for the PID. The challenge here is for
the perf tool to detect the kernel behavior.

Instead of the previously proposed invasive approaches, this set
implements a less intrusive mechanism, by playing with the
perf_event.attribute.config bits."

Same as the previous series, this series keeps the same implementation
for two introduced format bits:

- contextid_in_vmid -> Is only supported when the VMID tracing
  and CONTEXTIDR_EL2 both are supported. When requested the perf
  etm4x backend sets (TRCCONFIGR.VMID | TRCCONFIGR.VMID_OPT).
  As per ETMv4.4 TRM, when the core supports VHE, the CONTEXTIDR_EL2
  tracing is mandatory. (See the field TRCID2.VMIDOPT)

- pid -> Is an alias for the correct config to enable PID tracing
  on any kernel.
  i.e, in EL1 kernel -> pid == contextid
          EL2 kernel -> pid == contextid_in_vmid

With this, the perf tool is also updated to request the "pid"
tracing whenever available, falling back to "contextid" if it
is unavailable.

Comparing against the old version, this patch series uses the metadata
to save PID format; after add new item into metadata, it introduces
backward compatibility issue.  To allow backward compatibility, this
series calculates per CPU metadata array size and avoid to use the
defined macro, so can always know the correct array size based on the
info stored in perf data file.  Finally, the PID format stored in
metadata is passed to decoder and guide the decoder to set PID from
CONTEXTIDR_EL1 or VMID.

This patch series has been tested on Arm Juno-r2 board, with testing
two perf data files: one data file is recorded by the latest perf tool
after applied this patch series, and another data file is recorded by
old perf tool without this patch series, so this can prove the tool is
backward compatible.

Changes from RFC:
* Added comments to clarify cases requested (Leo);
* Explain the change to generic flags for cs_etm_set_option() in the
  commit description;
* Stored PID format in metadata and passed it to decoder (Leo);
* Enhanced cs-etm for backward compatibility (Denis Nikitin).

[1] https://archive.armlinux.org.uk/lurker/message/20201110.183310.24406f33.en.html


Leo Yan (4):
  perf cs-etm: Calculate per CPU metadata array size
  perf cs-etm: Add PID format into metadata
  perf cs-etm: Fixup PID_FMT when it is zero
  perf cs-etm: Add helper cs_etm__get_pid_fmt()

Suzuki K Poulose (3):
  coresight: etm-perf: Add support for PID tracing for kernel at EL2
  perf cs_etm: Use pid tracing explicitly instead of contextid
  perf cs-etm: Detect pid in VMID for kernel running at EL2

 .../hwtracing/coresight/coresight-etm-perf.c  | 14 +++
 .../coresight/coresight-etm4x-core.c          |  9 ++
 include/linux/coresight-pmu.h                 | 11 ++-
 tools/include/linux/coresight-pmu.h           | 11 ++-
 tools/perf/arch/arm/util/cs-etm.c             | 89 +++++++++++++++----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 32 ++++++-
 tools/perf/util/cs-etm.c                      | 61 ++++++++++++-
 tools/perf/util/cs-etm.h                      |  3 +
 8 files changed, 198 insertions(+), 32 deletions(-)

-- 
2.25.1

