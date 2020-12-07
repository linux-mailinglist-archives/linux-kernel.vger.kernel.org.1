Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB82D0F31
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgLGLe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbgLGLew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:52 -0500
Date:   Mon, 7 Dec 2020 12:34:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607340851;
        bh=zDIETDHk2l9keLNMdZTm+aIva3m+VgjR3sjWorgThBE=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=fopbqknw6WUbW41eUjPZB7KDEyrbGO5vr8Q9x/6fGmVhR9QVLTKwFnrwEu280EPNM
         0CjF1a9D2mssqpxul/M68EI9OZbHvdq5yVPDc9YYLafIzv+XQusvAdiemZ8Nc4HYlc
         hxPiZHSCJgnWLbNDlyDHxQzHfbi7mOGSVd53Jh9tfOUDNpAx56dMHGM3EgKse51dnp
         LCCFzzVvZc4AzqwiWLoSiFNNNp/BPfmM+NuLSKw68s5/Uh7lpNORcCIqFmRl523hVF
         Mktcq1eTqW6o/Kz2YYe4b9aDDZXbq0jg/qDuiO83iVkYxF9gv8O1OHVD3aWtbuyOlO
         bCjILNlGEEJ8w==
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] improve get_feat.pl output when all features are
 displayed
Message-ID: <20201207123406.3863d221@coco.lan>
In-Reply-To: <20201207103340.78f003f5@coco.lan>
References: <20201203153642.594afd85@lwn.net>
        <cover.1607095090.git.mchehab+huawei@kernel.org>
        <20201204144843.1ed3b988@lwn.net>
        <20201205170350.19d91c51@coco.lan>
        <20201207103340.78f003f5@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 7 Dec 2020 10:33:40 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Sat, 5 Dec 2020 17:03:50 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
> > Em Fri, 4 Dec 2020 14:48:43 -0700
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >   
> > > On Fri,  4 Dec 2020 16:32:27 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > As requested, those patches improve the output of the script, when all features
> > > > are displayed.
> > > > 
> > > > The first patch was already posted as-is at v3.
> > > > 
> > > > Patch 2 is optional. IMO, it makes more sense for the admin guide to show
> > > > the architectures where the features are OK, then TODO, and finally the
> > > > ones that are incompatible with the features. I already sent it together
> > > > with a comment.
> > > > 
> > > > Patch 3 is new: it tries to reduce the width of the table, in order for it
> > > > to better fit on a terminal. With the patch, the number of columns were
> > > > reduced, in order to better fit at console output. Before the patch, the
> > > > output takes 281 lines with 158 columns (total size: 38.9 kB). 
> > > > After the patch, displaying all features require 439 lines and 92 columns
> > > > (total size: 37.6 kB).      
> > > 
> > > OK, this is much improved, thanks; applied.    
> > 
> > Anytime.
> >   
> > > 
> > > The one last thing I would do is stick "valign=top" on all the table
> > > entries, but we can leave the shed a different color for now :)    
> > 
> > I actually prefer myself valign=center on tables ;-)
> > 
> > In any case, a change like that should be simple to do.
> > 
> > either adjust:
> > 
> > 	Documentation/sphinx-static/theme_overrides.css
> > 
> > to change it globally for all tables or create a "table_valign_top" CSS
> > class on it, changing the script to add:
> > 
> > 	.. cssclass:: table_valign_top
> > 
> > Before each table.  
> 
> Btw, if you want to play with changing the table alignment, the
> enclosed patch changes the alignment to use valign=top for all
> tables (and not only for the feature ones).
> 
> Don't forget to remove the old theme before testing the
> patch with:
> 
> 	$ rm $(find Documentation/output/ -name theme_overrides.css)
> 
> As sphinx (at least version 2.4.4) only writes it if the file
> doesn't exist.

Btw, if you want to vertically align just some tables - like the
ones produced by get_feat.pl, the enclosed patch should do the
job.

-

PS.: It seems worth mentioning here, as others may find issues when
trying to customize the Kernel-specific CSS styles.

It took me a while to find a way for the style to be properly
applied, due to CSS Specificity[1].

[1] I don't usually deal with CSS style sheets :-)
    So, had to do some research and lots of tests.

    Those are two useful references about that:
	https://stackoverflow.com/questions/12258596/class-overrule-when-two-classes-assigned-to-one-div
	https://www.smashingmagazine.com/2007/07/css-specificity-things-you-should-know/
	
The thing is that the tables (tested with Sphinx 2.4.4) are created
with multiple classes:

	<table class="top-aligned docutils align-default">

As the user-specified class (top-aligned) is the first one (instead of
the last one), it has less precedence than "docutils" or "align-default"
classes.

So, if one specifies at the CSS file just:

	.top-aligned {
		vertical-align: top;
		color: red;
	}

The table color will change to red as expected, but the vertical-align 
will be overridden by the other classes.

So, we need to place all classes there, in order to increase
the CSS Specificity:

	table.top-aligned.docutils.align-default td {
		vertical-align: top;
	}

Thanks,
Mauro

[PATCH] scripts: get_feat.pl: align tables vertically on top

In order to make the full features tables, align
them on the top.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/Documentation/sphinx-static/theme_overrides.css b/Documentation/sphinx-static/theme_overrides.css
index 459ec5b29d68..7ccf69d005fc 100644
--- a/Documentation/sphinx-static/theme_overrides.css
+++ b/Documentation/sphinx-static/theme_overrides.css
@@ -42,6 +42,11 @@ p {
 	font-size: 100%;
 }
 
+/* use vertical alignment on tables */
+table.top-aligned.docutils.align-default td {
+	vertical-align: top;
+}
+
 /* Interim: Code-blocks with line nos - lines and line numbers don't line up.
  * see: https://github.com/rtfd/sphinx_rtd_theme/issues/419
  */
diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 457712355676..f5725803063e 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -410,6 +410,7 @@ sub output_matrix {
 			print "$title\n";
 			print "=" x length($title) . "\n\n";
 
+			print ".. cssclass:: top-aligned\n\n";
 
 			matrix_lines($desc_size, $status_size, 0);
 

