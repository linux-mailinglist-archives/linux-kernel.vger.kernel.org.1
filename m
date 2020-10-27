Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5A29ACDB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbgJ0NJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436566AbgJ0NJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603804179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RtUlitQmXGKpWNcQ5pKnpPfyfbTOxQ4pHL/14AjBTF4=;
        b=ckXnF15tUuxSufxAhcb8c2sW5Wo004s52HI4T5YnqGQCQxvurbEwnfI4sRFvoNmY2nolM1
        +fy+CXVBzmpPKzV/Q7lzFXcmXE2HDhk+pYkMGYXc+avgQgLkv0sO73p9hY2s2bAYA3T8ab
        R11yTSTzrrBXINx2FurMQicYtSWAupo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-Yyd6xnngPNC50Aw5Jy943g-1; Tue, 27 Oct 2020 09:09:37 -0400
X-MC-Unique: Yyd6xnngPNC50Aw5Jy943g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F416B8049D8;
        Tue, 27 Oct 2020 13:09:34 +0000 (UTC)
Received: from krava (unknown [10.40.195.208])
        by smtp.corp.redhat.com (Postfix) with SMTP id 82F4B5C1BB;
        Tue, 27 Oct 2020 13:09:33 +0000 (UTC)
Date:   Tue, 27 Oct 2020 14:09:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        alexey.budankov@linux.intel.com, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] perf tools: Support -x for perf stat report
Message-ID: <20201027130932.GG2900849@krava>
References: <20201027002737.30942-1-andi@firstfloor.org>
 <20201027002737.30942-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027002737.30942-2-andi@firstfloor.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:27:37PM -0700, Andi Kleen wrote:
> Add support for the -x, option to enable CSV output with perf stat
> report. Useful to parse the information with other programs.
> 
> % perf stat record --quiet -a -I 1000 sleep 5
> % perf stat report -x,
>      1.000838672,4003.55,msec,cpu-clock,4003548736,100.00,,
>      1.000838672,11243,,context-switches,4003631885,100.00,0.003,M/sec
>      1.000838672,1682,,cpu-migrations,4003672150,100.00,0.420,K/sec
>      1.000838672,13244,,page-faults,4003697471,100.00,0.003,M/sec
>      1.000838672,2953214077,,cycles,4003715495,100.00,0.738,GHz
>      1.000838672,4380820799,,instructions,4003738270,100.00,1.48,insn per cycle
>      1.000838672,809865653,,branches,4003760616,100.00,202.287,M/sec
>      1.000838672,12439843,,branch-misses,4003780785,100.00,1.54,of all branches
> ...
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 743fe47e7a88..31e7bd877f1d 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1988,6 +1988,8 @@ static int __cmd_report(int argc, const char **argv)
>  		     "aggregate counts per numa node", AGGR_NODE),
>  	OPT_SET_UINT('A', "no-aggr", &perf_stat.aggr_mode,
>  		     "disable CPU count aggregation", AGGR_NONE),
> +	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
> +		   "print counts with custom separator"),
>  	OPT_END()
>  	};
>  	struct stat st;
> @@ -2002,6 +2004,11 @@ static int __cmd_report(int argc, const char **argv)
>  			input_name = "perf.data";
>  	}
>  
> +	if (stat_config.csv_sep) {
> +		stat_config.csv_output = true;
> +		stat_config.big_num = false;
> +	}

stat_config.csv_sep is by default ' ' so this will force
the standard output to be with -x

jirka

> +
>  	perf_stat.data.path = input_name;
>  	perf_stat.data.mode = PERF_DATA_MODE_READ;
>  
> -- 
> 2.28.0
> 

