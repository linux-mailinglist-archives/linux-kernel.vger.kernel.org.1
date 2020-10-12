Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4878228C47E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbgJLWEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgJLWEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:04:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB6D2074F;
        Mon, 12 Oct 2020 22:04:41 +0000 (UTC)
Date:   Mon, 12 Oct 2020 18:04:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] tracing: Add synthetic event error logging
Message-ID: <20201012180439.22ed7e4f@oasis.local.home>
In-Reply-To: <b8e0f659f0c21e5a5d711fcf439eca098d6c4a99.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
        <b8e0f659f0c21e5a5d711fcf439eca098d6c4a99.1602533267.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 15:18:06 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> +static int cmdstr_append(char *buf, const char *str, int *remaining)
> +{
> +	int len = strlen(str);
> +
> +	if (len + 1 >= *remaining) {
> +		synth_err(SYNTH_ERR_CMD_TOO_LONG, 0);
> +		return -EINVAL;
> +	}
> +
> +	strcat(buf, str);
> +	strcat(buf, " ");
> +	*remaining -= len + 1;
> +
> +	return 0;
> +}
> +
> +static int save_cmdstr(int argc, const char *name, const char **argv)
> +{
> +	int i, ret, remaining = MAX_DYNEVENT_CMD_LEN;
> +	char *buf;
> +
> +	synth_err_clear();
> +
> +	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = cmdstr_append(buf, name, &remaining);
> +	if (ret) {
> +		kfree(buf);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < argc; i++) {
> +		ret = cmdstr_append(buf, argv[i], &remaining);
> +		if (ret) {
> +			kfree(buf);
> +			return ret;
> +		}
> +	}
> +
> +	last_cmd_set(buf);
> +
> +	kfree(buf);
> +
> +	return ret;
> +}
> +

Hmm, the above could easily be replaced with:

	struct seq_buf s;

	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;

	seq_buf_init(&s, buf, MAX_DYNEVENT_CMD_LEN);

	seq_buf_puts(&s, name);

	for (i = 0; i < argc; i++) {
		seq_buf_putc(&s, ' ');
		seq_buf_puts(&s, argv[i]);
	}

	if (!seq_buf_buffer_left(&s)) {
		synth_err(SYNTH_ERR_CMD_TOO_LONG, 0);
		kfree(buf);
		return -EINVAL;
	}
	buf[s.len] = 0;
	last_cmd_set(buf);

	kfree(buf);
	return 0;


-- Steve
