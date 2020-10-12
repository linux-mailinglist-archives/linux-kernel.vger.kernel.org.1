Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0EA28C4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbgJLWYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388361AbgJLWYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:24:16 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6341720797;
        Mon, 12 Oct 2020 22:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602541455;
        bh=t9OfqTx5LN1zD82QSPTY4/B0T90282JWFD9p/VHGJpM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ltXg2rbz+UovKnc0us188Qtxf+uA7L+ilatlm6WO/40HHY+q46xTof6HqGzk36tkK
         jt9654/pw4tcHRQWKetl5Omh+8CS6UvWLYhPgF94y+2MUeR0jRH9ZL0w86hhrU5gwV
         z1NGRGRGQaBr4ZqKrK1dL1sTQA4A30FHbZvOtXE0=
Message-ID: <3e516b408adeaf6969e267a52c94b66c7579c83d.camel@kernel.org>
Subject: Re: [PATCH v2 4/7] tracing: Add synthetic event error logging
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Oct 2020 17:24:13 -0500
In-Reply-To: <20201012180439.22ed7e4f@oasis.local.home>
References: <cover.1602533267.git.zanussi@kernel.org>
         <b8e0f659f0c21e5a5d711fcf439eca098d6c4a99.1602533267.git.zanussi@kernel.org>
         <20201012180439.22ed7e4f@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2020-10-12 at 18:04 -0400, Steven Rostedt wrote:
> On Mon, 12 Oct 2020 15:18:06 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > +static int cmdstr_append(char *buf, const char *str, int
> > *remaining)
> > +{
> > +	int len = strlen(str);
> > +
> > +	if (len + 1 >= *remaining) {
> > +		synth_err(SYNTH_ERR_CMD_TOO_LONG, 0);
> > +		return -EINVAL;
> > +	}
> > +
> > +	strcat(buf, str);
> > +	strcat(buf, " ");
> > +	*remaining -= len + 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static int save_cmdstr(int argc, const char *name, const char
> > **argv)
> > +{
> > +	int i, ret, remaining = MAX_DYNEVENT_CMD_LEN;
> > +	char *buf;
> > +
> > +	synth_err_clear();
> > +
> > +	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	ret = cmdstr_append(buf, name, &remaining);
> > +	if (ret) {
> > +		kfree(buf);
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < argc; i++) {
> > +		ret = cmdstr_append(buf, argv[i], &remaining);
> > +		if (ret) {
> > +			kfree(buf);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	last_cmd_set(buf);
> > +
> > +	kfree(buf);
> > +
> > +	return ret;
> > +}
> > +
> 
> Hmm, the above could easily be replaced with:
> 
> 	struct seq_buf s;
> 
> 	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
> 	if (!buf)
> 		return -ENOMEM;
> 
> 	seq_buf_init(&s, buf, MAX_DYNEVENT_CMD_LEN);
> 
> 	seq_buf_puts(&s, name);
> 
> 	for (i = 0; i < argc; i++) {
> 		seq_buf_putc(&s, ' ');
> 		seq_buf_puts(&s, argv[i]);
> 	}
> 
> 	if (!seq_buf_buffer_left(&s)) {
> 		synth_err(SYNTH_ERR_CMD_TOO_LONG, 0);
> 		kfree(buf);
> 		return -EINVAL;
> 	}
> 	buf[s.len] = 0;
> 	last_cmd_set(buf);
> 
> 	kfree(buf);
> 	return 0;
> 

Yeah, that makes sense, will change it.

Thanks,

Tom

> 
> -- Steve

