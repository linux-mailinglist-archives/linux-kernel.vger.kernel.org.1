Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83228C492
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbgJLWOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388499AbgJLWOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:14:18 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62DC02074A;
        Mon, 12 Oct 2020 22:14:17 +0000 (UTC)
Date:   Mon, 12 Oct 2020 18:14:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] tracing: Handle synthetic event array field type
 checking correctly
Message-ID: <20201012181415.48560c8e@oasis.local.home>
In-Reply-To: <65a8c7dc784df121ea4b1c0060124e218f2162d0.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
        <65a8c7dc784df121ea4b1c0060124e218f2162d0.1602533267.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 15:18:08 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> @@ -630,8 +630,11 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>  	if (field_type[0] == ';')
>  		field_type++;
>  	len = strlen(field_type) + 1;
> -	if (array)
> +	if (array) {
>  		len += strlen(array);
> +		if (array[strlen(array) - 1] == ';')
> +			len--;
> +	}

Why not:

	if (array) {
		int l = strlen(array);

		if (l && array[l - 1] == ';')
			l--;
		len += l;
	}

-- Steve
