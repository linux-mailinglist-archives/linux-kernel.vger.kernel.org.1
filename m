Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529E828B499
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbgJLM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388334AbgJLM15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:27:57 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1098C20708;
        Mon, 12 Oct 2020 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602505676;
        bh=59oCIjsJ1RnqsEKDFdcIlGF19qeI1cmuvdFDSYDMqPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yL++0nK1IJxw7lJh/t8BWWrR2pEmL6hzOw6KfjjXH38nQz42t0lV+aNhETYAHRSGl
         YZKlgqhBi3F73W9/2G5Z7+LXHW7h1/RidGnZRsEsFhuEmfXR32QOllavshxbfCrazc
         6Vk2+Xm12rjajbpI7Kt/P8uhGyZN65gQjiTqA+oM=
Date:   Mon, 12 Oct 2020 14:27:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: Re: [PATCH] scripts: kernel-doc: allow passing desired Sphinx C
 domain dialect
Message-ID: <20201012142750.5073109a@coco.lan>
In-Reply-To: <20201006080134.07d94d26@lwn.net>
References: <ee1f16453ad40eae2603adfde5f6dda3ab1befc7.1601798520.git.mchehab+huawei@kernel.org>
        <20201005101736.7adf4f46@lwn.net>
        <20201006084207.125c88d5@coco.lan>
        <20201006080134.07d94d26@lwn.net>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 6 Oct 2020 08:01:34 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue, 6 Oct 2020 08:42:07 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > As right now we don't support Sphinx version 3.0[1], we're actually using just
> > $sphinx_major. So, I'm wonder if it would make sense to also make <minor>
> > optional.  
> 
> Maybe...someday we may need it, knowing how the Sphinx folks approach
> compatibility, but I guess we can always add it then if so.
> 
> > The change would be trivial, although the regex will become even more
> > harder to read ;-)  
> 
> 	^(\d+)(\.(\d+)){,2}
> 
> ?  (untested, of course)

Didn't work (perl complains about its syntax), and neither:

	^(\d+)(\.(\d+)){0,2}

I also tried this:

	^(\d+)(?:\.(\d+)){0,2}

But both ends misplacing the second group information when
x.y.z is used.

On the tests I did, this is the one that worked fine:

	if ($ver_string =~ m/^(\d+)(?:\.(\d+))?(?:\.(\d+))?/) {
	    $sphinx_major = $1;
	    if (defined($2)) {
		$sphinx_minor = $2;
	    } else {
		$sphinx_minor = 0;
	    }
	    if (defined($3)) {
		$sphinx_patch = $3
	    } else {
		$sphinx_patch = 0;
	    }

Or the alternative one, using substrings:

	if ($ver_string =~ m/^(\d+)(\.\d+)?(\.\d+)?/) {
	    $sphinx_major = $1;
	    if (defined($2)) {
		$sphinx_minor = substr($2,1);
	    } else {
		$sphinx_minor = 0;
	    }
	    if (defined($3)) {
		$sphinx_patch = substr($3,1)
	    } else {
		$sphinx_patch = 0;
	    }
	}

I'll keep the last one, as it is likely simpler to understand.

> 
> > [1] not sure how valuable would be adding support for Sphinx 3.0. While
> > I didn't make any tests, I'm strongly suspecting that, with the approach
> > we took for backward/forward compatibility, adding support for it
> > would mean to just do a trivial change at cdomain.py by applying a
> > patch that Markus did replacing a regex function that doesn't exist
> > anymore at Sphinx API and emulating C namespace with the logic I
> > already implemented.   
> 
> 3.0 might just be skippable at this point, methinks.  

Yeah, agreed. 

I'll fold the latest version of this patch with the following diff.

Thanks,
Mauro

index 297312824d26..c8f6b11d5da1 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -466,11 +466,15 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	$show_not_found = 1;  # A no-op but don't fail
     } elsif ($cmd eq "sphinx-version") {
 	my $ver_string = shift @ARGV;
-	if ($ver_string =~ m/^(\d+)\.(\d+)(\.\d+)?/) {
+	if ($ver_string =~ m/^(\d+)(\.\d+)?(\.\d+)?/) {
 	    $sphinx_major = $1;
-	    $sphinx_minor = $2;
+	    if (defined($2)) {
+		$sphinx_minor = substr($2,1);
+	    } else {
+		$sphinx_minor = 0;
+	    }
 	    if (defined($3)) {
-		$sphinx_patch = substr($3,1);
+		$sphinx_patch = substr($3,1)
 	    } else {
 		$sphinx_patch = 0;
 	    }
@@ -2368,7 +2372,10 @@ sub process_file($) {
 }
 
 
-get_sphinx_version() if (!$sphinx_major);
+if ($output_mode eq "rst") {
+	get_sphinx_version() if (!$sphinx_major);
+}
+
 $kernelversion = get_kernel_version();
 
 # generate a sequence of code that will splice in highlighting information


