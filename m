Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812213027B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbhAYQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730654AbhAYQWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:22:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37A1A206DC;
        Mon, 25 Jan 2021 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611591729;
        bh=jjDQ2s0twTYbDW/MrsqbUCMxfOdavt2PC/vVMg9dDIY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NsuEGi6Huh4mL18fICoNaKMa9cGxpqvZIIN9rZbm1PGENLW3tj2AveO0C06m/wnEO
         zQzx+7ND6OpTj9VknPEXKKG9Ow6715lTh5o0JPUMRxPcNmCNCw5GiB061xhmZ8e5vh
         pz575lg8cO8sqLIvUJBQmyeXYZwCiUSpCoxKN0QS0zfuGaMnJyFq+Nt/mqCq9K7uXK
         3JOhdp9PisjZdftOKBIPnHl/EMCrTLegOqZ5AsDtGQT4W0stm+hGjBOQhQXkUFlbFK
         hNeXi+ibMZHQiSa9zd3QBaRzG2XbThC1kdMaTMO0zeeW3jStuhCKICAirM1Zz7lwxg
         n/DTcKxkl8/fA==
Message-ID: <91c81c68e183f3aaa5c982c5741710788413f0db.camel@kernel.org>
Subject: Re: [PATCH v6 2/6] tracing: Rework synthetic event command parsing
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Date:   Mon, 25 Jan 2021 10:22:07 -0600
In-Reply-To: <20210122160052.4b535511@gandalf.local.home>
References: <cover.1611243025.git.zanussi@kernel.org>
         <f3c2d2841307de0a7624a250f8f9653d435602c9.1611243025.git.zanussi@kernel.org>
         <20210122160052.4b535511@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, 2021-01-22 at 16:00 -0500, Steven Rostedt wrote:
> On Thu, 21 Jan 2021 11:01:05 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > @@ -1208,13 +1173,14 @@ static int __create_synth_event(int argc,
> > const char *name, const char **argv)
> >  	 *      where 'field' = type field_name
> >  	 */
> >  
> > -	if (name[0] == '\0' || argc < 1) {
> > +	mutex_lock(&event_mutex);
> 
> I'm curious, why is the event_mutex taken here? I'm guessing it is
> first
> needed for the find_synth_event() call, in which case, it can be
> moved
> after the is_good_name() check. I don't see why the goto out is
> required
> here or for the is_good_name() check.
> 

Yes, it's for the find_synth_event() call, and yes, it should come
after the is_good_name() check.  I'll move it and fix up the goto
changes as a result.

Thanks,

Tom

> -- Steve
> 
> > +
> > +	if (name[0] == '\0') {
> >  		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
> > -		return -EINVAL;
> > +		ret = -EINVAL;
> > +		goto out;
> >  	}
> >  
> > -	mutex_lock(&event_mutex);
> > -
> >  	if (!is_good_name(name)) {
> >  		synth_err(SYNTH_ERR_BAD_NAME, errpos(name));
> >  		ret = -EINVAL;

