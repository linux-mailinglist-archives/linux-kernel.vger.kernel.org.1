Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4011CB98C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 23:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgEHVK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 17:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgEHVK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:10:58 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31DCB2173E;
        Fri,  8 May 2020 21:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588972257;
        bh=qqkVr4kTP0XXZVP5xFbn1niXGfNe06721rm6KoYrYkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qOzEFrdYz4YFcUHf49CJNi5f+sr73JPUOQI3aOAdobR3CsvYuEjo+/oWD/KiOaP8z
         IuVw3ckU8nlAcMVQNCd4/X77zD3VtuOZzCvnHHTbk6C96q6/E3yH/6rD3Mxwm42C2B
         tHqidnAS9xxjOGCQAVjSPsEha1GnutMIYT5rtV1k=
Date:   Fri, 8 May 2020 16:15:25 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] audit: mark expected switch fall-through
Message-ID: <20200508211525.GE23375@embeddedor>
References: <20190212204600.GA24049@embeddedor>
 <CAHC9VhQfru298ZbEDwEqj0+YRAYoAGhAVHEtSo3KBW1kKLputw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQfru298ZbEDwEqj0+YRAYoAGhAVHEtSo3KBW1kKLputw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 08:19:44PM -0500, Paul Moore wrote:
> On Tue, Feb 12, 2019 at 3:46 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> >
> > This patch fixes the following warning:
> >
> > kernel/auditfilter.c: In function ‘audit_krule_to_data’:
> > kernel/auditfilter.c:668:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >     if (krule->pflags & AUDIT_LOGINUID_LEGACY && !f->val) {
> >        ^
> > kernel/auditfilter.c:674:3: note: here
> >    default:
> >    ^~~~~~~
> >
> > Warning level 3 was used: -Wimplicit-fallthrough=3
> >
> > Notice that, in this particular case, the code comment is modified
> > in accordance with what GCC is expecting to find.
> >
> > This patch is part of the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  kernel/auditfilter.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Merged into audit/next, thanks.
> 

Thanks, Paul.

--
Gustavo
