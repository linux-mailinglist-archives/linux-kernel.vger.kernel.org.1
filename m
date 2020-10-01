Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0615027F908
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJAF12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAF11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:27:27 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA27221D7D;
        Thu,  1 Oct 2020 05:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601530047;
        bh=oPDglaBtk+EDIXoigZrFeZ0iVAhmabSrKziAaX9kN+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZrTFoG2EQdCKU6+jOkCdQaQ9Ix3Hu4vk4xkp+tuKgN0lQmuVwvEmHHqujFz1d6w9O
         bwzcR85aQc0EQLvrGl4oxZD0MFkYpyX4tVBhuwABkjKedJBxhpzbBhcuQ5Waz9rmEa
         x/6TYyDJ3YAn/uKtR8NegJ2yyc/4kqSCqVyWiGQw=
Date:   Thu, 1 Oct 2020 14:27:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tracing: Fix parse_synth_field() error handling
Message-Id: <20201001142723.66b8f3d7d6f7df803044c567@kernel.org>
In-Reply-To: <15b1808e1466f378fcf206e61b57c802423f8319.1601490263.git.zanussi@kernel.org>
References: <cover.1601490263.git.zanussi@kernel.org>
        <15b1808e1466f378fcf206e61b57c802423f8319.1601490263.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Wed, 30 Sep 2020 13:40:51 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> synth_field_size() returns either a positive size or an error (zero or
> a negative value). However, the existing code assumes the only error
> value is 0. It doesn't handle negative error codes, as it assigns
> directly to field->size (a size_t; unsigned), thereby interpreting the
> error code as a valid size instead.
> 
> Do the test before assignment to field->size.

This looks good to me. And I guess it is a kind of bugfix which should be backported?
(doesn't this need a Fixes tag?)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> [ axelrasmussen@google.com: changelog addition, first paragraph above ]
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_events_synth.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index a9cd7793f7ea..fa8a99828f41 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -465,6 +465,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>  	struct synth_field *field;
>  	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
>  	int len, ret = 0;
> +	ssize_t size;
>  
>  	if (field_type[0] == ';')
>  		field_type++;
> @@ -520,11 +521,12 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>  			field->type[len - 1] = '\0';
>  	}
>  
> -	field->size = synth_field_size(field->type);
> -	if (!field->size) {
> +	size = synth_field_size(field->type);
> +	if (size <= 0) {
>  		ret = -EINVAL;
>  		goto free;
>  	}
> +	field->size = size;
>  
>  	if (synth_field_is_string(field->type))
>  		field->is_string = true;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
