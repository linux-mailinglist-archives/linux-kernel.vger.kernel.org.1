Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED85D1E14E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 21:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbgEYTku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 15:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388705AbgEYTku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:40:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDE8C061A0E;
        Mon, 25 May 2020 12:40:50 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 263742DC;
        Mon, 25 May 2020 19:40:50 +0000 (UTC)
Date:   Mon, 25 May 2020 13:40:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, lixinhai.lxh@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix events.rst section numbering
Message-ID: <20200525134049.1b56e132@lwn.net>
In-Reply-To: <20200522083741.7d489e91@gandalf.local.home>
References: <90ea854dfb728390b50ddf8a8675238973ee014a.camel@kernel.org>
        <20200522083741.7d489e91@gandalf.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 08:37:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 18 May 2020 13:29:24 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > The in-kernel trace event API should have its own section, and the
> > duplicate section numbers need fixing as well.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>  
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Jon,
> 
> Care to take this in your tree?

Done.

jon
