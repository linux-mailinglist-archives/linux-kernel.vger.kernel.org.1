Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47CD29614E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368415AbgJVO67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368400AbgJVO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD294C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e17so2816663wru.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4AnLEPZu0pmEEAWiGvbutOOnynN2Dk9B4gNaXg7tbjk=;
        b=RWx6BCM0KXJ9OmOVzB/qI84Ruxseycv0llbE50znLRQdMmozS7gaWRd0mGlQj99P5O
         NB3InKPVLLSix5XjdQhs5Uo4U+N5W3HOth596L849KUrcl+mvbl3ffjYM9fqLueOHAOq
         QB5Hn1LrG0Httuv+zqh5hkyh72fdMfNxPC3aD3a60zWrxF699Tyd/oDbj8JmGmn9V5BS
         4CYMIgTNqHS4I+zNxx3MVt1BKM7D0GvlXx9O/wSxFeEvrCyHbIs1EkYHJscWDwRFax52
         hNBuM/tc7tCTu1VVjjOKepZFYAOgM5Ookw+zvb4+Q5ZxnEjlsDj11/aRxx6j9BT236C0
         zF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4AnLEPZu0pmEEAWiGvbutOOnynN2Dk9B4gNaXg7tbjk=;
        b=PIS6vtf5eH317yFuKkcU8MXU5rK1491oFAUPg7FfmoWplXxYg9uhG2Q6sfK2HrgSHm
         E45Kqq6sqO9t3gJZqQP2JfNcXj+evlBP/H63kIE7EW800Im5BNFdF2YylMKvjYns8hkB
         fsd+9GD7yuJuMxxS0wZAaSXWAWKJcWRTqLal8DkyMajjqyz1SA080LBdytei9QhVMCog
         MRRshi6jt/oYDG8uvh0hg2C0gzP7HGlsoAcbiXh+CDAmtVZZGRc/gbkb2itVOjqtrvB+
         obQWwJ7PVudqavVABH++MAF0kNCJ4jeLeFpRsdz9sMefGm0bl+LkVNm7zU8blIQA1bBH
         7gcw==
X-Gm-Message-State: AOAM533R6dJnM+7T5jucSq2P0kKjcr+09BUN6jIeK6kbnaLJlHxG3rfN
        RhWQ1aFyS86nDKNksd7SnRQ4EA==
X-Google-Smtp-Source: ABdhPJxC/yZQA0QO5jTKrKprrwWrpzHOgrNDsylczEg4kQrroi3Y4OY5dgsDLhdbdP+PSUfGDPfwWw==
X-Received: by 2002:a5d:414f:: with SMTP id c15mr3200368wrq.59.1603378732402;
        Thu, 22 Oct 2020 07:58:52 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:51 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 18/20] perf arm-spe: Add more sub classes for operation packet
Date:   Thu, 22 Oct 2020 15:58:14 +0100
Message-Id: <20201022145816.14069-19-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the operation type packet payload with load/store class, it misses
to support these sub classes:

  - A load/store targeting the general-purpose registers;
  - A load/store targeting unspecified registers;
  - The ARMv8.4 nested virtualisation extension can redirect system
    register accesses to a memory page controlled by the hypervisor.
    The SPE profiling feature in newer implementations can tag those
    memory accesses accordingly.

Add the bit pattern describing load/store sub classes, so that the perf
tool can decode it properly.

Inspired by Andre Przywara, refined the commit log and code for more
clear description.

Co-developed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 59b538563d31..c1a3b0afd1de 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -370,11 +370,35 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				if (ret < 0)
 					return ret;
 			}
-		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
-					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
+		}
+
+		switch (SPE_OP_PKT_LDST_SUBCLASS_GET(payload)) {
+		case SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP:
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
 			if (ret < 0)
 				return ret;
+
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_GP_REG:
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " GP-REG");
+			if (ret < 0)
+				return ret;
+
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG:
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " UNSPEC-REG");
+			if (ret < 0)
+				return ret;
+
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG:
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " NV-SYSREG");
+			if (ret < 0)
+				return ret;
+
+			break;
+		default:
+			break;
 		}
 
 		return buf_len - blen;
-- 
2.17.1

