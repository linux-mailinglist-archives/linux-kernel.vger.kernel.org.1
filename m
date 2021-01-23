Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB83018C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 23:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAWW6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 17:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbhAWW6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 17:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611442638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7DiM1PMMZUbKLzzyeuhp5mkrIQ9sFxziT9tgeKybWs=;
        b=SzpUti86M8YHc5fpcpsGoce1/w02rsdGCJftieGhUNOYwWBma+KmRTvALvuN5F0Qw3Ahjc
        tnKq8CkeTQQLUMCdoitNhGtHFerx0+n9Iz7ksDbZRaLggrM52LLotQrDip9Im4Z5UvTLqC
        ni90qyT7fk1coDdWzQjbnzsU2QkINhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-9Z_z7JqZNVKjAS6UbCS7GA-1; Sat, 23 Jan 2021 17:57:14 -0500
X-MC-Unique: 9Z_z7JqZNVKjAS6UbCS7GA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 936A0180A086;
        Sat, 23 Jan 2021 22:57:12 +0000 (UTC)
Received: from krava (unknown [10.40.192.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DA355D9CC;
        Sat, 23 Jan 2021 22:57:10 +0000 (UTC)
Date:   Sat, 23 Jan 2021 23:57:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
Subject: Re: [PATCH v7] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <20210123225709.GB138414@krava>
References: <20210118040521.31003-1-yao.jin@linux.intel.com>
 <20210120220735.GE1798087@krava>
 <dd75cc3f-9440-c33b-cea3-529134c33e80@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd75cc3f-9440-c33b-cea3-529134c33e80@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:21:36PM +0800, Jin, Yao wrote:

sNIP

> mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
> d = cpu_map__get_die(cpus, cpu, NULL).die;
> key = (size_t)d << KEY_SHIFT | s;	/* s is socket id */
> if (hashmap__find(mask, (void *)key, NULL))
> 	*skip = true;
> else
> 	ret = hashmap__add(mask, (void *)key, (void *)1);
> 
> If we use 'unsigned long' to replace 'size_t', it reports the build error for 32 bits:
> 
> stat.c:320:23: warning: passing argument 1 of ‘hashmap__new’ from
> incompatible pointer type [-Wincompatible-pointer-types]
>    mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
>                        ^~~~~~~~~~~
> In file included from stat.c:16:
> hashmap.h:75:17: note: expected ‘hashmap_hash_fn’ {aka ‘unsigned int
> (*)(const void *, void *)’} but argument is of type ‘long unsigned int
> (*)(const void *, void *)’
> 
> If we use "unsigned int", it's not good for 64 bits. So I still use 'size_t' in this patch.
> 
> Any comments for this idea (using conditional compilation)?

isn't it simpler to allocate the key then? like below
(just compile tested)

jirka


---
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 5aba8fa92386..195fda142c98 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -276,19 +276,31 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
 
 static void zero_per_pkg(struct evsel *counter)
 {
-	if (counter->per_pkg_mask)
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	if (counter->per_pkg_mask) {
+		hashmap__for_each_entry(counter->per_pkg_mask, cur, bkt)
+			free((char *)cur->key);
+
 		hashmap__clear(counter->per_pkg_mask);
+	}
 }
 
-static size_t pkg_id_hash(const void *key, void *ctx __maybe_unused)
+static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
 {
-	return (size_t)key & 0xffff;
+	uint64_t *key = (uint64_t*) __key;
+
+	return *key & 0xffffffff;
 }
 
-static bool pkg_id_equal(const void *key1, const void *key2,
+static bool pkg_id_equal(const void *__key1, const void *__key2,
 			 void *ctx __maybe_unused)
 {
-	return (size_t)key1 == (size_t)key2;
+	uint64_t *key1 = (uint64_t*) __key1;
+	uint64_t *key2 = (uint64_t*) __key2;
+
+	return *key1 == *key2;
 }
 
 static int check_per_pkg(struct evsel *counter,
@@ -297,7 +309,7 @@ static int check_per_pkg(struct evsel *counter,
 	struct hashmap *mask = counter->per_pkg_mask;
 	struct perf_cpu_map *cpus = evsel__cpus(counter);
 	int s, d, ret = 0;
-	size_t key;
+	uint64_t *key;
 
 	*skip = false;
 
@@ -338,7 +350,11 @@ static int check_per_pkg(struct evsel *counter,
 	if (d < 0)
 		return -1;
 
-	key = (size_t)d << 16 | s;
+	key = malloc(sizeof(*key));
+	if (!key)
+		return -ENOMEM;
+
+	*key = (size_t)d << 32 | s;
 	if (hashmap__find(mask, (void *)key, NULL))
 		*skip = true;
 	else

