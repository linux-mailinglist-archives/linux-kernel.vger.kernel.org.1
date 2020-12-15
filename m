Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593902DB459
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbgLOTN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:13:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731286AbgLOTNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608059493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDxaVLnu+Ra7ZR1VIVx9OBXM3C80P+ELcOBEFimcNF8=;
        b=EEGQ6hviHHCZkvnq8IJ+rtwZb4nK+QK5bUvijDNfBj/AtuusCNfVm7y+8TzLAGce5QOtcD
        H3/fB/NfjDRpL8AOpG9GVWEsNwMwO5n77Vws03lJ/izwNFP6km8Oww9XPEMn3zrQ0gs9kF
        0d+oYLsJwwovbBPO+uTa5ZdZT/q3ogY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-n72XWx6kORCPNukNjzC2vA-1; Tue, 15 Dec 2020 14:11:29 -0500
X-MC-Unique: n72XWx6kORCPNukNjzC2vA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6BC410054FF;
        Tue, 15 Dec 2020 19:11:27 +0000 (UTC)
Received: from krava (ovpn-112-106.ams2.redhat.com [10.36.112.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2D49719C47;
        Tue, 15 Dec 2020 19:11:24 +0000 (UTC)
Date:   Tue, 15 Dec 2020 20:11:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 3/8] perf tools: Add config set interface
Message-ID: <20201215191124.GD698181@krava>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-4-jolsa@kernel.org>
 <20201215154118.GD258566@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215154118.GD258566@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 12:41:18PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Dec 12, 2020 at 11:43:53AM +0100, Jiri Olsa escreveu:
> > Add interface to load config set from custom file
> > by using perf_config_set__new_file function.
> > 
> > It will be used in perf daemon command to process
> > custom config file.
> 
> The naming may be misleading, as this is not _setting_ the perf config
> to be that one, but to apply a set of changes to whatever is the current
> configuration, right?
> 
> Perhaps 'perf_config_set__load_file()'

yep, it's actually loading, will change

thanks,
jirka

> 
> There is value in _resetting_ the config to some configuration, i.e.
> moving everything to the strict defaults and then loading a file that
> sets the configuration to a state similar to what perf does when it
> first starts.
> 
> - Arnaldo
>  
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/config.c | 28 +++++++++++++++++++++++-----
> >  tools/perf/util/config.h |  3 +++
> >  2 files changed, 26 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> > index 6969f82843ee..dc3f03f8bbf5 100644
> > --- a/tools/perf/util/config.c
> > +++ b/tools/perf/util/config.c
> > @@ -738,6 +738,18 @@ struct perf_config_set *perf_config_set__new(void)
> >  	return set;
> >  }
> >  
> > +struct perf_config_set *perf_config_set__new_file(const char *file)
> > +{
> > +	struct perf_config_set *set = zalloc(sizeof(*set));
> > +
> > +	if (set) {
> > +		INIT_LIST_HEAD(&set->sections);
> > +		perf_config_from_file(collect_config, file, set);
> > +	}
> > +
> > +	return set;
> > +}
> > +
> >  static int perf_config__init(void)
> >  {
> >  	if (config_set == NULL)
> > @@ -746,17 +758,15 @@ static int perf_config__init(void)
> >  	return config_set == NULL;
> >  }
> >  
> > -int perf_config(config_fn_t fn, void *data)
> > +int perf_config_set(struct perf_config_set *set,
> > +		    config_fn_t fn, void *data)
> >  {
> >  	int ret = 0;
> >  	char key[BUFSIZ];
> >  	struct perf_config_section *section;
> >  	struct perf_config_item *item;
> >  
> > -	if (config_set == NULL && perf_config__init())
> > -		return -1;
> > -
> > -	perf_config_set__for_each_entry(config_set, section, item) {
> > +	perf_config_set__for_each_entry(set, section, item) {
> >  		char *value = item->value;
> >  
> >  		if (value) {
> > @@ -778,6 +788,14 @@ int perf_config(config_fn_t fn, void *data)
> >  	return ret;
> >  }
> >  
> > +int perf_config(config_fn_t fn, void *data)
> > +{
> > +	if (config_set == NULL && perf_config__init())
> > +		return -1;
> > +
> > +	return perf_config_set(config_set, fn, data);
> > +}
> > +
> >  void perf_config__exit(void)
> >  {
> >  	perf_config_set__delete(config_set);
> > diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
> > index 8c881e3a3ec3..f58b457e7e5f 100644
> > --- a/tools/perf/util/config.h
> > +++ b/tools/perf/util/config.h
> > @@ -30,6 +30,8 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
> >  int perf_config_from_file(config_fn_t fn, const char *filename, void *data);
> >  int perf_default_config(const char *, const char *, void *);
> >  int perf_config(config_fn_t fn, void *);
> > +int perf_config_set(struct perf_config_set *set,
> > +		    config_fn_t fn, void *data);
> >  int perf_config_int(int *dest, const char *, const char *);
> >  int perf_config_u8(u8 *dest, const char *name, const char *value);
> >  int perf_config_u64(u64 *dest, const char *, const char *);
> > @@ -38,6 +40,7 @@ int config_error_nonbool(const char *);
> >  const char *perf_etc_perfconfig(void);
> >  
> >  struct perf_config_set *perf_config_set__new(void);
> > +struct perf_config_set *perf_config_set__new_file(const char *file);
> >  void perf_config_set__delete(struct perf_config_set *set);
> >  int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
> >  			     const char *var, const char *value);
> > -- 
> > 2.26.2
> > 
> 
> -- 
> 
> - Arnaldo
> 

