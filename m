Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D40D300E72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbhAVVD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:03:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbhAVVBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:01:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A8C423B16;
        Fri, 22 Jan 2021 21:00:53 +0000 (UTC)
Date:   Fri, 22 Jan 2021 16:00:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/6] tracing: Rework synthetic event command parsing
Message-ID: <20210122160052.4b535511@gandalf.local.home>
In-Reply-To: <f3c2d2841307de0a7624a250f8f9653d435602c9.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
        <f3c2d2841307de0a7624a250f8f9653d435602c9.1611243025.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 11:01:05 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> @@ -1208,13 +1173,14 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
>  	 *      where 'field' = type field_name
>  	 */
>  
> -	if (name[0] == '\0' || argc < 1) {
> +	mutex_lock(&event_mutex);

I'm curious, why is the event_mutex taken here? I'm guessing it is first
needed for the find_synth_event() call, in which case, it can be moved
after the is_good_name() check. I don't see why the goto out is required
here or for the is_good_name() check.

-- Steve

> +
> +	if (name[0] == '\0') {
>  		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  
> -	mutex_lock(&event_mutex);
> -
>  	if (!is_good_name(name)) {
>  		synth_err(SYNTH_ERR_BAD_NAME, errpos(name));
>  		ret = -EINVAL;
