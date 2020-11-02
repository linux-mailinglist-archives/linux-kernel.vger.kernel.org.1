Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A882A309D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbgKBQ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:56:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727151AbgKBQ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604336195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W7NXg4BXSiD7WI3H6W3VnxJUj/YW9lut3Rr6jG2n1TA=;
        b=CDb8vJvLmp3qVyV2HKKbsb8yYpgavq8+6JbiK9+A7liplPCw364ICAIMe4aOgsESg0BgEI
        9YDTb5GPGYPE9KccWKBdHXMxxTGhJd9QVnQYsxsTx8S/LwFy9fgiY8mdXRIYCgOp4q9lt0
        9CBhhyrYQcfbekD8fiGnQBPWafaZTYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-_KVwGundNmedsBtLyYmpHg-1; Mon, 02 Nov 2020 11:56:33 -0500
X-MC-Unique: _KVwGundNmedsBtLyYmpHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35DBF10866A2;
        Mon,  2 Nov 2020 16:56:31 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2900B5B4D6;
        Mon,  2 Nov 2020 16:56:26 +0000 (UTC)
Date:   Mon, 2 Nov 2020 17:56:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf lock: Don't free "lock_seq_stat" if
 read_count isn't zero
Message-ID: <20201102165626.GD3405508@krava>
References: <20201021003948.28817-1-leo.yan@linaro.org>
 <20201021003948.28817-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021003948.28817-2-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 08:39:48AM +0800, Leo Yan wrote:
> When execute command "perf lock report", it hits failure and outputs log
> as follows:
> 
>   perf: builtin-lock.c:623: report_lock_release_event: Assertion `!(seq->read_count < 0)' failed.
>   Aborted
> 
> This is an imbalance issue.  The locking sequence structure
> "lock_seq_stat" contains the reader counter and it is used to check if
> the locking sequence is balance or not between acquiring and releasing.
> 
> If the tool wrongly frees "lock_seq_stat" when "read_count" isn't zero,
> the "read_count" will be reset to zero when allocate a new structure at
> the next time; thus it causes the wrong counting for reader and finally
> results in imbalance issue.
> 
> To fix this issue, if detects "read_count" is not zero (means still
> have read user in the locking sequence), goto the "end" tag to skip
> freeing structure "lock_seq_stat".
> 
> Fixes: e4cef1f65061 ("perf lock: Fix state machine to recognize lock sequence")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 5cecc1ad78e1..a2f1e53f37a7 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -621,7 +621,7 @@ static int report_lock_release_event(struct evsel *evsel,
>  	case SEQ_STATE_READ_ACQUIRED:
>  		seq->read_count--;
>  		BUG_ON(seq->read_count < 0);
> -		if (!seq->read_count) {
> +		if (seq->read_count) {
>  			ls->nr_release++;

it seems ok, but I fail to see what's nr_release for
the point is just to skip the removal of seq right?

jirka

>  			goto end;
>  		}
> -- 
> 2.17.1
> 

