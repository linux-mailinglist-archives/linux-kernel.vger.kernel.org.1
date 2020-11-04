Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D642A6428
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgKDMVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:21:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:48932 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgKDMVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:21:16 -0500
IronPort-SDR: lPxghA+2vjOPd9RcJ7Z+/l5xSUorfPyNZxAoYudqwJTWXzmOta5kDjUwda7G0Wkt3j5LUUqXE0
 /P0xCT15a1lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="168420607"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="168420607"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 04:21:16 -0800
IronPort-SDR: zGtwxVkHwVm4qp/4p1KZPEy5xJRDhRi8LgxeuZxEuasBeyNWCIjii+F9dT9mbMZxPWj1DQvZK0
 qCc+CZmMM3bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="336863525"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orsmga002.jf.intel.com with ESMTP; 04 Nov 2020 04:21:14 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Steven Rostedt" <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] docs: trace: fix event state structure name
Date:   Wed,  4 Nov 2020 14:21:13 +0200
Message-Id: <20201104122113.322452-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The documentation refers to a non-existent 'struct synth_trace_state'
structure. The correct name is 'struct synth_event_trace_state'.

In other words, this patch is a mechanical substitution:
s/synth_trace_state/synth_event_trace_state/g

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 Documentation/trace/events.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index f792b1959a33..bdba7b0e19ef 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -787,13 +787,13 @@ To trace a synthetic using the piecewise method described above, the
 synth_event_trace_start() function is used to 'open' the synthetic
 event trace::
 
-       struct synth_trace_state trace_state;
+       struct synth_event_trace_state trace_state;
 
        ret = synth_event_trace_start(schedtest_event_file, &trace_state);
 
 It's passed the trace_event_file representing the synthetic event
 using the same methods as described above, along with a pointer to a
-struct synth_trace_state object, which will be zeroed before use and
+struct synth_event_trace_state object, which will be zeroed before use and
 used to maintain state between this and following calls.
 
 Once the event has been opened, which means space for it has been
@@ -805,7 +805,7 @@ lookup per field.
 
 To assign the values one after the other without lookups,
 synth_event_add_next_val() should be used.  Each call is passed the
-same synth_trace_state object used in the synth_event_trace_start(),
+same synth_event_trace_state object used in the synth_event_trace_start(),
 along with the value to set the next field in the event.  After each
 field is set, the 'cursor' points to the next field, which will be set
 by the subsequent call, continuing until all the fields have been set
@@ -834,7 +834,7 @@ this method would be (without error-handling code)::
        ret = synth_event_add_next_val(395, &trace_state);
 
 To assign the values in any order, synth_event_add_val() should be
-used.  Each call is passed the same synth_trace_state object used in
+used.  Each call is passed the same synth_event_trace_state object used in
 the synth_event_trace_start(), along with the field name of the field
 to set and the value to set it to.  The same sequence of calls as in
 the above examples using this method would be (without error-handling
@@ -856,7 +856,7 @@ can be used but not both at the same time.
 
 Finally, the event won't be actually traced until it's 'closed',
 which is done using synth_event_trace_end(), which takes only the
-struct synth_trace_state object used in the previous calls::
+struct synth_event_trace_state object used in the previous calls::
 
        ret = synth_event_trace_end(&trace_state);
 
-- 
2.26.2

