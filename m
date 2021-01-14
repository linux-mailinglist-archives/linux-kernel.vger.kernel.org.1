Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC6C2F635D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbhANOpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbhANOpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:45:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E028D22A84;
        Thu, 14 Jan 2021 14:44:42 +0000 (UTC)
Date:   Thu, 14 Jan 2021 09:44:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Add tracing_on support to helper
 scripts
Message-ID: <20210114094441.6e205ebe@gandalf.local.home>
In-Reply-To: <20210114155034.1132dc7d1c80a3da6a26d554@kernel.org>
References: <160749166410.3497930.14204335886811029800.stgit@devnote2>
        <20210113181158.1b9df04c@gandalf.local.home>
        <20210114155034.1132dc7d1c80a3da6a26d554@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 15:50:34 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 13 Jan 2021 18:11:58 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > 
> > Just noticed this patch. I'm adding it into my queue for the next merge
> > window, as it doesn't look too urgent.  
> 
> Yes, it is not urgent, but it might be better to backport to 5.10.
>

If it's something that should be backported, then I should send it now with
a stable tag.

-- Steve
