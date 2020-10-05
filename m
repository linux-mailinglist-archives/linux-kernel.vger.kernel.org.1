Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB11283467
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJEK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgJEK71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:59:27 -0400
Received: from coco.lan (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE5B20774;
        Mon,  5 Oct 2020 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601895566;
        bh=zkJ+DHXy7q7U/z6Ji5VotkaUPd9ylktWsmGKNxhDIYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hkgD5qroZ/qT4o892izj25+aOklBhSxTv96+V097oVdGNAb1IeZb0ZD/KDmw72FdS
         W7QMuiNvsRjZYD6ms3j9uM8am5W5K8VeJd8TaRF34qRTv/P2CpmYBrBxCTsiqNtjil
         Fkky8YQXoAcRBvoWD0aTk+etv0PS+6Ps8nZ03rNk=
Date:   Mon, 5 Oct 2020 12:59:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 00/14] get rid of the remaining kernel-doc warnings when
 building the docs
Message-ID: <20201005125920.27a7768d@coco.lan>
In-Reply-To: <20201005125111.326ff7e2@coco.lan>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
        <20200910181208.GW6583@casper.infradead.org>
        <20201005125111.326ff7e2@coco.lan>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 5 Oct 2020 12:51:11 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 10 Sep 2020 19:12:08 +0100
> Matthew Wilcox <willy@infradead.org> escreveu:
> 
> > On Thu, Sep 10, 2020 at 12:23:53PM +0200, Mauro Carvalho Chehab wrote:  
> > > As described on its subject, this series finally get rid of all kernel-doc warnings.
> > > 
> > > With this series applied (plus my last series fixing other warnings), building
> > > the docs is now clean[1] against next-20200909:    
> > 
> > Thanks, this has been a truly heroic effort.
> > 
> > I'd suggest that we change the kernel build to always run the CHKDOC
> > instead of at W=1 (or rather, as the patch I just sent out demonstrates,
> > not at all (oops)).  Otherwise you're just going to have to continue
> > doing this.  
> 
> It sounds a good idea for me to run kernel-doc with W=1 - or even
> better - with allyesconfig/allmodconfig (no matter if W=0/W=1/W=2).
> 
> > At some point, perhaps we can add some other warnings at W=1, like
> > an EXPORT_SYMBOL of a function which doesn't have kernel-doc.  
> 
> Makes sense, but I suspect that supporting it is not too trivial.
> 
> I mean, a script checking for EXPORT_SYMBOL* should check not
> only the C file, but also the included header files, as the
> kernel-doc markup can be on one of its includes. 
> 
> An enhanced version of something like this:
> 
> </script>
> #!/usr/bin/perl
> 
> my $file = shift or die "Need a file name";
> 
> my @files;
> my @exports;
> 
> my $dir = $file;
> $dir =~ s,[^\/]+$,,;
> 
> push @files, $file;
> open IN, "<$file";
> while (<IN>) {
> 	push @exports, $1 if (m/^EXPORT_SYMBOL.*\(\s*(\S+)\s*\)/);
> 	push @files, "include/$1" if (m/^\s*#\s*include\s+[\<](\S+)[\>]/);
> 	push @files, "$dir/$1" if (m/^\s*#\s*include\s+[\"](\S+)[\"]/);
> }
> close IN;
> 
> my $doc;
> 
> foreach my $i (@files) {
> 	$doc .= qx(./scripts/kernel-doc $i 2>/dev/null);
> }
> 
> foreach my $e (@exports) {
> 	print "$e doesn't have kernel-doc markups\n" if (!($doc =~ m/\b$e\b/));
> }
> </script>
> 
> On simple cases, the above script helps to check what's missing:
> 
> 	$ ./check_exports drivers/acpi/acpi_lpat.c
> 	<nothing returned>
> 	$ ./test drivers/media/v4l2-core/v4l2-common.c 
> 	__v4l2_find_nearest_size doesn't have kernel-doc markups
> 	v4l2_apply_frmsize_constraints doesn't have kernel-doc markups
> 	v4l2_fill_pixfmt_mp doesn't have kernel-doc markups
> 	v4l2_fill_pixfmt doesn't have kernel-doc markups
> 
> Yet, it the actual script will also need to handle some special
> cases:
> 
> - it should check if the Makefile used by the file has a "-I" directive.
>   This could be tricky, due to Makefile recursion.

Hmm... actually this could be obtained via command line parameters, if 
the script is called with the same parameter set as the one passed to the
C compiler.

> - it should also check if there is a kernel-doc entry for such header.
>   a "git grep" could be used in this case.
> - It should also handle the optional arguments of kernel-doc, like
>   :internal", :external", ":no-identifiers", "identifiers", as it is
>   possible that there is a kernel-doc entry, but this is excluded
>   by a kernel-doc modifier.
> - It should also check if the exported symbol is a function,
>   in order to exclude static vars that are exported.
> 
> I suspect that there are several other border cases.
> 
> Thanks,
> Mauro



Thanks,
Mauro
