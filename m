Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA328C453
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbgJLVtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729273AbgJLVtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:49:11 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A4882072D;
        Mon, 12 Oct 2020 21:49:10 +0000 (UTC)
Date:   Mon, 12 Oct 2020 17:49:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] tracing: Add synthetic event error logging
Message-ID: <20201012174908.7ca51d0c@oasis.local.home>
In-Reply-To: <20201012174240.7715df28@oasis.local.home>
References: <cover.1602533267.git.zanussi@kernel.org>
        <b8e0f659f0c21e5a5d711fcf439eca098d6c4a99.1602533267.git.zanussi@kernel.org>
        <20201012174240.7715df28@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 17:42:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 12 Oct 2020 15:18:06 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > +static char last_cmd[MAX_FILTER_STR_VAL];
> > +
> > +static int errpos(const char *str)
> > +{
> > +	return err_pos(last_cmd, str);
> > +}
> > +
> > +static void last_cmd_set(char *str)
> > +{
> > +	if (!str)
> > +		return;
> > +
> > +	strncat(last_cmd, str, MAX_FILTER_STR_VAL - 1);  
> 
> If I understand strncat() correctly, it will add 'n' + 1 bytes from str
> to last_cmd. That is, I think you want:
> 
> 	strncat(last_cmd, str, MAX_FILTER_STR_VAL - (strlen(last_cmd) + 1));
> 

Looking at the patch more, it only has one caller to last_cmd_set(),
and one caller to synth_err_clear().

Why not just clear on set?

-- Steve



> 
> > +}
> > +
> > +static void synth_err(u8 err_type, u8 err_pos)
> > +{
> > +	tracing_log_err(NULL, "synthetic_events", last_cmd, err_text,
> > +			err_type, err_pos);
> > +}
> > +
> > +static void synth_err_clear(void)
> > +{
> > +	last_cmd[0] = '\0';
> > +}
> > +  

