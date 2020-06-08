Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5E1F1E34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgFHRQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 13:16:33 -0400
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:58222 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730697AbgFHRQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:16:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 68DFC808BEAF;
        Mon,  8 Jun 2020 17:16:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:4250:4321:5007:6119:7903:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12114:12295:12296:12297:12438:12555:12740:12760:12895:12986:13439:14096:14097:14181:14659:14721:21080:21451:21627:30012:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fish07_050374426dbb
X-Filterd-Recvd-Size: 4141
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Jun 2020 17:16:29 +0000 (UTC)
Message-ID: <dcce7f702c674999c31fd358c3970d5fee1a6725.camel@perches.com>
Subject: Re: [PATCH] drm/amd/display: Fix indenting in
 dcn30_set_output_transfer_func()
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Harry Wentland <harry.wentland@amd.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Mon, 08 Jun 2020 10:16:27 -0700
In-Reply-To: <20200608141657.GB1912173@mwanda>
References: <20200608141657.GB1912173@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-08 at 17:16 +0300, Dan Carpenter wrote:
> These lines are a part of the if statement and they are supposed to
> be indented one more tab.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index ab20320ebc994..37c310dbb3665 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -203,9 +203,9 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
>  					stream->out_transfer_func,
>  					&mpc->blender_params, false))
>  				params = &mpc->blender_params;
> -		 /* there are no ROM LUTs in OUTGAM */
> -		if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
> -			BREAK_TO_DEBUGGER();
> +			 /* there are no ROM LUTs in OUTGAM */
> +			if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
> +				BREAK_TO_DEBUGGER();
>  		}
>  	}
>  

Maybe the if is at the right indentation but the
close brace below the if is misplaced instead?

Also, because this code uses very long identifiers,
it would read better using wider columns as the
logic in the code itself isn't complicated but the
80 column wrapping makes it seem so.

Wrapping could be something like:
---
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index ab20320ebc99..56e91a73610f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -190,18 +190,16 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
 	struct pwl_params *params = NULL;
 	bool ret = false;
 
-	/* program OGAM or 3DLUT only for the top pipe*/
+	/* program OGAM or 3DLUT only for the top pipe */
 	if (pipe_ctx->top_pipe == NULL) {
-		/*program rmu shaper and 3dlut in MPC*/
+		/* program rmu shaper and 3dlut in MPC */
 		ret = dcn30_set_mpc_shaper_3dlut(pipe_ctx, stream);
-		if (ret == false && mpc->funcs->set_output_gamma && stream->out_transfer_func) {
+		if (!ret && mpc->funcs->set_output_gamma && stream->out_transfer_func) {
 			if (stream->out_transfer_func->type == TF_TYPE_HWPWL)
 				params = &stream->out_transfer_func->pwl;
-			else if (pipe_ctx->stream->out_transfer_func->type ==
-					TF_TYPE_DISTRIBUTED_POINTS &&
-					cm3_helper_translate_curve_to_hw_format(
-					stream->out_transfer_func,
-					&mpc->blender_params, false))
+			else if (pipe_ctx->stream->out_transfer_func->type == TF_TYPE_DISTRIBUTED_POINTS &&
+				 cm3_helper_translate_curve_to_hw_format(stream->out_transfer_func,
+									 &mpc->blender_params, false))
 				params = &mpc->blender_params;
 		 /* there are no ROM LUTs in OUTGAM */
 		if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)


