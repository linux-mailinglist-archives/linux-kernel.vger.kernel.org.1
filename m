Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A80729DEFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbgJ2A6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731579AbgJ1WRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:32 -0400
Received: from coco.lan (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D94CC247B1;
        Wed, 28 Oct 2020 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603897842;
        bh=frQPh95E8HRn9ZnqjsC3ZJ+933VuymG+SYH3O260e+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=weN6FXtBng9K18ddo1TKfapkVnWm0vxYEwEBfwOCQApwdpzsfIDnzXV9vSmiu7+eP
         B96JFlb81bjwmSe9bFURwP5sgpUwhpeiWIU/5wjJzPxHypUwAvcsGTalnS7d+up+9Q
         jg81B/KNSMj7pbCUxEWpjU2CLsur2W6HVKaBXB5M=
Date:   Wed, 28 Oct 2020 16:10:30 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Anton Vorontsov <anton@enomsg.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Benson Leung <bleung@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Colin Cross <ccross@android.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Richard Cochran <richardcochran@gmail.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Tony Luck <tony.luck@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 00/33] ABI: add it to the documentation build system
Message-ID: <20201028161030.4e88b297@coco.lan>
In-Reply-To: <20201028143937.GA2302095@kroah.com>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
        <20201028143937.GA2302095@kroah.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 28 Oct 2020 15:39:37 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Wed, Oct 28, 2020 at 03:22:58PM +0100, Mauro Carvalho Chehab wrote:
> > Hi Greg,
> > 
> > As requested, this is a rebased version on the top of v5.10-rc1
> > adding support for having the Linux ABI documentted inside
> > the Linux admin manual.
> > 
> > When compared with the version I sent years ago, this
> > version has:
> > 
> > - a logic to detect duplicated ABI symbols;
> > - it auto-generate cross-reference markups for ABI symbols,
> >   ABI files and .rst files;
> > - Other files from 5.10-rc1 required adjustments in order
> >   to be accepted by the script in rst-source mode;
> > - Some bug fixes.
> > 
> > PS.: I didn't try to merge it against linux-next yet. So,
> > I won't doubt that applying it could cause some conflicts.
> > 
> > Feel free to review it.  
> 
> After applying the first 10 patches, and running it, I see a bunch of
> these types of warnings:
> 
> Use of uninitialized value $kernelversion in substitution (s///) at ./scripts/get_abi.pl line 444.
> Use of uninitialized value $users in substitution (s///) at ./scripts/get_abi.pl line 446.
> Use of uninitialized value $users in substitution (s///) at ./scripts/get_abi.pl line 447.

Hmm.. I didn't test search after adding "use warnings".

The thing is that "use warnings" was added on one of get_abi.pl
patches, just to be sure that some ABI parsers were 100%.

That makes perl very pedantic, as it won't accept things like:

	my $foo;
	...
	my $bar = $foo;

Without "warnings", $bar will be undefined, and everything
works properly, but, when this used, the above will still
work properly, but will start producing warnings like the
one you're seeing.

I'm enclosing a diff addressing it for "search" mode.

It should be fold on this patch:

	scripts: get_abi.pl: cleanup ABI cross-reference logic

Which is the one that added "use warnings".

Feel free to fold it there. Otherwise, I'll fold it and
send you on a v2 of this series.

> 
> When doing something like:
> $ ./scripts/get_abi.pl search usb --dir Documentation/ABI/stable/
> 
> Is that expected?
> 
> thanks,
> 
> greg k-h


Thanks,
Mauro

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index bdef3e5c35c7..00b6ddec0ebb 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -442,17 +442,20 @@ sub search_symbols {
 
 		print "\n$what\n$bar\n\n";
 
-		my $kernelversion = $data{$what}->{kernelversion};
-		my $contact = $data{$what}->{contact};
-		my $users = $data{$what}->{users};
-		my $date = $data{$what}->{date};
-		my $desc = $data{$what}->{description};
-		$kernelversion =~ s/^\s+//;
-		$contact =~ s/^\s+//;
-		$users =~ s/^\s+//;
-		$users =~ s/\n//g;
-		$date =~ s/^\s+//;
-		$desc =~ s/^\s+//;
+		my $kernelversion = $data{$what}->{kernelversion} if (defined($data{$what}->{kernelversion}));
+		my $contact = $data{$what}->{contact} if (defined($data{$what}->{contact}));
+		my $users = $data{$what}->{users} if (defined($data{$what}->{users}));
+		my $date = $data{$what}->{date} if (defined($data{$what}->{date}));
+		my $desc = $data{$what}->{description} if (defined($data{$what}->{description}));
+
+		$kernelversion =~ s/^\s+// if ($kernelversion);
+		$contact =~ s/^\s+// if ($contact);
+		if ($users) {
+			$users =~ s/^\s+//;
+			$users =~ s/\n//g;
+		}
+		$date =~ s/^\s+// if ($date);
+		$desc =~ s/^\s+// if ($desc);
 
 		printf "Kernel version:\t\t%s\n", $kernelversion if ($kernelversion);
 		printf "Date:\t\t\t%s\n", $date if ($date);


