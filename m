Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B9E300E89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbhAVVIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbhAVVGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:06:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE1F23B42;
        Fri, 22 Jan 2021 21:06:02 +0000 (UTC)
Date:   Fri, 22 Jan 2021 16:06:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/6] tracing: Update synth command errors
Message-ID: <20210122160600.409936d8@gandalf.local.home>
In-Reply-To: <18090ccadf2c33b03e4eaad429867d7088782721.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
        <18090ccadf2c33b03e4eaad429867d7088782721.1611243025.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 11:01:06 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +static int check_command(const char *raw_command)
> +{
> +	char **argv = NULL, *cmd, *saved_cmd, *name_and_field;
> +	int argc, ret = 0;
> +
> +	cmd = saved_cmd = kstrdup(raw_command, GFP_KERNEL);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	name_and_field = strsep(&cmd, ";");
> +	if (!name_and_field) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +
> +	if (name_and_field[0] == '!')
> +		goto free;
> +
> +	argv = argv_split(GFP_KERNEL, name_and_field, &argc);
> +	if (!argv) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	if (argc < 3)
> +		ret = -EINVAL;

Nit, you can simply put here:

	argv_free(argv);

Hmm, is it used at all? If not, just move it after its allocation check.

> +free:
> +	kfree(saved_cmd);

> +	if (argv)
> +		argv_free(argv);

And remove the above, as argv is always NULL when "goto free" is used.

-- Steve


> +
> +	return ret;
> +}
> +
