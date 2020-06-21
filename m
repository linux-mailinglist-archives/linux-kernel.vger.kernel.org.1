Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D49202BE1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 19:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgFURmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 13:42:44 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:39284 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730524AbgFURmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 13:42:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9471A18224D6E;
        Sun, 21 Jun 2020 17:42:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:116:355:379:599:800:901:960:967:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2562:2828:2945:3138:3139:3140:3141:3142:3352:3622:3657:3865:3866:3867:3936:3953:4250:4321:4605:5007:6117:6742:6743:7901:8814:9388:10004:10400:10848:11232:11473:11658:11914:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30060:30062:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: top74_3b0614726e2c
X-Filterd-Recvd-Size: 2913
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Jun 2020 17:42:39 +0000 (UTC)
Message-ID: <2c60a30eb1fd3616fccd496e76d3d1cc54afc732.camel@perches.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/process
From:   Joe Perches <joe@perches.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
Date:   Sun, 21 Jun 2020 10:42:38 -0700
In-Reply-To: <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
         <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
         <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-06-21 at 16:30 +0200, Alexander A. Klimov wrote:
> Am 21.06.20 um 15:46 schrieb Miguel Ojeda:
> > On Sun, Jun 21, 2020 at 3:37 PM Alexander A. Klimov
> > <grandmaster@al2klimov.de> wrote:
[]
> > >              Replace HTTP with HTTPS.
[]
> W/o a 
> such central "rule on how to HTTPSify links"

Maybe:
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 524df88f9364..4e49187a6137 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3115,6 +3115,12 @@ sub process {
 			}
 		}
 
+# check for URLs using old http:// links, suggest https:
+		if ($rawline =~ m{^\+.*\bhttp://}) {
+			WARN("HTTP_URL",
+			     "Prefer URLs using https: over http:\n" . $herecurr);
+		}
+
 # discourage the use of boolean for type definition attributes of Kconfig options
 		if ($realfile =~ /Kconfig/ &&
 		    $line =~ /^\+\s*\bboolean\b/) {


