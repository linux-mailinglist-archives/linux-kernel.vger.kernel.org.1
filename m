Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1232D1FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgLHBNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgLHBNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:13:47 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2578F23A3A;
        Tue,  8 Dec 2020 01:13:06 +0000 (UTC)
Date:   Mon, 7 Dec 2020 20:13:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] tracing: Update synth command errors
Message-ID: <20201207201304.627bfe48@oasis.local.home>
In-Reply-To: <8671adc7ce95ff1d5c7b037d371467e96f7f2914.1603723933.git.zanussi@kernel.org>
References: <cover.1603723933.git.zanussi@kernel.org>
        <8671adc7ce95ff1d5c7b037d371467e96f7f2914.1603723933.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 10:06:11 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Since array types are handled differently, errors referencing them
> also need to be handled differently.  Add and use a new
> INVALID_ARRAY_SPEC error.  Also add INVALID_CMD and INVALID_DYN_CMD to
> catch and display the correct form for badly-formed commands, which
> can also be used in place of CMD_INCOMPLETE, which is removed, and
> remove CMD_TOO_LONG, since it's no longer used.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---

Unfortunately, this patch series breaks user space.

I already have scripts that do the histograms, and I'm sure others may
have that too, and if we change how synthetic events are created, it
will break them.

What's the rationale for the new delimiters?

-- Steve
