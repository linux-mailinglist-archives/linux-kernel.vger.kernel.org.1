Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67402DD5EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgLQRTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:19:47 -0500
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:53342 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726548AbgLQRTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:19:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id ACD0252DD;
        Thu, 17 Dec 2020 17:19:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:1801:2198:2199:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3871:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:7903:7904:8550:8985:9025:10004:10848:11026:11232:11233:11473:11657:11658:11914:12043:12048:12296:12297:12438:12555:12740:12895:12986:13439:13894:14181:14659:14721:21080:21433:21627:21939:30054:30062:30070:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: watch24_440264927436
X-Filterd-Recvd-Size: 5311
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Dec 2020 17:19:04 +0000 (UTC)
Message-ID: <e28fe0a9dac014ab94bf059773b98ee4be8bd01b.camel@perches.com>
Subject: Re: [PATCH -next] tools: perf: convert comma to semicolon
From:   Joe Perches <joe@perches.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Cc:     Julia Lawall <julia.lawall@lip6.fr>
Date:   Thu, 17 Dec 2020 09:19:03 -0800
In-Reply-To: <20201216131526.14665-1-zhengyongjun3@huawei.com>
References: <20201216131526.14665-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-16 at 21:15 +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.

If you are going to submit patches for comma/semicolon conversions,
please to not use checkpatch to produce them.

checkpatch is a trivial tool that does not have very good coverage
of the possible uses of commas that would generally be written with
a semicolon.

Use the coccinelle script that Julia Lawall provided instead.

https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2008201856110.2524@hadrien/

This misses these 2 uses in tools/perf.

diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index 0f562e2cb1e8..ee549b07b9ae 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -190,7 +190,7 @@ void __ui__info_window(const char *title, const char *text,>
        nr_lines += 2;
        if (exit_msg)
                nr_lines += 2;
-       y = SLtt_Screen_Rows / 2 - nr_lines / 2,
+       y = SLtt_Screen_Rows / 2 - nr_lines / 2;
        x = SLtt_Screen_Cols / 2 - max_len / 2;
 
        SLsmg_set_color(0);

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1cad6051d8b0..76abb08f9e14 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -269,7 +269,7 @@ struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
 
        if (evsel__is_bpf_output(evsel)) {
                evsel->core.attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
-                                           PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
+                                           PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD);
                evsel->core.attr.sample_period = 1;
        }
 


> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  tools/perf/builtin-diff.c         | 4 ++--
>  tools/perf/builtin-inject.c       | 2 +-
>  tools/perf/ui/browsers/annotate.c | 2 +-
>  tools/perf/util/annotate.c        | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index cefc71506409..9064419b108f 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1912,8 +1912,8 @@ static int data_init(int argc, const char **argv)
>  		struct perf_data *data = &d->data;
>  
> 
>  		data->path  = use_default ? defaults[i] : argv[i];
> -		data->mode  = PERF_DATA_MODE_READ,
> -		data->force = force,
> +		data->mode  = PERF_DATA_MODE_READ;
> +		data->force = force;
>  
> 
>  		d->idx  = i;
>  	}
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 0462dc8db2e3..235a91a907fd 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -747,7 +747,7 @@ static int __cmd_inject(struct perf_inject *inject)
>  		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
>  		inject->tool.auxtrace	    = perf_event__process_auxtrace;
>  		inject->tool.aux	    = perf_event__drop_aux;
> -		inject->tool.itrace_start   = perf_event__drop_aux,
> +		inject->tool.itrace_start   = perf_event__drop_aux;
>  		inject->tool.ordered_events = true;
>  		inject->tool.ordering_requires_timestamps = true;
>  		/* Allow space in the header for new attributes */
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index bd77825fd5a1..3d857b1e0e62 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -928,7 +928,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>  
> 
>  	browser.b.width = notes->max_line_len;
>  	browser.b.nr_entries = notes->nr_entries;
> -	browser.b.entries = &notes->src->source,
> +	browser.b.entries = &notes->src->source;
>  	browser.b.width += 18; /* Percentage */
>  
> 
>  	if (notes->options->hide_src_code)
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 6c8575e182ed..3b4663f8229e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -367,7 +367,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>  	}
>  
> 
>  	target.addr = map__objdump_2mem(map, ops->target.addr);
> -	start = map->unmap_ip(map, sym->start),
> +	start = map->unmap_ip(map, sym->start);
>  	end = map->unmap_ip(map, sym->end);
>  
> 
>  	ops->target.outside = target.addr < start || target.addr > end;


