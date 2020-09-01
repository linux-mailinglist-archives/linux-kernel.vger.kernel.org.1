Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D0F259F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 22:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgIAUHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 16:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727769AbgIAUHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598990823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1CxLnmGJqqQwzG3ckERhlxamk7+O3flzLRhZ5v81aO4=;
        b=ILhCOh9aEQCHhQLEC7wpSBVOFCfG8wvp/wAOrFe3sqNcEh7EZTm3r/TyqfEV2wA8qIZyBr
        unbARtSuNXWqzqPG760l4UiLLBlYoKEKVj9Y+IoeCSTzNNSsbodsbFlChZIBRahSvuPwea
        OdWdgQbqnl0Gz301Ned2xjcBmhuKtZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-nRhgquLhN-am3CHKbP2e5g-1; Tue, 01 Sep 2020 16:06:59 -0400
X-MC-Unique: nRhgquLhN-am3CHKbP2e5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9AD518A2249;
        Tue,  1 Sep 2020 20:06:57 +0000 (UTC)
Received: from krava (unknown [10.40.193.186])
        by smtp.corp.redhat.com (Postfix) with SMTP id E37725D9CC;
        Tue,  1 Sep 2020 20:06:55 +0000 (UTC)
Date:   Tue, 1 Sep 2020 22:06:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, mpetlan@redhat.com
Subject: Re: [PATCH V2 4/6] perf tools: Add FIFO file names as alternative
 options to --control
Message-ID: <20200901200655.GC470123@krava>
References: <20200901093758.32293-1-adrian.hunter@intel.com>
 <20200901093758.32293-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901093758.32293-5-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:37:56PM +0300, Adrian Hunter wrote:

SNIP

> +	fd = open(s, O_RDWR | O_NONBLOCK | O_CLOEXEC);
> +	if (fd < 0) {
> +		pr_err("Failed to open '%s'\n", s);
> +		ret = -errno;
> +		goto out_free;
> +	}
> +	*ctl_fd = fd;
> +	*ctl_fd_close = true;
> +
> +	if (p && *++p) {
> +		/* O_RDWR | O_NONBLOCK means the other end need not be open */
> +		fd = open(p, O_RDWR | O_NONBLOCK | O_CLOEXEC);
> +		if (fd < 0) {
> +			pr_err("Failed to open '%s'\n", p);
> +			ret = -errno;
> +			goto out_free;
> +		}
> +		*ctl_fd_ack = fd;
> +	}
> +
> +out_free:
> +	free(s);
> +	return ret;
> +}
> +
> +int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close)
>  {
>  	char *comma = NULL, *endptr = NULL;
>  
>  	if (strncmp(str, "fd:", 3))
> -		return -EINVAL;
> +		return evlist__parse_control_names(str, ctl_fd, ctl_fd_ack, ctl_fd_close);

could you please proactively set *ctl_fd_close = false in here,
so it's obvious.. also evlist__parse_control_fifo might be better
name, other that that it all looks great

we were recently asked to prvide faster intel_pt snapshot control
and we were thinking of putting input_pt support to libperf, but
your change might just fix this

for the patchset:

Acked-by: Jiri Olsa <jolsa@redhat.com>

Alexey, could you please check on this?

thanks,
jirka

>  
>  	*ctl_fd = strtoul(&str[3], &endptr, 0);
>  	if (endptr == &str[3])

SNIP

