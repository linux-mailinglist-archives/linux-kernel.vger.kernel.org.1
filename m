Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188AB2D3239
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgLHScx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgLHScu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:32:50 -0500
Message-ID: <d44d45dfd9d540b7dae7d645ce05a3f7bb79c03c.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607452330;
        bh=1jrzgTIJpW1sSBE3ZIOppEbfh6AvSKZMoSp0P40Y68Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BU/L4KzCjzCyvQ/rLg2QtY/05SEsveztssPsOTsWEDvqljd1hcvPYiglLC59NDEs7
         mDE+2ZtdDkkDSoaYsZGwjWxKqiWbMM9nnrQ4/1MBEf/4rIh83TiTFK/ouerzFtZl8+
         mlwsB5jikzLisC5W61TDZAxB7AvVUjlVCzrfXohE0X55dG1DDc6FTRmy1uopzEhYeu
         pGwA4aRcPww2qYIMY3unhif/YGZ1Udd/WH+0nCEgcm+bOTQ0+eSluhi8UUVXe2lkHt
         IdcHdzAGAV3K1Mre8MQUox/5tsAN3XdSPu2EanwV5BgWUxdfSteeGOENQjU/d5vfAU
         tj4CKZP9UlH2A==
Subject: Re: [PATCH v3 3/5] tracing: Update synth command errors
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Dec 2020 12:32:08 -0600
In-Reply-To: <20201208125340.407150f2@gandalf.local.home>
References: <cover.1603723933.git.zanussi@kernel.org>
         <8671adc7ce95ff1d5c7b037d371467e96f7f2914.1603723933.git.zanussi@kernel.org>
         <20201207201304.627bfe48@oasis.local.home>
         <44b9e471f0d3b77ab0a2bf11024e2e72c1f1a80d.camel@kernel.org>
         <20201208125340.407150f2@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 2020-12-08 at 12:53 -0500, Steven Rostedt wrote:
> On Tue, 08 Dec 2020 11:34:41 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Unfortunately, you're correct, if you have a script that creates a
> > synthetic event without semicolons, this patchset will break it, as
> > I
> > myself found out and fixed in patch 4 ([PATCH v3 4/5]
> > selftests/ftrace:
> > Add synthetic event field separators) [4].
> > 
> > So whereas before this would work, even though it shouldn't have in
> > the
> > first place:
> > 
> >   # echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' >
> > synthetic_events
> > 
> > it now has to be:
> > 
> >   # echo 'wakeup_latency  u64 lat; pid_t pid; char comm[16]' >
> > synthetic_events
> > 
> > So yeah, this patchset fixes a set of parsing bugs for things that
> > shouldn't have been accepted as valid, but shouldn't break things
> > that
> > are obviously valid.
> > 
> > If it's too late to fix them, though, I guess we'll just have to
> > live
> > with them, or some other option?
> 
> 
> I would suggest allowing the old interface work (with no new
> features, for
> backward compatibility), but new things like "char comm[16]" we
> require
> semicolons.
> 
> One method to do this is to add to the start of reading the string,
> and
> checking if it has semicolons. If it does not, we create a new string
> with
> them, but make sure that the string does not include new changes.
> 
> 	strncpy_from_user(buffer, user_buff, sizeof(buffer));
> 
> 	if (!strstr(buffer, ";")) {
> 		if (!audit_old_buffer(buffer))
> 			goto error;
> 		insert_colons(buffer);
> 	}
> 
> 
> That is, if the buffer does not have semicolons, then check if it is
> a
> valid "old format", and if not, we error out. Otherwise, we insert
> the
> colons into the buffer, and process that as if the user put in
> colons:
> 
> That is:
> 
> 	echo 'wakeup_latency u64 lat pid_t pid' > synthetic_events
> 
> would change the buffer to:
> 
> 	"wakeup_latency u64 lat; pid_t pid;"
> 
> And then put it through the normal processing. I think its OK that if
> the
> user were to cat out the synthetic events, it would see the
> semicolons even
> if it did not add them. As I don't think that will break userspace.
> 
> Does that make sense?
> 

Yeah, that should work, I'll try adding that.

Thanks,

Tom

> -- Steve

