Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7E4265F24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgIKMBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 08:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgIKMBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:01:17 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 764A9221E7;
        Fri, 11 Sep 2020 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599825677;
        bh=FLamW02FvThhT+wWFt/TaKcylAxjJRk43AQJ6UlwNXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/TIIjpGKf6gz8pTn8bbOz2TMojhAP5ZjEFbkSjqv5kJa6JRPrgU3VjhfPSdlVb3u
         aggJjGhr1iBtzbm8ngI6YBEcSrJHtdBWcCDLoiv3nUTrzyS89g+wrwSI/WgmUDSyqE
         kRpwst74Q17x8Hrkx8X4vrYnTSQqwOKmFTEH7tSE=
Date:   Fri, 11 Sep 2020 07:06:39 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Update zero-length/one-element
 arrays section
Message-ID: <20200911120639.GC4162@embeddedor>
References: <20200901010949.GA21398@embeddedor>
 <20200909113823.50014d58@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909113823.50014d58@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 11:38:23AM -0600, Jonathan Corbet wrote:
> On Mon, 31 Aug 2020 20:09:49 -0500
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
> > Update information in the zero-length and one-element arrays section
> > and illustrate how to make use of the new flex_array_size() helper,
> > together with struct_size() and a flexible-array member.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  Documentation/process/deprecated.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Applied, thanks.

Thank you, both. :)

--
Gustavo
