Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D12B3970
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 22:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgKOVRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 16:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727957AbgKOVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 16:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605475043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjjXvcnfdqyDsGA40s5TOY3s1flYptQXXZm0oMtNmng=;
        b=ibmOKpVPRUU+85GuLRRAOzIsqidsK3rcHRBlAxiWKM8FATzYspGl5AC7MtHljIqns5UK8k
        os1KhO6DUiMCzIIPTlYanyUmadg2zlRSutsY50EtmoQN1CuSShB9H5QVKtMezot9F1qPPy
        Djok3TsHytPv8COLBo4m9gswfnegctE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-sONxaeU2MNm_s4vfIRJtwQ-1; Sun, 15 Nov 2020 16:17:20 -0500
X-MC-Unique: sONxaeU2MNm_s4vfIRJtwQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6AA81084D60;
        Sun, 15 Nov 2020 21:17:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id B257B60BFA;
        Sun, 15 Nov 2020 21:17:15 +0000 (UTC)
Date:   Sun, 15 Nov 2020 22:17:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 13/13 v4] perf tools: add thread field
Message-ID: <20201115211714.GA1081385@krava>
References: <20201113172654.989-1-james.clark@arm.com>
 <20201113172654.989-14-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113172654.989-14-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 07:26:54PM +0200, James Clark wrote:
> A separate field isn't strictly required. The core
> field could be re-used for thread IDs as a single
> field was used previously.
> 
> But separating them will avoid confusion and catch
> potential errors where core IDs are read as thread
> IDs and vice versa.
> 
> Also remove the placeholder id field which is now
> no longer used.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/tests/topology.c    |  8 ++++----
>  tools/perf/util/cpumap.c       | 14 +++++++-------
>  tools/perf/util/cpumap.h       |  2 +-
>  tools/perf/util/stat-display.c |  8 ++++----
>  4 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index 694f786a77f3..2276db0b1b6f 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -119,7 +119,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>  		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
>  			session->header.env.cpu[map->map[i]].die_id == id.die);
>  		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
> -		TEST_ASSERT_VAL("Core map - ID is set", id.id == -1);
> +		TEST_ASSERT_VAL("Core map - Thread is set", id.thread == -1);
>  	}
>  
>  	// Test that die ID contains socket and die
> @@ -131,7 +131,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>  		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
>  			session->header.env.cpu[map->map[i]].die_id == id.die);
>  		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
> -		TEST_ASSERT_VAL("Die map - ID is set", id.id == -1);
> +		TEST_ASSERT_VAL("Die map - Thread is set", id.thread == -1);
>  	}
>  
>  	// Test that socket ID contains only socket
> @@ -141,7 +141,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>  			session->header.env.cpu[map->map[i]].socket_id == id.socket);
>  		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
>  		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
> -		TEST_ASSERT_VAL("Socket map - ID is set", id.id == -1);
> +		TEST_ASSERT_VAL("Socket map - Thread is set", id.thread == -1);
>  	}
>  
>  	// Test that node ID contains only node
> @@ -149,7 +149,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>  		id = cpu_map__get_node(map, i, NULL);
>  		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
>  			cpu__get_node(map->map[i]) == id.node);
> -		TEST_ASSERT_VAL("Node map - ID shouldn't be set", id.id == -1);
> +		TEST_ASSERT_VAL("Node map - Thread shouldn't be set", id.thread == -1);
>  		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
>  	}

should we test all unset parts are -1, like here id.core,
id.socket and there are missing tests also in above code

jirka

