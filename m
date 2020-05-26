Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC31D4681
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 08:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgEOG5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726695AbgEOG4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:56:37 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF9C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:56:36 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id n36so1618870qvg.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=BlBgjK5xziAM5vwiVDuTtOoE4PbK5TxWadJH4JBlKYM=;
        b=EZrZEXW7Viyk80Bux2NOOgwyk1D6bHXWVb/zlJ7c5MJdmc/2B55H2QFyMiG/6Jh3oe
         5RwV0XnzkKjqLyJ4L1WTK03fYm0P4+W+zxkf5AbSvcWZdZoSbjUzSBroTZx8DEmMszcy
         2V/caUMHX3fCDFKQWYvT+Q3i4j+VCljdEk41+w+qTQCMTbvXUAx43MobqI3DrMcNWeu4
         bCszGbUeYdunqPsjaHsNJQXJwg39Lzr4M2imLnC5Tza+41rvDHVzTqB4rlMjoI11c9Uz
         6zkfdg1u6D5ocppBaDpCnunArW32oHIUfartVuiUILVUWdgbSjz4M+TTCSI0AcY0XXG1
         fd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=BlBgjK5xziAM5vwiVDuTtOoE4PbK5TxWadJH4JBlKYM=;
        b=KUEHHmqZFzOJLuo37q+baBGfTDpVLtvSrWVy86j64ckhagk0pVOgnp+PPbtq33DjvC
         ldMQvBl7RuF/2RN5F3VQhrR372Q938ZHW1Zu2CpA8EnNnOx8R+xDbxOYadMKFteaKuw3
         oip+rZpNeQIRfP9mAIgicpdjzz/D1iBsIhu3b6fPbGu7LZkAfxxtPHALLKYeN0YNyghP
         QOYDB7koyHQhg3yZC3+D8ELeDUVFLaN1nuMYVSB2mMkqj622Iqv75clYsXbQq+pXOIQ/
         UyApYzlKleqXh36kz/YBqoog5PJJFQY0GsxUREfb0Yg2CcuMt/Oewc2WBSfN1PGl424A
         H1+w==
X-Gm-Message-State: AOAM533pt6ptlDbliZ8CdXQvluSIaLxL5k1yj6ldXLt58j6AQJ4CPall
        QnmB/dHDp6VZ39ZG34BCEaZVNkjc+aIU
X-Google-Smtp-Source: ABdhPJz8XtegKSh8yOMx1iWS4vUX0ml1o219kpFcONA39sezAoXcY+JdpGmDcGCC+GD5zV3AYR4TQQRMVetq
X-Received: by 2002:a0c:8262:: with SMTP id h89mr1968365qva.173.1589525796081;
 Thu, 14 May 2020 23:56:36 -0700 (PDT)
Date:   Thu, 14 May 2020 23:56:19 -0700
In-Reply-To: <20200515065624.21658-1-irogers@google.com>
Message-Id: <20200515065624.21658-4-irogers@google.com>
Mime-Version: 1.0
References: <20200515065624.21658-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 3/8] libbpf hashmap: Fix signedness warnings
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings:

hashmap.c: In function =E2=80=98hashmap__clear=E2=80=99:
hashmap.h:150:20: error: comparison of integer expressions of different sig=
nedness: =E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99 {aka =E2=80=98l=
ong unsigned int=E2=80=99} [-Werror=3Dsign-compare]
  150 |  for (bkt =3D 0; bkt < map->cap; bkt++)        \

hashmap.c: In function =E2=80=98hashmap_grow=E2=80=99:
hashmap.h:150:20: error: comparison of integer expressions of different sig=
nedness: =E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99 {aka =E2=80=98l=
ong unsigned int=E2=80=99} [-Werror=3Dsign-compare]
  150 |  for (bkt =3D 0; bkt < map->cap; bkt++)        \

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index cffb96202e0d..a405dad068f5 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -60,7 +60,7 @@ struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
 void hashmap__clear(struct hashmap *map)
 {
 	struct hashmap_entry *cur, *tmp;
-	int bkt;
+	size_t bkt;
=20
 	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
 		free(cur);
@@ -100,8 +100,7 @@ static int hashmap_grow(struct hashmap *map)
 	struct hashmap_entry **new_buckets;
 	struct hashmap_entry *cur, *tmp;
 	size_t new_cap_bits, new_cap;
-	size_t h;
-	int bkt;
+	size_t h, bkt;
=20
 	new_cap_bits =3D map->cap_bits + 1;
 	if (new_cap_bits < HASHMAP_MIN_CAP_BITS)
--=20
2.26.2.761.g0e0b3e54be-goog

