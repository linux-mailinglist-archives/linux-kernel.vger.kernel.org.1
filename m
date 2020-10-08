Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62A1287C6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgJHTVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgJHTVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:21:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F7E21789;
        Thu,  8 Oct 2020 19:21:52 +0000 (UTC)
Date:   Thu, 8 Oct 2020 15:21:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] tracing: Add support for dynamic strings to
 synthetic events
Message-ID: <20201008152150.7f24dc36@gandalf.local.home>
In-Reply-To: <20201008182207.7526e70da842a01e373dd8cd@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
        <3ed35b6d0e390f5b94cb4a9ba1cc18f5982ab277.1601848695.git.zanussi@kernel.org>
        <20201008182207.7526e70da842a01e373dd8cd@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Oct 2020 18:22:07 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Some of those issues are not introduced from this series. I think
> we'd better fix those before introducing this series so that
> we can backport it to stable kernels.

I agree that these should be fixed, but I'm not sure I want to hold off
this series before they are.

-- Steve
