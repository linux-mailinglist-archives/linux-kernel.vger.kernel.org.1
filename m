Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC14C2D449C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbgLIOnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:43:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731748AbgLIOnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:43:24 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4960520829;
        Wed,  9 Dec 2020 14:42:43 +0000 (UTC)
Date:   Wed, 9 Dec 2020 09:42:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] tracing: Update synth command errors
Message-ID: <20201209094241.358e99ae@gandalf.local.home>
In-Reply-To: <20201209225114.9bb1f53caa5bc101a6e31a4b@kernel.org>
References: <cover.1603723933.git.zanussi@kernel.org>
        <8671adc7ce95ff1d5c7b037d371467e96f7f2914.1603723933.git.zanussi@kernel.org>
        <20201207201304.627bfe48@oasis.local.home>
        <44b9e471f0d3b77ab0a2bf11024e2e72c1f1a80d.camel@kernel.org>
        <20201208125340.407150f2@gandalf.local.home>
        <20201209225114.9bb1f53caa5bc101a6e31a4b@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 22:51:14 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> This makes sense. Anyway, what I considered were
> - synthetic_events interface doesn't provide syntax error reports
> - synthetic_events interface is not self-reproducive*.
> 
> *) I meant
> 
> $ cat synthetic_events > saved_events
> $ cat saved_events > synthetic_events
> 
>   should work. But this does *NOT* mean
> 
> $ cat user-input > synthetic_events
> $ cat synthetic_events > saved_events
> $ diff user-input saved_events # no diff
> 
> So input and output can be different, but the output can be input again.

Totally agree.

Thanks,

-- Steve
