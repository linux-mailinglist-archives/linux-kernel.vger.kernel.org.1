Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9126E28C4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgJLWY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgJLWY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:24:57 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236302078E;
        Mon, 12 Oct 2020 22:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602541496;
        bh=ZavXKxqQpPKI7pp+tVInajKXcT4B9mJxEX2iQuTk0XE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sPUtETqmNt4ea/XkWeSW82RuAewZurXOc8+A0NKusw1RdkWU3EvrchK5X1Y+JruTR
         efOjYLdbXyXFwir0xi3+hSK+PG1SNVBu8Vr7nMhwNpNuRIdVgPNijoq1DOTG2PayzY
         r3yFQFsHGufq2E1ugcjRexXHyAF4rV0Xp7ZWY70Q=
Message-ID: <33fa1a5638b91958aa0b26069903de38a96ee3d0.camel@kernel.org>
Subject: Re: [PATCH v2 6/7] tracing: Handle synthetic event array field type
 checking correctly
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Oct 2020 17:24:54 -0500
In-Reply-To: <20201012181415.48560c8e@oasis.local.home>
References: <cover.1602533267.git.zanussi@kernel.org>
         <65a8c7dc784df121ea4b1c0060124e218f2162d0.1602533267.git.zanussi@kernel.org>
         <20201012181415.48560c8e@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2020-10-12 at 18:14 -0400, Steven Rostedt wrote:
> On Mon, 12 Oct 2020 15:18:08 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > @@ -630,8 +630,11 @@ static struct synth_field
> > *parse_synth_field(int argc, const char **argv,
> >  	if (field_type[0] == ';')
> >  		field_type++;
> >  	len = strlen(field_type) + 1;
> > -	if (array)
> > +	if (array) {
> >  		len += strlen(array);
> > +		if (array[strlen(array) - 1] == ';')
> > +			len--;
> > +	}
> 
> Why not:
> 
> 	if (array) {
> 		int l = strlen(array);
> 
> 		if (l && array[l - 1] == ';')
> 			l--;
> 		len += l;
> 	}
> 

Yeah, I think that's better, will change it.

Thanks,

Tom

> -- Steve

