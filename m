Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E7C293D37
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407448AbgJTNU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407440AbgJTNU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:20:28 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A22F22265;
        Tue, 20 Oct 2020 13:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603200027;
        bh=EM7e4s4+5pfc2QXOXzbbIwsxbpXLEXnyAkoX1KJX/Fs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sb/bwgEJCIoazuGCNNwpKljOxGE2eDCMgngtQfRwAs88Ie80qwzZu+emfu+NHZwPy
         BU0zIfv9Vo2SfNEw90QJSTidpEiNtNDLCbzPpurH+eS6V/W94fQ6+bxKOojG3bV6FP
         1C2AiOGURQtlFlB//WfvhAO2nkPGzEtdpDn8bWt8=
Date:   Tue, 20 Oct 2020 22:20:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tracing: Make trace_*_run_command() more flexible
Message-Id: <20201020222024.93c023e5783cce45dc62d68a@kernel.org>
In-Reply-To: <dcdae58c4bac15e012067866afac19bca13ba7cf.camel@kernel.org>
References: <cover.1602883818.git.zanussi@kernel.org>
        <e29c3ae1fc46892ec792d6f6f910f75d0e12584c.1602883818.git.zanussi@kernel.org>
        <20201018232011.38e5da51f5cd8e73e6f529ee@kernel.org>
        <20201019001504.70dc3ec608277ed22060d2f7@kernel.org>
        <dcdae58c4bac15e012067866afac19bca13ba7cf.camel@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Mon, 19 Oct 2020 09:35:32 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Mon, 2020-10-19 at 00:15 +0900, Masami Hiramatsu wrote:
> > Hi Tom,
> > 
> > On Sun, 18 Oct 2020 23:20:11 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Hi Tom,
> > > 
> > > On Fri, 16 Oct 2020 16:48:22 -0500
> > > Tom Zanussi <zanussi@kernel.org> wrote:
> > > 
> > > > trace_run_command() and therefore functions that use it, such as
> > > > trace_parse_run_command(), uses argv_split() to split the command
> > > > into
> > > > an array of args then passed to the callback to handle.
> > > > 
> > > > This works fine for most commands but some commands would like to
> > > > allow the user to use and additional separator to visually group
> > > > items
> > > > in the command.  One example would be synthetic event commands,
> > > > which
> > > > use semicolons to group fields:
> > > > 
> > > >   echo 'event_name int a; char b[]; u64 lat' >> synthetic_events
> > > > 
> > > > What gets passed as an args array to the command for a command
> > > > like
> > > > this include tokens that have semicolons included with the token,
> > > > which the callback then needs to strip out, since argv_split()
> > > > only
> > > > looks at whitespace as a separator.
> > > > 
> > > > It would be nicer to just have trace_run_command() strip out the
> > > > semicolons at its level rather than passing that task onto the
> > > > callback. To accomplish that, this change adds an
> > > > 'additional_sep'
> > > > arg to a new __trace_run_command() function that allows a caller
> > > > to
> > > > pass an additional separator char that if non-zero simply
> > > > replaces
> > > > that character with whitespace before splitting the command into
> > > > args.
> > > > The original trace_run_command() remains as-is in this regard,
> > > > simply
> > > > calling __trace_run_command() with 0 for the separator, while
> > > > making a
> > > > new trace_run_command_add_sep() version that can be used to pass
> > > > in a
> > > > separator.
> > > 
> > > No, I don't like to tweak trace_run_command() that way, I'm OK to
> > > delegate the argv_split() totally to the callback function (pass
> > > the raw command string to the callback), OR __create_synth_event()
> > > concatinate the fields argv and parse it by itself (I think the
> > > latter is better and simpler).
> > > 
> > > The ";" separator is not an additinal separator but that is higher
> > > level separator for synthetic event. Suppose that you get the
> > > following input;
> > >  "myevent int c ; char b"
> > >  "myevent int;c;char;b;"
> > > These should not be same for the synthetic events. The fields must
> > > be
> > > splitted by ';' at first, and then each field should be parsed.
> > > 
> > > So, I recommend you not to pass the additional separator to the
> > > generic function, but (since it is only for synthetic event) to
> > > reconstruct the raw command from argv, and parse it again with
> > > ";" inside synthetic event parser. Then each fields parser can
> > > check that is a wrong input or not.
> > > 
> > > It will be something like
> > > 
> > > __create_synth_event(argc, argv)
> > > {
> > > 	<event-name parsing>
> > > 	argc--; argv++;
> > > 
> > > 	raw_fields = concat_argv(argc, argv);// you can assume argv is
> > > generated by argv_split().
> > > 	vfields = split_fields(raw_fields, &nfields);// similar to
> > > argv_split()
> > > 	for (i = 0; i < nfields; i++)
> > > 		parse_synth_field(vfields[i]);
> > > }
> > > 
> > > Then, you don't need to change the generic functions, and also
> > > you will get the correct parser routines.
> > 
> > If you think the split->concat->split process is redundant, I think
> > we
> > can remove trace_run_command() and just pass a raw command string to
> > each
> > event command parser as I said above.
> > 
> > In this way, each event create function can parse the command by
> > themselves.
> > So you can parse the command as you like.
> > 
> > Here is the patch which modifies trace-{k,u}probe and trace-dynevent
> > side, but not changing synthetic event side yet. Will this help you?
> > 
> 
> Yeah, it was probably a mistake to try to shoehorn synthetic events
> into the unmodified trace_run_command() in the first place.
> 
> This should work for me - I'll build on it.  Thanks for supplying it!

Yeah, feel free to merge your patch if you need, since this is
incomplete patch, not good for bisecting.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
