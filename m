Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9981028C461
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgJLV70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbgJLV70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:59:26 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37D1F2074F;
        Mon, 12 Oct 2020 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602539965;
        bh=MSV/i9avcQRy4vWvjU4c1WC7NJihThnh4yEAuznx3Aw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ouGNtSNo66DSV/swxsyxMm8OoBy0a/hqgts6dPzTTT1pvFHS9Iu3qpFKZgU6zlAPP
         rzmWO7aXlMnDbfNWGqc9NICT+ZjcZqOUYBvALehQrjHmyqq1Vb1ZhOOOdb6foT8CvM
         bML8Kw5RSMJ8PWNj/PnY2fGwnVXyG6kVGbWW8RkI=
Message-ID: <29cb75c8cb92d34e3dd8ea156893760c81d935b4.camel@kernel.org>
Subject: Re: [PATCH v2 4/7] tracing: Add synthetic event error logging
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Oct 2020 16:59:23 -0500
In-Reply-To: <20201012174908.7ca51d0c@oasis.local.home>
References: <cover.1602533267.git.zanussi@kernel.org>
         <b8e0f659f0c21e5a5d711fcf439eca098d6c4a99.1602533267.git.zanussi@kernel.org>
         <20201012174240.7715df28@oasis.local.home>
         <20201012174908.7ca51d0c@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2020-10-12 at 17:49 -0400, Steven Rostedt wrote:
> On Mon, 12 Oct 2020 17:42:40 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 12 Oct 2020 15:18:06 -0500
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > +static char last_cmd[MAX_FILTER_STR_VAL];
> > > +
> > > +static int errpos(const char *str)
> > > +{
> > > +	return err_pos(last_cmd, str);
> > > +}
> > > +
> > > +static void last_cmd_set(char *str)
> > > +{
> > > +	if (!str)
> > > +		return;
> > > +
> > > +	strncat(last_cmd, str, MAX_FILTER_STR_VAL - 1);  
> > 
> > If I understand strncat() correctly, it will add 'n' + 1 bytes from
> > str
> > to last_cmd. That is, I think you want:
> > 
> > 	strncat(last_cmd, str, MAX_FILTER_STR_VAL - (strlen(last_cmd) +
> > 1));
> > 
> 
> Looking at the patch more, it only has one caller to last_cmd_set(),
> and one caller to synth_err_clear().
> 
> Why not just clear on set?

Yeah, that would make sense, or just remove the clear and use strncpy
in last_cmd_set() instead.

Tom

> 
> -- Steve
> 
> 
> 
> > 
> > > +}
> > > +
> > > +static void synth_err(u8 err_type, u8 err_pos)
> > > +{
> > > +	tracing_log_err(NULL, "synthetic_events", last_cmd, err_text,
> > > +			err_type, err_pos);
> > > +}
> > > +
> > > +static void synth_err_clear(void)
> > > +{
> > > +	last_cmd[0] = '\0';
> > > +}
> > > +  
> 
> 

