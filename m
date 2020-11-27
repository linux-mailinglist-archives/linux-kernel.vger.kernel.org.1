Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A322C5F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 05:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392432AbgK0Ead (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 23:30:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:40653 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392411AbgK0Ead (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 23:30:33 -0500
IronPort-SDR: p1XL1BloL8yhrAD7Wvks6Q0IR11Xjkh6JE9ZnK0UH3lZa/iFcW14y7c+8PjBlch4M6gr1vudZt
 Zjf50BpdryeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="160122394"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="160122394"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 20:30:32 -0800
IronPort-SDR: czeF7D+7fM5a9PWNPzdwKvmk5EBsk1FhQRFj8OawBVfcjWOIjqGD8Po9wZIgapdlX/4xKumpJM
 DW5kRQTNfsmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="371319899"
Received: from lkp-server01.sh.intel.com (HELO fe15a1cd36f8) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Nov 2020 20:30:29 -0800
Received: from kbuild by fe15a1cd36f8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiVOu-00001B-46; Fri, 27 Nov 2020 04:30:28 +0000
Date:   Fri, 27 Nov 2020 12:30:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>
Subject: drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c:1916:23:
 warning: Uninitialized variable: vlevel
Message-ID: <202011271200.kgb3ZKtT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   85a2c56cb4454c73f56d3099d96942e7919b292f
commit: 16a8cb7cc557f980aae19d1b7140713939fa9644 drm/amd/display: fix dcn3 p_state_change_support validation (v2)
date:   5 months ago
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:
>> drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c:1916:23: warning: Uninitialized variable: vlevel [uninitvar]
    if (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
                         ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:
   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c:2362:26: warning: Array index 'i' is used before limits check. [arrayIndexThenCheck]
      if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
                            ^

vim +1916 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c

  1873	
  1874	static bool dcn30_internal_validate_bw(
  1875			struct dc *dc,
  1876			struct dc_state *context,
  1877			display_e2e_pipe_params_st *pipes,
  1878			int *pipe_cnt_out,
  1879			int *vlevel_out,
  1880			bool fast_validate)
  1881	{
  1882		bool out = false;
  1883		bool repopulate_pipes = false;
  1884		int split[MAX_PIPES] = { 0 };
  1885		bool merge[MAX_PIPES] = { false };
  1886		bool newly_split[MAX_PIPES] = { false };
  1887		int pipe_cnt, i, pipe_idx, vlevel;
  1888		struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
  1889	
  1890		ASSERT(pipes);
  1891		if (!pipes)
  1892			return false;
  1893	
  1894		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes);
  1895	
  1896		if (!pipe_cnt) {
  1897			out = true;
  1898			goto validate_out;
  1899		}
  1900	
  1901		dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
  1902	
  1903		if (!fast_validate) {
  1904			/*
  1905			 * DML favors voltage over p-state, but we're more interested in
  1906			 * supporting p-state over voltage. We can't support p-state in
  1907			 * prefetch mode > 0 so try capping the prefetch mode to start.
  1908			 */
  1909			context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
  1910				dm_allow_self_refresh_and_mclk_switch;
  1911			vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
  1912			/* This may adjust vlevel and maxMpcComb */
  1913			if (vlevel < context->bw_ctx.dml.soc.num_states)
  1914				vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
  1915		}
> 1916		if (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
  1917				vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported) {
  1918			/*
  1919			 * If mode is unsupported or there's still no p-state support then
  1920			 * fall back to favoring voltage.
  1921			 *
  1922			 * We don't actually support prefetch mode 2, so require that we
  1923			 * at least support prefetch mode 1.
  1924			 */
  1925			context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
  1926				dm_allow_self_refresh;
  1927	
  1928			vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
  1929			if (vlevel < context->bw_ctx.dml.soc.num_states) {
  1930				memset(split, 0, sizeof(split));
  1931				memset(merge, 0, sizeof(merge));
  1932				vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
  1933			}
  1934		}
  1935	
  1936		dml_log_mode_support_params(&context->bw_ctx.dml);
  1937	
  1938		/* TODO: Need to check calculated vlevel why that fails validation of below resolutions */
  1939		if (context->res_ctx.pipe_ctx[0].stream != NULL) {
  1940			if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 640  && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 480)
  1941				vlevel = 0;
  1942			if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 1280 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 800)
  1943				vlevel = 0;
  1944			if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 1280 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 768)
  1945				vlevel = 0;
  1946			if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 1280 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 1024)
  1947				vlevel = 0;
  1948			if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 2048 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 1536)
  1949				vlevel = 0;
  1950		}
  1951	
  1952		if (vlevel == context->bw_ctx.dml.soc.num_states)
  1953			goto validate_fail;
  1954	
  1955		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
  1956			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
  1957			struct pipe_ctx *mpo_pipe = pipe->bottom_pipe;
  1958	
  1959			if (!pipe->stream)
  1960				continue;
  1961	
  1962			/* We only support full screen mpo with ODM */
  1963			if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
  1964					&& pipe->plane_state && mpo_pipe
  1965					&& memcmp(&mpo_pipe->plane_res.scl_data.recout,
  1966							&pipe->plane_res.scl_data.recout,
  1967							sizeof(struct rect)) != 0) {
  1968				ASSERT(mpo_pipe->plane_state != pipe->plane_state);
  1969				goto validate_fail;
  1970			}
  1971			pipe_idx++;
  1972		}
  1973	
  1974		/* merge pipes if necessary */
  1975		for (i = 0; i < dc->res_pool->pipe_count; i++) {
  1976			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
  1977	
  1978			/*skip pipes that don't need merging*/
  1979			if (!merge[i])
  1980				continue;
  1981	
  1982			/* if ODM merge we ignore mpc tree, mpo pipes will have their own flags */
  1983			if (pipe->prev_odm_pipe) {
  1984				/*split off odm pipe*/
  1985				pipe->prev_odm_pipe->next_odm_pipe = pipe->next_odm_pipe;
  1986				if (pipe->next_odm_pipe)
  1987					pipe->next_odm_pipe->prev_odm_pipe = pipe->prev_odm_pipe;
  1988	
  1989				pipe->bottom_pipe = NULL;
  1990				pipe->next_odm_pipe = NULL;
  1991				pipe->plane_state = NULL;
  1992				pipe->stream = NULL;
  1993				pipe->top_pipe = NULL;
  1994				pipe->prev_odm_pipe = NULL;
  1995				if (pipe->stream_res.dsc)
  1996					dcn20_release_dsc(&context->res_ctx, dc->res_pool, &pipe->stream_res.dsc);
  1997				memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
  1998				memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
  1999			} else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
  2000				struct pipe_ctx *top_pipe = pipe->top_pipe;
  2001				struct pipe_ctx *bottom_pipe = pipe->bottom_pipe;
  2002	
  2003				top_pipe->bottom_pipe = bottom_pipe;
  2004				if (bottom_pipe)
  2005					bottom_pipe->top_pipe = top_pipe;
  2006	
  2007				pipe->top_pipe = NULL;
  2008				pipe->bottom_pipe = NULL;
  2009				pipe->plane_state = NULL;
  2010				pipe->stream = NULL;
  2011				memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
  2012				memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
  2013			} else
  2014				ASSERT(0); /* Should never try to merge master pipe */
  2015	
  2016		}
  2017	
  2018		for (i = 0, pipe_idx = -1; i < dc->res_pool->pipe_count; i++) {
  2019			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
  2020			struct pipe_ctx *hsplit_pipe = NULL;
  2021			bool odm;
  2022	
  2023			if (!pipe->stream || newly_split[i])
  2024				continue;
  2025	
  2026			pipe_idx++;
  2027			odm = vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled;
  2028	
  2029			if (!pipe->plane_state && !odm)
  2030				continue;
  2031	
  2032			if (split[i]) {
  2033				hsplit_pipe = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
  2034				ASSERT(hsplit_pipe);
  2035				if (!hsplit_pipe)
  2036					goto validate_fail;
  2037	
  2038				if (!dcn30_split_stream_for_mpc_or_odm(
  2039						dc, &context->res_ctx,
  2040						pipe, hsplit_pipe, odm))
  2041					goto validate_fail;
  2042	
  2043				newly_split[hsplit_pipe->pipe_idx] = true;
  2044				repopulate_pipes = true;
  2045			}
  2046			if (split[i] == 4) {
  2047				struct pipe_ctx *pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
  2048	
  2049				ASSERT(pipe_4to1);
  2050				if (!pipe_4to1)
  2051					goto validate_fail;
  2052				if (!dcn30_split_stream_for_mpc_or_odm(
  2053						dc, &context->res_ctx,
  2054						pipe, pipe_4to1, odm))
  2055					goto validate_fail;
  2056				newly_split[pipe_4to1->pipe_idx] = true;
  2057	
  2058				pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
  2059				ASSERT(pipe_4to1);
  2060				if (!pipe_4to1)
  2061					goto validate_fail;
  2062				if (!dcn30_split_stream_for_mpc_or_odm(
  2063						dc, &context->res_ctx,
  2064						hsplit_pipe, pipe_4to1, odm))
  2065					goto validate_fail;
  2066				newly_split[pipe_4to1->pipe_idx] = true;
  2067			}
  2068			if (odm)
  2069				dcn20_build_mapped_resource(dc, context, pipe->stream);
  2070		}
  2071	
  2072		for (i = 0; i < dc->res_pool->pipe_count; i++) {
  2073			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
  2074	
  2075			if (pipe->plane_state) {
  2076				if (!resource_build_scaling_params(pipe))
  2077					goto validate_fail;
  2078			}
  2079		}
  2080	
  2081		/* Actual dsc count per stream dsc validation*/
  2082		if (!dcn20_validate_dsc(dc, context)) {
  2083			vba->ValidationStatus[vba->soc.num_states] = DML_FAIL_DSC_VALIDATION_FAILURE;
  2084			goto validate_fail;
  2085		}
  2086	
  2087		if (repopulate_pipes)
  2088			pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes);
  2089		*vlevel_out = vlevel;
  2090		*pipe_cnt_out = pipe_cnt;
  2091	
  2092		out = true;
  2093		goto validate_out;
  2094	
  2095	validate_fail:
  2096		out = false;
  2097	
  2098	validate_out:
  2099		return out;
  2100	}
  2101	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
