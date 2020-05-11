Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143721CE607
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbgEKUxZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 May 2020 16:53:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35405 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727873AbgEKUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:53:24 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-Xd5Dz6Z9OYqR5urTgn-IWA-1; Mon, 11 May 2020 16:53:19 -0400
X-MC-Unique: Xd5Dz6Z9OYqR5urTgn-IWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 174D7460;
        Mon, 11 May 2020 20:53:18 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 516887526E;
        Mon, 11 May 2020 20:53:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/4] perf expr: Allow comments in custom metric file
Date:   Mon, 11 May 2020 22:53:05 +0200
Message-Id: <20200511205307.3107775-3-jolsa@kernel.org>
In-Reply-To: <20200511205307.3107775-1-jolsa@kernel.org>
References: <20200511205307.3107775-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 4
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to use comments within the custom metric file
with both the shell '# ... ' and C '/* ... */ styles.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.l | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index c6a930ed22e6..e9b294ba09fc 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -82,6 +82,8 @@ static int str(yyscan_t scanner, int token, int runtime)
 %}
 
 %x custom
+%x comment_single
+%x comment_multi
 
 number		[0-9]*\.?[0-9]+
 
@@ -116,6 +118,16 @@ else		{ return ELSE; }
 #smt_on		{ return SMT_ON; }
 {number}	{ return value(yyscanner); }
 {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
+
+"//"			{ BEGIN(comment_single); }
+<comment_single>\n	{ BEGIN(INITIAL); }
+<comment_single>.	{ }
+
+"/*"			{ BEGIN(comment_multi); }
+<comment_multi>"*/"	{ BEGIN(INITIAL); }
+<comment_multi>\n	{ }
+<comment_multi>.	{ }
+
 "|"		{ return '|'; }
 "^"		{ return '^'; }
 "&"		{ return '&'; }
-- 
2.25.4

