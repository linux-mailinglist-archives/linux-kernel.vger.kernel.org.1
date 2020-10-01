Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C857627F773
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgJABdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgJABdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:33:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7060C20738;
        Thu,  1 Oct 2020 01:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601516031;
        bh=Q+vG1Iy21aKO3fd+yyNZHmqOXFf/RkCShrguzNHr/T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2FxZZmJseOUOR07A+317HsKMHMvskrKF9SXzq9Z+uFGE4Yo7icDsz1oxpG+zVoCg
         uk2x+JIz+1j0G7nj8kwjlm5AU9vr6KSsjSxZgix6mSb/X/3ZEmD0ZwqwHXovKQkKbS
         iyXvnYlIpTsSUhqXx3P3H57qr1yakdRNAqjZzJrA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 554BF400E9; Wed, 30 Sep 2020 22:33:49 -0300 (-03)
Date:   Wed, 30 Sep 2020 22:33:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        arnaldo.melo@gmail.com, linux-trace-devel@vger.kernel.org,
        ben@decadent.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tools lib traceevent: Hide non API functions
Message-ID: <20201001013349.GB3169811@kernel.org>
References: <20200930110733.280534-1-tz.stoyanov@gmail.com>
 <20200930125027.7e54b71c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930125027.7e54b71c@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 30, 2020 at 12:50:27PM -0400, Steven Rostedt escreveu:
> On Wed, 30 Sep 2020 14:07:33 +0300
> "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:
> 
> > There are internal library functions, which are not declared as a static.
> > They are used inside the library from different files. Hide them from
> > the library users, as they are not part of the API.
> > These functions are made hidden and are renamed without the prefix "tep_":
> >  tep_free_plugin_paths
> >  tep_peek_char
> >  tep_buffer_init
> >  tep_get_input_buf_ptr
> >  tep_get_input_buf
> >  tep_read_token
> >  tep_free_token
> >  tep_free_event
> >  tep_free_format_field
> >  __tep_parse_format
> > 
> > Link: https://lore.kernel.org/linux-trace-devel/e4afdd82deb5e023d53231bb13e08dca78085fb0.camel@decadent.org.uk/
> > Reported-by: Ben Hutchings <ben@decadent.org.uk>
> > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > ---
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Arnaldo,
> 
> Can you pull this in?

Sure, I was just waiting for this to get to some conclusion.

- Arnaldo
