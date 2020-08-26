Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C632252BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 13:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHZLBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 07:01:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48461 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728813AbgHZK5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598439442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SCIE1nJRwsLpxlJGlMba1GQ2dcdVa5UOGyWvkgH6jso=;
        b=WkAub870SJ8iX3pKIy+nsugnrdLFweKWw5XjAEmCJdyJ6I1iOsuJyxJUSXL2Bttt6k/urU
        WaTQg/Nan+ausprQA+AcDyx4JbP+KLt+GIgNQqgFG9q4alXoLajVN2pjs01/NDcoJkLyws
        0Yo+Il9j8o6X05OwXWbhMz1oauE9dtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-x39uYmfYPcKYDCPC125n6g-1; Wed, 26 Aug 2020 06:57:17 -0400
X-MC-Unique: x39uYmfYPcKYDCPC125n6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F6CC189E602;
        Wed, 26 Aug 2020 10:57:16 +0000 (UTC)
Received: from krava (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id B96F11972A;
        Wed, 26 Aug 2020 10:57:13 +0000 (UTC)
Date:   Wed, 26 Aug 2020 12:57:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Message-ID: <20200826105712.GE703542@krava>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825074041.378520-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:

SNIP

>  	}
>  }
>  
> -static int save_arch_std_events(void *data, char *name, char *event,
> -				char *desc, char *long_desc, char *pmu,
> -				char *unit, char *perpkg, char *metric_expr,
> -				char *metric_name, char *metric_group,
> -				char *deprecated, char *metric_constraint)
> +static int save_arch_std_events(void *data, struct json_event *je)
>  {
>  	struct event_struct *es;
>  
> @@ -485,11 +476,8 @@ static char *real_event(const char *name, char *event)
>  }
>  
>  static int
> -try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> -	  char **name, char **long_desc, char **pmu, char **filter,
> -	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
> -	  char **metric_group, unsigned long long eventcode,
> -	  char **deprecated, char **metric_constraint)
> +try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
> +	  struct json_event *je)
>  {
>  	/* try to find matching event from arch standard values */
>  	struct event_struct *es;
> @@ -498,8 +486,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>  		if (!strcmp(arch_std, es->name)) {
>  			if (!eventcode && es->event) {
>  				/* allow EventCode to be overridden */
> -				free(*event);
> -				*event = NULL;
> +				je->event = NULL;

should you free je->event in here?

jirka

