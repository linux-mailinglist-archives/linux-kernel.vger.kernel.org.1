Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53269281C36
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbgJBToV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgJBToT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:44:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC466206DD;
        Fri,  2 Oct 2020 19:44:18 +0000 (UTC)
Date:   Fri, 2 Oct 2020 15:44:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] tracing: Change STR_VAR_MAX_LEN
Message-ID: <20201002154417.320ad78b@gandalf.local.home>
In-Reply-To: <34a494e502fe1364b07896ef4d76f1fbbb8d1d1a.1601588066.git.zanussi@kernel.org>
References: <cover.1601588066.git.zanussi@kernel.org>
        <34a494e502fe1364b07896ef4d76f1fbbb8d1d1a.1601588066.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Oct 2020 16:46:44 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> 32 is too small for this value, and anyway it makes more sense to use
> MAX_FILTER_STR_VAL, as this is also the value used for variable-length
> __strings.
> 
> Tested-by: Axel Rasmussen <axelrasmussen@google.com>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_synth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
> index ac35c45207c4..5166705d1556 100644
> --- a/kernel/trace/trace_synth.h
> +++ b/kernel/trace/trace_synth.h
> @@ -7,7 +7,7 @@
>  #define SYNTH_SYSTEM		"synthetic"
>  #define SYNTH_FIELDS_MAX	32
>  
> -#define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
> +#define STR_VAR_LEN_MAX		MAX_FILTER_STR_VAL /* must be multiple of sizeof(u64) */

Hmm, this requirement is now passed to MAX_FILTER_STR_VAL, but there's no
mention of it there. I guess we should have a

	BUILD_BUG_ON(STR_VAR_LEN_MAX & (sizeof(u64) - 1));

in C code somewhere.

-- Steve


>  
>  struct synth_field {
>  	char *type;

