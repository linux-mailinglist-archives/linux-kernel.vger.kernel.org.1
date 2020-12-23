Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9D2E1C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgLWNF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:05:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:55068 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgLWNF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:05:26 -0500
IronPort-SDR: UCfpe0Z+DCX3OhqlLJqoB76kvl2u0fli6Kf6Dk7htbAZO9vwk7dNvyLKa1rtbg8q/qBZqMvi1g
 6FneBXMDPcpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="163068607"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="163068607"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 05:03:41 -0800
IronPort-SDR: ONeVYJx0LOtsgRMl1ME+5zlsVj7j+q18+OlnfU/pw62aadIMAUsshq8TTnOZI8REsXpYgFMDZK
 ARUrRTB6kQyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="393087816"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2020 05:03:38 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com
Subject: [PATCH v2 6/6] perf: Update .gitignore file
Date:   Wed, 23 Dec 2020 16:03:20 +0300
Message-Id: <20201223130320.3930-7-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a "make -C tools/perf", git reports the following untracked file:
perf-iiostat

Add this generated file to perf's .gitignore file.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f3f84781fd74..ab826736e677 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -20,6 +20,7 @@ perf.data.old
 output.svg
 perf-archive
 perf-with-kcore
+perf-iiostat
 tags
 TAGS
 cscope*
-- 
2.19.1

