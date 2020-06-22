Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6A1203DED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 19:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgFVR32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 13:29:28 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:60360 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729605AbgFVR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:29:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4DE6318026A02;
        Mon, 22 Jun 2020 17:29:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:901:960:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:2902:3138:3139:3140:3141:3142:3353:3622:3653:3657:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6117:6119:6742:6743:7901:7903:8814:10004:10400:10848:11232:11257:11658:11854:11914:12043:12297:12740:12760:12895:13069:13149:13230:13311:13357:13439:14094:14181:14659:14721:21080:21451:21627:21740:21939:21990:30012:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: need47_4e04c3f26e34
X-Filterd-Recvd-Size: 3750
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jun 2020 17:29:22 +0000 (UTC)
Message-ID: <adf85348dcbfbf64157e6519115b3a0c9f35df55.camel@perches.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/process
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 22 Jun 2020 10:29:20 -0700
In-Reply-To: <CANiq72m6BNYe2ETNXJ2oLc6Jzad6kBBJK7_dz+BwZCeqYFXZqg@mail.gmail.com>
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
         <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
         <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
         <CANiq72=Y+beqZ8Dmieo_GKbyaLN8Nf1n3bVntj_o90Cn-nADRQ@mail.gmail.com>
         <20200622070623.086f1623@lwn.net>
         <CANiq72m6BNYe2ETNXJ2oLc6Jzad6kBBJK7_dz+BwZCeqYFXZqg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-22 at 19:03 +0200, Miguel Ojeda wrote:
> On Mon, Jun 22, 2020 at 3:06 PM Jonathan Corbet <corbet@lwn.net> wrote:
> > As has been noted elsewhere, checkpatch.pl seems like the appropriate
> > place to make this check.  As for "the entire tree"...if this job gets
> > completed, "git grep" should be a fine way to do that.
> 
> `checkpatch` is not really enforced in many subsystems, no? Further,
> some existing and future HTTP links may support HTTPS later on.
> 
> As for `git grep`, agreed if we reach near 100%. Otherwise, no. In the
> general case, including the code for a task that has some likelihood
> of needing repetition is a safe bet, which is why I suggested it. The
> same script could be also used to check for broken links and related
> maintenance.

scripts/get_maintainer.pl --self-test=links has a reachability test
using wget.

Perhaps a script like that could be used for http:// vs https://

	## Link reachability
	} elsif (($type eq "W" || $type eq "Q" || $type eq "B") &&
		 $value =~ /^https?:/ &&
		 ($self_test eq "" || $self_test =~ /\blinks\b/)) {
	    next if (grep(m@^\Q$value\E$@, @good_links));
	    my $isbad = 0;
	    if (grep(m@^\Q$value\E$@, @bad_links)) {
	        $isbad = 1;
	    } else {
		my $output = `wget --spider -q --no-check-certificate --timeout 10 --tries 1 $value`;
		if ($? == 0) {
		    push(@good_links, $value);
		} else {
		    push(@bad_links, $value);
		    $isbad = 1;
		}
	    }
	    if ($isbad) {
	        print("$x->{file}:$x->{linenr}: warning: possible bad link\t$x->{line}\n");
	    }


