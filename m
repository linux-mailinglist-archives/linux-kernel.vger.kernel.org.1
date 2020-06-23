Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EEF20556C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbgFWPDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 11:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732862AbgFWPDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:03:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288B120723;
        Tue, 23 Jun 2020 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592924628;
        bh=soLk9tHcyZMj32YGp0QZQRF8FQvz57n5ghu4cncgjPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThcJxpJHtMwx4ohRDXwXRlZjEiawns/3J+Frb7elkq760zVZ+T1l+IpRWyq6xcVhA
         GIsW/DAlOiki/tv17A5I7SYmAracDuGSJSbJ7DYx3ySRNhmeghbK0Os4r+h7RwGt23
         kJkbPgcAXIXF3UwYz23fY/V5thCpvI+99agWnDoA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6497C405FF; Tue, 23 Jun 2020 12:03:45 -0300 (-03)
Date:   Tue, 23 Jun 2020 12:03:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 03/13] perf evlist: implement control command handling
 functions
Message-ID: <20200623150345.GA26230@kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <d47ef616-e2cf-9131-159f-5be1a31438a7@linux.intel.com>
 <20200623145601.GH2619137@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623145601.GH2619137@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 23, 2020 at 04:56:01PM +0200, Jiri Olsa escreveu:
> On Wed, Jun 17, 2020 at 11:36:46AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
> > +	memset(cmd_data, 0, data_size--);
> > +
> > +	do {
> > +		err = read(evlist->ctl_fd.fd, &c, 1);
> > +		if (err > 0) {
> > +			if (c == '\n' || c == '\0')
> > +				break;
> > +			cmd_data[bytes_read++] = c;
> > +			if (bytes_read == data_size)
> > +				break;
> > +		} else {
> > +			if (err == -1)
> > +				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd.fd);
> > +			break;
> > +		}
> > +	} while (1);
> > +
> > +	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
> > +		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
> > +
> > +	if (err > 0) {
> > +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> > +			     strlen(EVLIST_CTL_CMD_ENABLE_TAG))) {
> 
> you could use sizeof(EVLIST_CTL_CMD_ENABLE_TAG) instead, no function call

-1, as sizeof will get the \0, right?

> 
> > +			*cmd = EVLIST_CTL_CMD_ENABLE;
> > +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> > +				    strlen(EVLIST_CTL_CMD_DISABLE_TAG))) {
> 
> ditto
> 
> jirka
> 

-- 

- Arnaldo
