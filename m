Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16EF1C1181
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 13:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgEALbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 07:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728581AbgEALbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:31:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08DCC061A0C;
        Fri,  1 May 2020 04:31:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c63so8923101qke.2;
        Fri, 01 May 2020 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=QrVfd835frDxBh20QyfpO/jMZIK3W1Ih4ZfyiCrxIps=;
        b=ptsaSBTuG4PIIJXf8873WsgNcH69u2f6iFxAZ0RWQ+Ovb/BH6dWki02eiizj0FkrQT
         zToz8cF9iL/RP53o7DD7m849mhpY1lX880s0T0ujqmFvmzXyZllL2CBziyzFDeRkT25V
         SWx9ylgZV6ghXugrvWj6oeCM8S4bvKb+9CXS4MqxP5sl64piPry3J4H9kjsocWpszKwq
         JEYI/aevwrHZrLI++VrdR9Lw/hdqivHMghhyBqK7uMX2BBKUl7ArYMb8aTrZ2Xcv6uKo
         wO8EnU/HnYE/Z1Id6OSh2wO4zefmO90mVvjx0RcA+nVJ0Z6EcM/biFL8tkHNB7OR/bSg
         pWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=QrVfd835frDxBh20QyfpO/jMZIK3W1Ih4ZfyiCrxIps=;
        b=QPNB7um3RqjeGCYTBYY4YGqPIBdEu97JDqEY7jojyBZvlp2ADkh+vr1M9Nk4R/42MY
         C7c+UfeFMOQ7rLWSeFv43RN3seVFv3QJKqwOQVCzhozCQ42ziXo+4HZWXCPz9Pn3L7hH
         DYmweYUVCfzpEYRMiUG2SmgQtXshfmMaiZwQXazuh9XeJl0m2K7j3U1hsZel8vEKrNdA
         /teXAn06b1wnvEJYlgraZY8bEw4fFB+NDVuDHwUq5oTLLuxw2joMpjGlEKrrwzP0eI/G
         CigXcF8pkGYbiFY7q8XhKpOQr5nSSWUZeMxgsDEXqYnoJYe1DBJm2goVcJSx9kkOuPoh
         nIkg==
X-Gm-Message-State: AGi0PuZCM3Wr4AdzdtWjYFvhKOULsduhJANVEWuzSM9MKHTyFobINC7Y
        Pun4Bnz5bt7YNqn07lqG9js=
X-Google-Smtp-Source: APiQypJOHkAaL2hQAUkQevJotyRHxM5KKRsl1xXUTIzRySRp5Y92Ndrvc7a21eaJa/6naOEGg7Zv3Q==
X-Received: by 2002:a05:620a:5f7:: with SMTP id z23mr2838230qkg.76.1588332706842;
        Fri, 01 May 2020 04:31:46 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g3sm2457928qkk.24.2020.05.01.04.31.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 04:31:46 -0700 (PDT)
Date:   Fri, 01 May 2020 08:31:16 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200501112552.GC1789042@krava>
References: <20200429131106.27974-1-acme@kernel.org> <20200429131106.27974-6-acme@kernel.org> <20200501112552.GC1789042@krava>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/8] perf evlist: Allow reusing the side band thread for more purposes
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <C4CDADE1-82F4-4033-A9C7-F411C2D7DC28@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 1, 2020 8:25:52 AM GMT-03:00, Jiri Olsa <jolsa@redhat=2Ecom> wrote:
>On Wed, Apr 29, 2020 at 10:11:03AM -0300, Arnaldo Carvalho de Melo
>wrote:
>> From: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>>=20
>> I=2Ee=2E so far we had just one event in that side band thread, a dummy
>one
>> with attr=2Ebpf_event set, so that 'perf record' can go ahead and ask
>the
>> kernel for further information about BPF programs being loaded=2E
>>=20
>> Allow for more than one event to be there, so that we can use it as
>> well for the upcoming --switch-output-event feature=2E
>>=20
>> Cc: Adrian Hunter <adrian=2Ehunter@intel=2Ecom>
>> Cc: Jiri Olsa <jolsa@kernel=2Eorg>
>> Cc: Namhyung Kim <namhyung@kernel=2Eorg>
>> Cc: Song Liu <songliubraving@fb=2Ecom>
>> Link:
>http://lore=2Ekernel=2Eorg/lkml/20200427211935=2E25789-7-acme@kernel=2Eor=
g
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>> ---
>>  tools/perf/util/evlist=2Ec | 22 ++++++++++++++++++++++
>>  tools/perf/util/evlist=2Eh |  1 +
>>  2 files changed, 23 insertions(+)
>>=20
>> diff --git a/tools/perf/util/evlist=2Ec b/tools/perf/util/evlist=2Ec
>> index 1d0d36da223b=2E=2E849058766757 100644
>> --- a/tools/perf/util/evlist=2Ec
>> +++ b/tools/perf/util/evlist=2Ec
>> @@ -1777,6 +1777,19 @@ static void *perf_evlist__poll_thread(void
>*arg)
>>  	return NULL;
>>  }
>> =20
>> +void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb,
>void *data)
>> +{
>> +	struct evsel *evsel;
>> +
>> +	evlist__for_each_entry(evlist, evsel) {
>> +		evsel->core=2Eattr=2Esample_id_all	  =3D 1;
>> +		evsel->core=2Eattr=2Ewatermark	  =3D 1;
>> +		evsel->core=2Eattr=2Ewakeup_watermark =3D 1;
>> +		evsel->side_band=2Ecb   =3D cb;
>> +		evsel->side_band=2Edata =3D data;
>> +	}
>> +}
>> +
>>  int perf_evlist__start_sb_thread(struct evlist *evlist,
>>  				 struct target *target)
>>  {
>> @@ -1788,6 +1801,15 @@ int perf_evlist__start_sb_thread(struct evlist
>*evlist,
>>  	if (perf_evlist__create_maps(evlist, target))
>>  		goto out_delete_evlist;
>> =20
>> +	if (evlist->core=2Enr_entries > 1) {
>> +		bool can_sample_identifier =3D perf_can_sample_identifier();
>
>I just found this breaks python, because perf_can_sample_identifier
>is defined in util/record=2Ec

Yeah, I noticed it too, will fix

>
>	19: 'import perf' in python                               :
>	--- start ---
>	test child forked, pid 1808205
>	Traceback (most recent call last):
>	  File "<stdin>", line 1, in <module>
>	ImportError: python/perf=2Eso: undefined symbol:
>perf_can_sample_identifier
>	test child finished with -1
>	---- end ----
>	'import perf' in python: FAILED!
>
>jirka

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
