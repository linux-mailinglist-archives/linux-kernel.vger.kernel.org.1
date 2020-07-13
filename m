Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6213621A262
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGIOp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:45:27 -0400
Received: from one.firstfloor.org ([193.170.194.197]:36222 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgGIOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:45:27 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id C9F5F86731; Thu,  9 Jul 2020 16:36:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1594305414;
        bh=NFHVOQuc740DsnU3hI4JnpmsluKHMe7JTI/h4WcX4yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxKpfZaR0f/XvTQvLBiUw9glLNQyIZoHiwSIQMsKSbL7iQYwANOkTAC1AJ/Xd+yf9
         tbSaJDdmto+SmTfAQE1xS8nHgMyp+AKZ3sHuC0JE9QIJCjtcK0soNeleJWv9WoXwFd
         gGQbA3CPGu3owN5v8RcgGEqAWD415NIJDNaVvWT8=
Date:   Thu, 9 Jul 2020 07:36:54 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4] perf-probe: Warn if the target function is GNU
 Indirect function
Message-ID: <20200709143654.pw2maoxivsjho6op@two.firstfloor.org>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
 <159428205174.56570.17588311835868886287.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159428205174.56570.17588311835868886287.stgit@devnote2>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 1e95a336862c..671176d39569 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -379,6 +379,11 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
>  			address = sym->start;
>  		else
>  			address = map->unmap_ip(map, sym->start) - map->reloc;
> +		if (sym->type == STT_GNU_IFUNC) {
> +			pr_warning("Warning: The probe address (0x%lx) is in a GNU indirect function.\n"
> +				"This may not work as you expected unless you intend to probe the indirect function.\n",

I would say something like this.

Consider identifying the final function used at run time and set the
probe directly on that.

I think that's more useful to the user.

-Andi
