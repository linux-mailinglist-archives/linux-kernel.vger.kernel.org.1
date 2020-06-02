Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE41EBDA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFBOHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 10:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgFBOHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:07:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D13206E2;
        Tue,  2 Jun 2020 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591106826;
        bh=3TeniVPNuHVczMGCDWiwG04eRmSLOGv+9JLbaE+yQWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTNrV7RQRBK0rtWmlX13xaSXM0XeyRSAjqfS9V71QqLRbGGuZmEwO5T3E0pLoY9U2
         Uk6ndmDqFW67ABevzhzonZBvjRXcnktdtPGFTjV+XZiAAhoqqbgCL4Alnwex4w3VkA
         H1GfBpK+AWbW3c7qxPFMe4nqmwysudv3PO95xyp0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 68BD440AFD; Tue,  2 Jun 2020 11:07:03 -0300 (-03)
Date:   Tue, 2 Jun 2020 11:07:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix kernel maps for kcore and eBPF
Message-ID: <20200602140703.GP31795@kernel.org>
References: <20200602112505.1406-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602112505.1406-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 02, 2020 at 02:25:05PM +0300, Adrian Hunter escreveu:
> Adjust pgoff also when moving a map's start address.
> 
> Example with v5.4.34 based kernel:
> 
>   Before:
> 
>     $ sudo tools/perf/perf record -a --kcore -e intel_pt//k sleep 1
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 1.958 MB perf.data ]
>     $ sudo tools/perf/perf script --itrace=e >/dev/null
>     Warning:
>     961 instruction trace errors
> 
>   After:
> 
>     $ sudo tools/perf/perf script --itrace=e >/dev/null
>     $

Thanks, tested on a kaby lake system (i5-7500) and applied,

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: fb5a88d4131a ("perf tools: Preserve eBPF maps when loading kcore")
> Cc: stable@vger.kernel.org
> ---
>  tools/perf/util/symbol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 57cbe7a29868..5ddf84dcbae7 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1224,6 +1224,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
>  
>  				m->end = old_map->start;
>  				list_add_tail(&m->node, &merged);
> +				new_map->pgoff += old_map->end - new_map->start;
>  				new_map->start = old_map->end;
>  			}
>  		} else {
> @@ -1244,6 +1245,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
>  				 *      |new......| ->         |new...|
>  				 * |old....|        -> |old....|
>  				 */
> +				new_map->pgoff += old_map->end - new_map->start;
>  				new_map->start = old_map->end;
>  			}
>  		}
> -- 
> 2.17.1
> 

-- 

- Arnaldo
