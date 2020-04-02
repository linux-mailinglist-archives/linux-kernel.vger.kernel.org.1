Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C06F19C17E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbgDBMy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 08:54:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32642 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388332AbgDBMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585832097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZvhHGCmfnLbwTygn83xh2oho2ABzyI8d4jgR5/bYHs=;
        b=Vsn9aHMvvjU5KhCbRhtieoQGcIXrFWn2Jp6rZuPMhnYy0G4ji+BnpDnbiweawNNmww1TUD
        MBIR2lFaEcZot8sx2b68yFGIJRZEqFwSG9ungm7cHUA3a5+1k6Lx7t+oRaLsgpy6swZuH7
        7+EPjLUiXEfw0teY1rAe9DBu8iUQr/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-IeVeNxQxPXK74OcVA2DU6w-1; Thu, 02 Apr 2020 08:54:56 -0400
X-MC-Unique: IeVeNxQxPXK74OcVA2DU6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A628E13F8;
        Thu,  2 Apr 2020 12:54:54 +0000 (UTC)
Received: from agerstmayr-thinkpad.redhat.com (unknown [10.40.192.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC7FD5C1B0;
        Thu,  2 Apr 2020 12:54:48 +0000 (UTC)
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf script report: fix segfault when using DWARF mode
Date:   Thu,  2 Apr 2020 14:54:16 +0200
Message-Id: <20200402125417.422232-1-agerstmayr@redhat.com>
In-Reply-To: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running perf script report with a Python script and a callgraph in
DWARF mode, intr_regs->regs can be 0 and therefore crashing the regs_map
function.

Added a check for this condition (same check as in builtin-script.c:595).

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/too=
ls/perf/util/scripting-engines/trace-event-python.c
index 8c1b27cd8b99..2c372cf5495e 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -694,6 +694,9 @@ static int regs_map(struct regs_dump *regs, uint64_t =
mask, char *bf, int size)
=20
 	bf[0] =3D 0;
=20
+	if (!regs || !regs->regs)
+		return 0;
+
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val =3D regs->regs[i++];
=20
--=20
2.25.1

