Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA72D3132
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgLHRf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgLHRf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:35:27 -0500
Message-ID: <44b9e471f0d3b77ab0a2bf11024e2e72c1f1a80d.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607448885;
        bh=bL6BKZCG/gd/rumYLQKb1gaCJvC399/JnNwCkUwnhjs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IpCOujcF+tsbEZ8bz+6d1Lvi4lnn+oZC1kOtNK3E8iCvzOFS3qMh2CynseTzvZCXQ
         vvWdcwrPqQ/CEIoynodNlKlSKJ808tqKpSrs8vTQyriV6gCVO6ZK331IdAwnpksSTB
         TI6iMnA+R94WrM3U7HJxpisDuLJgMvQ845hm0QkUIO2cO9RHqUxpWRqtsUdh2qbkc3
         L0COUwoVojVaxVvywogSt/FvwK2rVHH3v5n6zcD+I8LJobf6KMn1qJUkQ/h37WBd1C
         mKXX1N1iN4kSROEQeLg55SRm8YM1UVQxJtNMdjatHXbx2t2XPxoymnyqRlKFEpxDbo
         OsGBXStccSgBQ==
Subject: Re: [PATCH v3 3/5] tracing: Update synth command errors
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Dec 2020 11:34:41 -0600
In-Reply-To: <20201207201304.627bfe48@oasis.local.home>
References: <cover.1603723933.git.zanussi@kernel.org>
         <8671adc7ce95ff1d5c7b037d371467e96f7f2914.1603723933.git.zanussi@kernel.org>
         <20201207201304.627bfe48@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2020-12-07 at 20:13 -0500, Steven Rostedt wrote:
> On Mon, 26 Oct 2020 10:06:11 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Since array types are handled differently, errors referencing them
> > also need to be handled differently.  Add and use a new
> > INVALID_ARRAY_SPEC error.  Also add INVALID_CMD and INVALID_DYN_CMD
> > to
> > catch and display the correct form for badly-formed commands, which
> > can also be used in place of CMD_INCOMPLETE, which is removed, and
> > remove CMD_TOO_LONG, since it's no longer used.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> 
> Unfortunately, this patch series breaks user space.
> 
> I already have scripts that do the histograms, and I'm sure others
> may
> have that too, and if we change how synthetic events are created, it
> will break them.
> 
> What's the rationale for the new delimiters?
> 

The overall problem this is trying to fix is that it was probably a
mistake to try to shoehorn the synthetic event parsing into what was
available from  trace_run_command() and trace_parse_run_command(),
which use argv_split() to do the command splitting, and which only
splits on whitespace.  Whereas the synthetic events have a bit of a
higher-level structure which is 'event field; field; field;...'

So this patchset tries to remedy that - the first patch,
(tracing/dynevent: Delegate parsing to create function) is from Masami,
and makes it possible to share code between kprobe/uprobe and synthetic
evnents, and to allow synthetic events to have their own higher-level
parsing, which the next 2 patches do.

The history in more detail:

Initially the problem was to fix the errors mentioned by Masami in
[1]. 

Things like:

  # echo myevent char str[];; int v >> synthetic_events

which was identified as INVALID_TYPE where it should just be a void arg
and

  # echo mye;vent char str[] >> synthetic_events

which was identified as BAD_NAME where it should have been an invalid
command, etc.

I suggested that the way to fix them was to consider semicolon as
additional whitespace and the result was the patchset containing [2],
which also explains the reasons for wanting to enforce semicolon
grouping.

Masami pointed out that it really wasn't correct to do it that way,
and  the commands should be split out first at the higher level by
semicolon and then further processed [3].

Unfortunately, you're correct, if you have a script that creates a
synthetic event without semicolons, this patchset will break it, as I
myself found out and fixed in patch 4 ([PATCH v3 4/5] selftests/ftrace:
Add synthetic event field separators) [4].

So whereas before this would work, even though it shouldn't have in the
first place:

  # echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' >
synthetic_events

it now has to be:

  # echo 'wakeup_latency  u64 lat; pid_t pid; char comm[16]' >
synthetic_events

So yeah, this patchset fixes a set of parsing bugs for things that
shouldn't have been accepted as valid, but shouldn't break things that
are obviously valid.

If it's too late to fix them, though, I guess we'll just have to live
with them, or some other option?

Tom

[1] https://lore.kernel.org/lkml/20201014110636.139df7be275d40a23b523b84@kernel.org/
[2] https://lore.kernel.org/lkml/e29c3ae1fc46892ec792d6f6f910f75d0e12584c.1602883818.git.zanussi@kernel.org/
[3] https://lore.kernel.org/lkml/20201018232011.38e5da51f5cd8e73e6f529ee@kernel.org/
[4] https://lore.kernel.org/lkml/75a2816b4001e04e7d60bcc87aa91477ad5d90b3.1603723933.git.zanussi@kernel.org/



> -- Steve

