Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB30A2CFC7F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgLESUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:20:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgLESEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:04:36 -0500
Date:   Sat, 5 Dec 2020 17:03:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607184234;
        bh=j6/EpsPHQza8Klw86MQJoxgPG0CYgRR+DE263FUMw0U=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=ldowca47whOC5chTBjM/tHnckWSi/4ecdFC7NmGXw03IrL/7lQD71dFwFDXkoh50n
         9RvtyWMEZ1bxMdgzqkguHXll4ZUUIs5ILgTcKKyK7TppEkgHRHi0D8yKm7mBK2dP22
         p0ylYeI2KyILMvJGcgiOmz0eOQ69I38rsa7AF/8cgj+4OZKwRCpgSoblLaULtLwBxR
         3PgMARAl0PdAy8y/G4VeUPaDx51b+kYMUU+iOYF19gRb2dzRWvknkC1d+hp7zktx1Z
         BrdGYk9Lb4kvjJW76YgKDgNwBrk0VMLnTGgZph8HvS7E3Hg1UAHR9rZYFBgMgH6zFj
         hHSw878VHfZyQ==
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] improve get_feat.pl output when all features are
 displayed
Message-ID: <20201205170350.19d91c51@coco.lan>
In-Reply-To: <20201204144843.1ed3b988@lwn.net>
References: <20201203153642.594afd85@lwn.net>
        <cover.1607095090.git.mchehab+huawei@kernel.org>
        <20201204144843.1ed3b988@lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 4 Dec 2020 14:48:43 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri,  4 Dec 2020 16:32:27 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > As requested, those patches improve the output of the script, when all features
> > are displayed.
> > 
> > The first patch was already posted as-is at v3.
> > 
> > Patch 2 is optional. IMO, it makes more sense for the admin guide to show
> > the architectures where the features are OK, then TODO, and finally the
> > ones that are incompatible with the features. I already sent it together
> > with a comment.
> > 
> > Patch 3 is new: it tries to reduce the width of the table, in order for it
> > to better fit on a terminal. With the patch, the number of columns were
> > reduced, in order to better fit at console output. Before the patch, the
> > output takes 281 lines with 158 columns (total size: 38.9 kB). 
> > After the patch, displaying all features require 439 lines and 92 columns
> > (total size: 37.6 kB).  
> 
> OK, this is much improved, thanks; applied.

Anytime.

> 
> The one last thing I would do is stick "valign=top" on all the table
> entries, but we can leave the shed a different color for now :)

I actually prefer myself valign=center on tables ;-)

In any case, a change like that should be simple to do.

either adjust:

	Documentation/sphinx-static/theme_overrides.css

to change it globally for all tables or create a "table_valign_top" CSS
class on it, changing the script to add:

	.. cssclass:: table_valign_top

Before each table.

Thanks,
Mauro
