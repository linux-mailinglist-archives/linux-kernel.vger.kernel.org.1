Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885BE28D15D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgJMPhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgJMPhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:37:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEEFB251DD;
        Tue, 13 Oct 2020 15:37:10 +0000 (UTC)
Date:   Tue, 13 Oct 2020 11:37:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] tracing: Add synthetic event error logging
Message-ID: <20201013113709.09531d7c@gandalf.local.home>
In-Reply-To: <ed099c66df13b40cfc633aaeb17f66c37a923066.1602598160.git.zanussi@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
        <ed099c66df13b40cfc633aaeb17f66c37a923066.1602598160.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 09:17:55 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> +static int save_cmdstr(int argc, const char *name, const char **argv)
> +{
> +        struct seq_buf s;
> +	char *buf;
> +	int i;
> +
> +        buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
> +        if (!buf)
> +                return -ENOMEM;
> +
> +        seq_buf_init(&s, buf, MAX_DYNEVENT_CMD_LEN);
> +
> +        seq_buf_puts(&s, name);
> +
> +        for (i = 0; i < argc; i++) {
> +                seq_buf_putc(&s, ' ');
> +                seq_buf_puts(&s, argv[i]);
> +        }
> +
> +        if (!seq_buf_buffer_left(&s)) {
> +                synth_err(SYNTH_ERR_CMD_TOO_LONG, 0);
> +                kfree(buf);
> +                return -EINVAL;
> +        }
> +        buf[s.len] = 0;
> +        last_cmd_set(buf);
> +
> +        kfree(buf);
> +        return 0;
> +}

I see you cut and pasted this ;-)

I fixed up the whitespace.

-- Steve
