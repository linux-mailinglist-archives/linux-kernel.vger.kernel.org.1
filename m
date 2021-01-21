Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6822FF507
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbhAUTr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbhAUTo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:44:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A0123A00;
        Thu, 21 Jan 2021 19:44:16 +0000 (UTC)
Date:   Thu, 21 Jan 2021 14:44:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/Kconfig: update a broken file reference
Message-ID: <20210121144415.7b2ddf3c@gandalf.local.home>
In-Reply-To: <20210121114458.614ee8da@lwn.net>
References: <20210119095326.13896-1-lukas.bulwahn@gmail.com>
        <20210121114458.614ee8da@lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 11:44:58 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> On Tue, 19 Jan 2021 10:53:26 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> 
> > Commit adab66b71abf ("Revert: "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"")
> > added the config HAVE_64BIT_ALIGNED_ACCESS back into arch/Kconfig with this
> > revert. In the meantime, commit c9b54d6f362c ("docs: move other kAPI
> > documents to core-api") changed ./Documentation/unaligned-memory-access.txt
> > to ./Documentation/core-api/unaligned-memory-access.rst.
> > 
> > Fortunately, ./scripts/documentation-file-ref-check detects this and warns
> > about this broken reference.
> > 
> > Update the file reference in arch/Kconfig.
> > 
> > Fixes: adab66b71abf ("Revert: "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > applies cleanly on current master and next-20210118
> > 
> > Steven, could you pick this fix to your commit or, at least, ack it so that
> > Jonathan can pick it?  
> 
> I've gone ahead and applied it, thanks.


Thanks Jon!

-- Steve
