Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835882E1C80
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgLWNHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:07:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:11916 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbgLWNHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:07:03 -0500
IronPort-SDR: aA59IiqgktxsjKzJ5hXkdzIHU705dA3KWqyrflgdfBzxgANVajVaRsmItyiqYXIy3wwgriU/To
 YahuRag2Sglw==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="240094464"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="240094464"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 05:03:32 -0800
IronPort-SDR: SVzuF1zszKaF7JsvB3LHe9TVLsucyNzFOFGHXp3uCowS238uV/PSow/wpHhq2odnWAmBYJDY+6
 codwEWtuNZHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="393087763"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2020 05:03:26 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com
Subject: [PATCH v2 2/6] perf evsel: Introduce an observed performance device
Date:   Wed, 23 Dec 2020 16:03:16 +0300
Message-Id: <20201223130320.3930-3-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding evsel::perf_device void pointer.

For performance monitoring purposes, an evsel can have a related device.
These changes allow to attribute, for example, I/O performance metrics
to IIO stack.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/util/evsel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 79a860d8e3ee..c346920f477a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -127,6 +127,7 @@ struct evsel {
 	 * See also evsel__has_callchain().
 	 */
 	__u64			synth_sample_type;
+	void			*perf_device;
 };
 
 struct perf_missing_features {
-- 
2.19.1

