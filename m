Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA572D0D13
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgLGJe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:34:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLGJe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:34:26 -0500
Date:   Mon, 7 Dec 2020 10:33:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607333625;
        bh=XCxg2s6N94uHQMR78/Ss1aKun/U23rUI97jwBlZMlUE=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=YJ/PB3TNza9aUML1mkcoBNn+4ZECY4tbbSQcjZ/VlVQzSakLkDVuM47Ca3ZFb16aH
         gQ7sHbe58ZuG1fBk3jJmuvRC/AtOs3R6oqXg+vN6BlYQEi7uBLku9d5X+XIjJLhZKU
         Orx+Oh989U/WF0cHzq3HQb8fwizhMKGV+C/mWU9rnqBKLfzwhijfKFQnO2e6XmygXm
         UsazLvpfmJaR85vRQxvFJEOWsFN2NOi8qy7FP95yqpZCEqNCghgn5YjKe8wlAHDVyt
         e5UQSyBEm9vP06me0+AoQ2yzmx7kQ2yyXT0/61E4OGKjkD1Lim0+BBU9hNPeBW/k0W
         Ka7h4/xdF2e2A==
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] improve get_feat.pl output when all features are
 displayed
Message-ID: <20201207103340.78f003f5@coco.lan>
In-Reply-To: <20201205170350.19d91c51@coco.lan>
References: <20201203153642.594afd85@lwn.net>
        <cover.1607095090.git.mchehab+huawei@kernel.org>
        <20201204144843.1ed3b988@lwn.net>
        <20201205170350.19d91c51@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 5 Dec 2020 17:03:50 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Fri, 4 Dec 2020 14:48:43 -0700
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > On Fri,  4 Dec 2020 16:32:27 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > As requested, those patches improve the output of the script, when all features
> > > are displayed.
> > > 
> > > The first patch was already posted as-is at v3.
> > > 
> > > Patch 2 is optional. IMO, it makes more sense for the admin guide to show
> > > the architectures where the features are OK, then TODO, and finally the
> > > ones that are incompatible with the features. I already sent it together
> > > with a comment.
> > > 
> > > Patch 3 is new: it tries to reduce the width of the table, in order for it
> > > to better fit on a terminal. With the patch, the number of columns were
> > > reduced, in order to better fit at console output. Before the patch, the
> > > output takes 281 lines with 158 columns (total size: 38.9 kB). 
> > > After the patch, displaying all features require 439 lines and 92 columns
> > > (total size: 37.6 kB).    
> > 
> > OK, this is much improved, thanks; applied.  
> 
> Anytime.
> 
> > 
> > The one last thing I would do is stick "valign=top" on all the table
> > entries, but we can leave the shed a different color for now :)  
> 
> I actually prefer myself valign=center on tables ;-)
> 
> In any case, a change like that should be simple to do.
> 
> either adjust:
> 
> 	Documentation/sphinx-static/theme_overrides.css
> 
> to change it globally for all tables or create a "table_valign_top" CSS
> class on it, changing the script to add:
> 
> 	.. cssclass:: table_valign_top
> 
> Before each table.

Btw, if you want to play with changing the table alignment, the
enclosed patch changes the alignment to use valign=top for all
tables (and not only for the feature ones).

Don't forget to remove the old theme before testing the
patch with:

	$ rm $(find Documentation/output/ -name theme_overrides.css)

As sphinx (at least version 2.4.4) only writes it if the file
doesn't exist.

Thanks,
Mauro

[PATCH] docs: use top-alignment for table cells

Change the table's default in order to align cells on the top,
overriding the defaults found on Read the Docs Sphinx Theme.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/Documentation/sphinx-static/theme_overrides.css b/Documentation/sphinx-static/theme_overrides.css
index 459ec5b29d68..e850859e35a0 100644
--- a/Documentation/sphinx-static/theme_overrides.css
+++ b/Documentation/sphinx-static/theme_overrides.css
@@ -42,6 +42,11 @@ p {
 	font-size: 100%;
 }
 
+/* use vertical alignment on tables */
+.rst-content table.docutils td, .rst-content table.field-list td, .wy-table td {
+    vertical-align: top;
+}
+
 /* Interim: Code-blocks with line nos - lines and line numbers don't line up.
  * see: https://github.com/rtfd/sphinx_rtd_theme/issues/419
  */


