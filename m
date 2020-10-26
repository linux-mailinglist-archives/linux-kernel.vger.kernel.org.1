Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D582988CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772278AbgJZIyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:54:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35945 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772271AbgJZIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:54:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id h6so10704470lfj.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oc9dTdhucISYbXveQ3zQvg8nChQDd969gjMkRh0Lt2k=;
        b=CgI2FU+dy26y1KkTzCyrbyRg68N/YAkfUNMEAjio63rO3IthrFNWUD/aB76N59oTUy
         K6KR6fOvFEPjNR3SJArwMjacHKkxzJ7ozU8vcLDO/rYn43vKA3PSylLBoySD166lr526
         ZbpIaCvHeyD+tKPW81sbkQmcXqJO+UodJJj+99rer7r/qoy6xjgTvF5R3sLug9C/oNsu
         4vnFLC7RtN/f3iafqCgrSmOxN6NRhombkNB71zRHZ6sRbpc9K/bcyPXPmRnwvdmFwAoh
         OFVNhhA7IyWFol/28YTFyrAiFQ3ynba+2LNVgjx7P7lz2Jgcs4iGA2r+wv6RRcLFf30G
         ExMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oc9dTdhucISYbXveQ3zQvg8nChQDd969gjMkRh0Lt2k=;
        b=WEj+bSZDZlO5TIOFaibyTf9PzB+bgDtjHcLQ6EY9PYX/huDagIG+3UUvz/Bosenvwr
         j4dyikKs3Xf05+nzjwpvk9wFSkP+Dfac4ol2Fo+FBCO0+vxQBdYFzAoNBv+4chSJPlIb
         YZZgePOUVW7NomqtNmrUGWC6MO4By2/G862VaDNaq+Uo+KccWi+fzsLJjmYw2AUrJLOM
         eCJbOA5prQZb0lO/GbfcgErWAF7YntyE7mVnNauVaemAynnLDNn+PEN87MJT+nfpCdjo
         Oi0lW3WiGRxSng13hRk3ydG/qLoACJb7Ln3kBRu4Oz0u6QMejCy4kLyhIybs6xN1Yobx
         Griw==
X-Gm-Message-State: AOAM532dwduMMpnZic6asZP14uyIiET9a8sj5hnAhHdGrmtjegnJNJBB
        we+Kfq7bMOuqKbovvU+njcGwX76rPTnyPA==
X-Google-Smtp-Source: ABdhPJxEzXLstjotqX7zYJ9zYzYTqPtrBTFg24Vwq7Pxs2Nmv9jjeA8qBx+V9mjfKjL8wB/VrscV5Q==
X-Received: by 2002:a19:8607:: with SMTP id i7mr4460797lfd.281.1603702448460;
        Mon, 26 Oct 2020 01:54:08 -0700 (PDT)
Received: from [192.168.0.10] (89-109-58-109.dynamic.mts-nn.ru. [89.109.58.109])
        by smtp.gmail.com with ESMTPSA id o23sm1109902lji.68.2020.10.26.01.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 01:54:07 -0700 (PDT)
Subject: Re: [PATCH v2 05/15] perf session: introduce decompressor into trace
 reader object
To:     Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <b3c73389-7b4c-89cd-423c-68b00fcc61c9@linux.intel.com>
 <20201024154438.GI2589351@krava>
From:   Alexei Budankov <budankov.lore@gmail.com>
Organization: Intel Corp.
Message-ID: <6f760b28-f4bd-9de4-fadb-1ee79b4fc33b@gmail.com>
Date:   Mon, 26 Oct 2020 11:54:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201024154438.GI2589351@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.10.2020 18:44, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 07:00:30PM +0300, Alexey Budankov wrote:
>>
>> Introduce decompressor to trace reader object so that decompression
>> could be executed on per trace file basis separately for every
>> trace file located in trace directory.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/session.c | 4 +++-
>>  tools/perf/util/session.h | 1 +
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 911b2dbcd0ac..6afc670fdf0c 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -44,6 +44,8 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>>  	u64 decomp_last_rem = 0;
>>  	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
>>  	struct decomp *decomp, *decomp_last = session->decomp_last;
>> +	struct zstd_data *zstd_data = session->reader ?
>> +		&(session->reader->zstd_data) : &(session->zstd_data);
> 
> I don't think we're using braces in these cases, they are not necessary

Corrected in v3.

Thanks,
Alexei

> 
> jirka
> 
>>  
>>  	if (decomp_last) {
>>  		decomp_last_rem = decomp_last->size - decomp_last->head;
>> @@ -71,7 +73,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>>  	src = (void *)event + sizeof(struct perf_record_compressed);
>>  	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
>>  
>> -	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
>> +	decomp_size = zstd_decompress_stream(zstd_data, src, src_size,
>>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
>>  	if (!decomp_size) {
>>  		munmap(decomp, mmap_len);
>> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
>> index abdb8518a81f..4fc9ccdf7970 100644
>> --- a/tools/perf/util/session.h
>> +++ b/tools/perf/util/session.h
>> @@ -42,6 +42,7 @@ struct reader {
>>  	u64		 data_size;
>>  	u64		 data_offset;
>>  	reader_cb_t	 process;
>> +	struct zstd_data zstd_data;
>>  };
>>  
>>  struct perf_session {
>> -- 
>> 2.24.1
>>
>>
> 
