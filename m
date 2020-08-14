Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832562449EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHNMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 08:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgHNMnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:43:11 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC3620866;
        Fri, 14 Aug 2020 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408990;
        bh=A15ka8oMq2tZNOzp8sNUlHRJBUUle/4DCF7Vee6VFYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yUGORTNZyBjtq3BdF/jOd+wDhj9lRwFyydO5uERf5ugSqFVZxxLXEhCmSwxp1mEmI
         99x9AeK+JbevowMyv698vcBFXyQtcN9a5Qzb/7AwOFmQhd7ZoHBy78z4UnlQe4xKy/
         MK72+LbSt+WGO6oH6o+9MQMOXHhOpGZo/iRIxClQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D7D3840D3D; Fri, 14 Aug 2020 09:43:07 -0300 (-03)
Date:   Fri, 14 Aug 2020 09:43:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Ian Rogers <irogers@google.com>, "Paul A. Clarke" <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, maddy@linux.ibm.com
Subject: Re: [PATCH] perf stat: update POWER9 metrics to utilize other metrics
Message-ID: <20200814124307.GF13995@kernel.org>
References: <20200813222155.268183-1-pc@us.ibm.com>
 <CAP-5=fU4P7o1TwVz+PzcrJsBKnrHW4yrNx3R165i9d3BwgP2RQ@mail.gmail.com>
 <cfa27e83-ac2c-7495-b453-ceeaf2412311@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfa27e83-ac2c-7495-b453-ceeaf2412311@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 14, 2020 at 11:20:42AM +0530, kajoljain escreveu:
> 
> 
> On 8/14/20 9:13 AM, Ian Rogers wrote:
> > On Thu, Aug 13, 2020 at 3:21 PM Paul A. Clarke <pc@us.ibm.com> wrote:
> >>
> >> These changes take advantage of the new capability added in
> >> merge commit 00e4db51259a5f936fec1424b884f029479d3981
> >> "Allow using computed metrics in calculating other metrics".
> >>
> >> The net is a simplification of the expressions for a handful
> >> of metrics, but no functional change.
> >>
> >> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > 
> 
> Hi Paul,
>   The patch looks good to me.
> 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks, applied. Added Ian's Acked-by as well.

- Arnaldo
 
> Thanks,
> Kajol Jain
> 
> > Acked-by: Ian Rogers <irogers@google.com>
> > (Re-sent with plain text enabled to avoid lkml bounce)
> > 
> > Thanks,
> > Ian
> > 
> > 
> >>
> >> ---
> >>  .../arch/powerpc/power9/metrics.json          | 48 +++++++++----------
> >>  1 file changed, 24 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> >> index 80816d6402e9..f8784c608479 100644
> >> --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> >> +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> >> @@ -60,7 +60,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Stalls due to short latency decimal floating ops.",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_DFU - PM_CMPLU_STALL_DFLONG)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "dfu_stall_cpi - dflong_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "dfu_other_stall_cpi"
> >>      },
> >> @@ -72,7 +72,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Completion stall by Dcache miss which resolved off node memory/cache",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STALL_DMISS_L21_L31 - PM_CMPLU_STALL_DMISS_LMEM - PM_CMPLU_STALL_DMISS_REMOTE)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "dmiss_non_local_stall_cpi - dmiss_remote_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "dmiss_distant_stall_cpi"
> >>      },
> >> @@ -90,7 +90,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Completion stall due to cache miss that resolves in the L2 or L3 without conflict",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L2L3 - PM_CMPLU_STALL_DMISS_L2L3_CONFLICT)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "dmiss_l2l3_stall_cpi - dmiss_l2l3_conflict_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "dmiss_l2l3_noconflict_stall_cpi"
> >>      },
> >> @@ -114,7 +114,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Completion stall by Dcache miss which resolved outside of local memory",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STALL_DMISS_L21_L31 - PM_CMPLU_STALL_DMISS_LMEM)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "dmiss_l3miss_stall_cpi - dmiss_l21_l31_stall_cpi - dmiss_lmem_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "dmiss_non_local_stall_cpi"
> >>      },
> >> @@ -126,7 +126,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Stalls due to short latency double precision ops.",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_DP - PM_CMPLU_STALL_DPLONG)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "dp_stall_cpi - dplong_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "dp_other_stall_cpi"
> >>      },
> >> @@ -155,7 +155,7 @@
> >>          "MetricName": "emq_full_stall_cpi"
> >>      },
> >>      {
> >> -        "MetricExpr": "(PM_CMPLU_STALL_ERAT_MISS + PM_CMPLU_STALL_EMQ_FULL)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "erat_miss_stall_cpi + emq_full_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "emq_stall_cpi"
> >>      },
> >> @@ -173,7 +173,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Completion stall due to execution units for other reasons.",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_FXU - PM_CMPLU_STALL_DP - PM_CMPLU_STALL_DFU - PM_CMPLU_STALL_PM - PM_CMPLU_STALL_CRYPTO - PM_CMPLU_STALL_VFXU - PM_CMPLU_STALL_VDP)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "exec_unit_stall_cpi - scalar_stall_cpi - vector_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "exec_unit_other_stall_cpi"
> >>      },
> >> @@ -197,7 +197,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Stalls due to short latency integer ops",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_FXU - PM_CMPLU_STALL_FXLONG)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "fxu_stall_cpi - fxlong_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "fxu_other_stall_cpi"
> >>      },
> >> @@ -221,7 +221,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Instruction Completion Table other stalls",
> >> -        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "nothing_dispatched_cpi - ict_noslot_ic_miss_cpi - ict_noslot_br_mpred_icmiss_cpi - ict_noslot_br_mpred_cpi - ict_noslot_disp_held_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "ict_noslot_cyc_other_cpi"
> >>      },
> >> @@ -245,7 +245,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> >> -        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "ict_noslot_disp_held_cpi - ict_noslot_disp_held_hb_full_cpi - ict_noslot_disp_held_sync_cpi - ict_noslot_disp_held_tbegin_cpi - ict_noslot_disp_held_issq_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "ict_noslot_disp_held_other_cpi"
> >>      },
> >> @@ -263,7 +263,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> >> -        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "ict_noslot_ic_miss_cpi - ict_noslot_ic_l3_cpi - ict_noslot_ic_l3miss_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "ict_noslot_ic_l2_cpi"
> >>      },
> >> @@ -286,7 +286,7 @@
> >>          "MetricName": "ict_noslot_ic_miss_cpi"
> >>      },
> >>      {
> >> -        "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_HELD_ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "ntc_issue_held_darq_full_cpi + ntc_issue_held_arb_cpi + ntc_issue_held_other_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "issue_hold_cpi"
> >>      },
> >> @@ -327,7 +327,7 @@
> >>          "MetricName": "lrq_other_stall_cpi"
> >>      },
> >>      {
> >> -        "MetricExpr": "(PM_CMPLU_STALL_LMQ_FULL + PM_CMPLU_STALL_ST_FWD + PM_CMPLU_STALL_LHS + PM_CMPLU_STALL_LSU_MFSPR + PM_CMPLU_STALL_LARX + PM_CMPLU_STALL_LRQ_OTHER)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "lmq_full_stall_cpi + st_fwd_stall_cpi + lhs_stall_cpi + lsu_mfspr_stall_cpi + larx_stall_cpi + lrq_other_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "lrq_stall_cpi"
> >>      },
> >> @@ -338,7 +338,7 @@
> >>          "MetricName": "lsaq_arb_stall_cpi"
> >>      },
> >>      {
> >> -        "MetricExpr": "(PM_CMPLU_STALL_LRQ_FULL + PM_CMPLU_STALL_SRQ_FULL + PM_CMPLU_STALL_LSAQ_ARB)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "lrq_full_stall_cpi + srq_full_stall_cpi + lsaq_arb_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "lsaq_stall_cpi"
> >>      },
> >> @@ -362,7 +362,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Completion LSU stall for other reasons",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_LSU_FIN - PM_CMPLU_STALL_STORE_FINISH - PM_CMPLU_STALL_STORE_DATA - PM_CMPLU_STALL_EIEIO - PM_CMPLU_STALL_STCX - PM_CMPLU_STALL_SLB - PM_CMPLU_STALL_TEND - PM_CMPLU_STALL_PASTE - PM_CMPLU_STALL_TLBIE - PM_CMPLU_STALL_STORE_PIPE_ARB - PM_CMPLU_STALL_STORE_FIN_ARB - PM_CMPLU_STALL_LOAD_FINISH + PM_CMPLU_STALL_DCACHE_MISS - PM_CMPLU_STALL_LMQ_FULL - PM_CMPLU_STALL_ST_FWD - PM_CMPLU_STALL_LHS - PM_CMPLU_STALL_LSU_MFSPR - PM_CMPLU_STALL_LARX - PM_CMPLU_STALL_LRQ_OTHER + PM_CMPLU_STALL_ERAT_MISS + PM_CMPLU_STALL_EMQ_FULL - PM_CMPLU_STALL_LRQ_FULL - PM_CMPLU_STALL_SRQ_FULL - PM_CMPLU_STALL_LSAQ_ARB) / PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "lsu_stall_cpi - lsu_fin_stall_cpi - store_finish_stall_cpi - srq_stall_cpi - load_finish_stall_cpi + lsu_stall_dcache_miss_cpi - lrq_stall_cpi + emq_stall_cpi - lsaq_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "lsu_other_stall_cpi"
> >>      },
> >> @@ -434,13 +434,13 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Cycles unaccounted for.",
> >> -        "MetricExpr": "(PM_RUN_CYC - PM_1PLUS_PPC_CMPL - PM_CMPLU_STALL_THRD - PM_CMPLU_STALL - PM_ICT_NOSLOT_CYC)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "run_cpi - completion_cpi - thread_block_stall_cpi - stall_cpi - nothing_dispatched_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "other_cpi"
> >>      },
> >>      {
> >>          "BriefDescription": "Completion stall for other reasons",
> >> -        "MetricExpr": "(PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FIN - PM_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "stall_cpi - ntc_disp_fin_stall_cpi - ntc_flush_stall_cpi - lsu_stall_cpi - exec_unit_stall_cpi - bru_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "other_stall_cpi"
> >>      },
> >> @@ -469,7 +469,7 @@
> >>          "MetricName": "run_cyc_cpi"
> >>      },
> >>      {
> >> -        "MetricExpr": "(PM_CMPLU_STALL_FXU + PM_CMPLU_STALL_DP + PM_CMPLU_STALL_DFU + PM_CMPLU_STALL_PM + PM_CMPLU_STALL_CRYPTO)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "fxu_stall_cpi + dp_stall_cpi + dfu_stall_cpi + pm_stall_cpi + crypto_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "scalar_stall_cpi"
> >>      },
> >> @@ -492,7 +492,7 @@
> >>          "MetricName": "srq_full_stall_cpi"
> >>      },
> >>      {
> >> -        "MetricExpr": "(PM_CMPLU_STALL_STORE_DATA + PM_CMPLU_STALL_EIEIO + PM_CMPLU_STALL_STCX + PM_CMPLU_STALL_SLB + PM_CMPLU_STALL_TEND + PM_CMPLU_STALL_PASTE + PM_CMPLU_STALL_TLBIE + PM_CMPLU_STALL_STORE_PIPE_ARB + PM_CMPLU_STALL_STORE_FIN_ARB)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "store_data_stall_cpi + eieio_stall_cpi + stcx_stall_cpi + slb_stall_cpi + tend_stall_cpi + paste_stall_cpi + tlbie_stall_cpi + store_pipe_arb_stall_cpi + store_fin_arb_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "srq_stall_cpi"
> >>      },
> >> @@ -558,7 +558,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Vector stalls due to small latency double precision ops",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_VDP - PM_CMPLU_STALL_VDPLONG)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "vdp_stall_cpi - vdplong_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "vdp_other_stall_cpi"
> >>      },
> >> @@ -575,7 +575,7 @@
> >>          "MetricName": "vdplong_stall_cpi"
> >>      },
> >>      {
> >> -        "MetricExpr": "(PM_CMPLU_STALL_VFXU + PM_CMPLU_STALL_VDP)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "vfxu_stall_cpi + vdp_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "vector_stall_cpi"
> >>      },
> >> @@ -587,7 +587,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Vector stalls due to small latency integer ops",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_VFXU - PM_CMPLU_STALL_VFXLONG)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "vfxu_stall_cpi - vfxlong_stall_cpi",
> >>          "MetricGroup": "cpi_breakdown",
> >>          "MetricName": "vfxu_other_stall_cpi"
> >>      },
> >> @@ -1844,7 +1844,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "% of DL1 reloads from Private L3, other core per Inst",
> >> -        "MetricExpr": "(PM_DATA_FROM_L31_MOD + PM_DATA_FROM_L31_SHR) * 100 / PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "dl1_reload_from_l31_mod_rate_percent + dl1_reload_from_l31_shr_rate_percent",
> >>          "MetricName": "dl1_reload_from_l31_rate_percent"
> >>      },
> >>      {
> >> @@ -1979,7 +1979,7 @@
> >>      },
> >>      {
> >>          "BriefDescription": "Completion stall because a different thread was using the completion pipe",
> >> -        "MetricExpr": "(PM_CMPLU_STALL_THRD - PM_CMPLU_STALL_EXCEPTION - PM_CMPLU_STALL_ANY_SYNC - PM_CMPLU_STALL_SYNC_PMU_INT - PM_CMPLU_STALL_SPEC_FINISH - PM_CMPLU_STALL_FLUSH_ANY_THREAD - PM_CMPLU_STALL_LSU_FLUSH_NEXT - PM_CMPLU_STALL_NESTED_TBEGIN - PM_CMPLU_STALL_NESTED_TEND - PM_CMPLU_STALL_MTFPSCR)/PM_RUN_INST_CMPL",
> >> +        "MetricExpr": "thread_block_stall_cpi - exception_stall_cpi - any_sync_stall_cpi - sync_pmu_int_stall_cpi - spec_finish_stall_cpi - flush_any_thread_stall_cpi - lsu_flush_next_stall_cpi - nested_tbegin_stall_cpi - nested_tend_stall_cpi - mtfpscr_stall_cpi",
> >>          "MetricName": "other_thread_cmpl_stall"
> >>      },
> >>      {
> >> --
> >> 2.18.4
> >>

-- 

- Arnaldo
