Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7612A1366
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 05:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgJaEOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 00:14:15 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:47806 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgJaEOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 00:14:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 682CD2480;
        Sat, 31 Oct 2020 04:14:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:152:305:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2691:2692:2827:3138:3139:3140:3141:3142:3622:3653:3834:3865:3866:3867:3868:3870:3871:3872:3874:4049:4118:4250:4321:4560:4605:5007:6119:6691:7514:7576:7875:7903:8957:9010:10004:10848:10946:11026:11232:11473:11658:11783:11914:12043:12295:12297:12438:12663:12679:12740:12895:13019:13161:13229:13894:14659:21080:21433:21450:21451:21627:21660:21819:30003:30022:30029:30034:30054:30055:30064:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:103,LUA_SUMMARY:none
X-HE-Tag: top75_380e2f12729b
X-Filterd-Recvd-Size: 7080
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 31 Oct 2020 04:14:12 +0000 (UTC)
Message-ID: <8b9beccf81735f2e042447026a1043f8d21c2566.camel@perches.com>
Subject: Re: [PATCH] checkpatch: improve handling of email comments
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, yashsri421@gmail.com
Date:   Fri, 30 Oct 2020 21:14:11 -0700
In-Reply-To: <alpine.DEB.2.21.2010301255460.16621@felia>
References: <20201030090704.40533-1-dwaipayanray1@gmail.com>
         <9d5c8699f94481ab5bf2d37348199ca1d6343c8b.camel@perches.com>
         <alpine.DEB.2.21.2010301255460.16621@felia>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-30 at 12:58 +0100, Lukas Bulwahn wrote:
> 
> On Fri, 30 Oct 2020, Joe Perches wrote:
> 
> > On Fri, 2020-10-30 at 14:37 +0530, Dwaipayan Ray wrote:
> > > checkpatch has limited support for parsing email comments. It only
> > > support single name comments or single after address comments.
> > > Whereas, RFC 5322 specifies that comments can be inserted in
> > > between any tokens of the email fields.
> > > 
> > > Improve comment parsing mechanism in checkpatch.
> > > 
> > > What is handled now:
> > > 
> > > - Multiple name/address comments
> > > - Comments anywhere in between name/address
> > > - Nested comments like (John (Doe))
> > > 
> > > A brief analysis of checkpatch output on v5.0..v5.7 showed that
> > > after these modifications, the number of BAD_SIGN_OFF warnings
> > > came down from 2944 to 1424, and FROM_SIGN_OFF_MISMATCH came
> > > down from 2366 to 2330.
> > > 
> > > So, a total of 1556 false positives were resolved in total.
> > 
> > A mere reduction in messages emitted isn't necessarily good.
> > 
> 
> Agree. That is why I also went through the list of those warnings.
> 
> I could not spot any obvious true positive among the reduced ones.
>  
> 
> > Please send me privately a complete list of these nominally
> > false positive messages that are no longer emitted.
> > 
> > I believe one of the relatively common incorrect messages is
> > for the cc: <stable@vger.kernel.org> where a version number is
> > continued on the same line after a #.
> > 
> > CC: stable@vger.kernel.org # for versions x.y.z and above
> > 
> 
> That was one,

It's not just one, it's ~90% of the list that Dwaipayan sent me.

$ wc -l mismatches
831 mismatches

$ grep -v -i stable mismatches | wc -l
98

> another common pattern was just quotes put inconsistently at 
> different places.

Yes, there are some defects there.
But there are also now false negatives.

For instance, this is not appropriate to ignore:

WARNING:BAD_SIGN_OFF: email address 'jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, dmurphy@ti.com' might be better as 'jacek.anaszewski@gmail.com,linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, dmurphy@ti.com'

From the file that Dwaipayan sent me, all the rest not including the
stable variants, which IMO should be handled separately, are below.

Of these 98 in total, 60+% are unicode which IMO should always be quoted
and most are doubled with BAD_SIGN_OFF doubling FROM_SIGN_OFF_MISMATCH
(and I don't quite understand why it's "From:/" then "Signed-off-by:"

$ grep -v -i stable dwai | sort | uniq -c | sort -rn
     31 WARNING:BAD_SIGN_OFF: email address '周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>' might be better as '"周琰杰"(Zhou Yanjie) <zhouyanjie@wanyeetech.com>'
     30 WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name mismatch: 'From: "周琰杰"(Zhou Yanjie) <zhouyanjie@wanyeetech.com>' != 'Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>'
     
These 29 in total would be better stripping any bits in parentheses from
the name portion only when _not_ inside quotes.

     20 WARNING:BAD_SIGN_OFF: email address 'Thomas Hellström (VMware) <thomas_os@shipmail.org>' might be better as '"Thomas Hellström"(VMware) <thomas_os@shipmail.org>'
      5 WARNING:BAD_SIGN_OFF: email address 'H. Peter Anvin (Intel) <hpa@zytor.com>' might be better as '"H. Peter Anvin"(Intel) <hpa@zytor.com>'
      

      1 WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name mismatch: 'From: "Thomas Hellström"(VMware) <thomas_os@shipmail.org>' != 'Signed-off-by: Thomas Hellström (VMware) <thomas_os@shipmail.org>'
      
      1 WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name mismatch: 'From: "Srivatsa S. Bhat"(VMware) <srivatsa@csail.mit.edu>' != 'Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>'
      1 WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name mismatch: 'From: JanNieuwenhuizen(janneke) <janneke@gnu.org>' != 'Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>'  
      1 WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name mismatch: 'From: "Frédéric Pierret"(fepitre) <frederic.pierret@qubes-os.org>' != 'Signed-off-by: Frédéric Pierret (fepitre) <frederic.pierret@qubes-os.org>'

So these 8 others are ones where quotes are either oddly placed
or perhaps should always exist and the comment in parentheses
is suggested poorly.  7 of these should be fixed and one should
still be reported.

      1 WARNING:BAD_SIGN_OFF: email address '"Thomas Hellström (VMware)" <thomas_os@shipmail.org>' might be better as '"Thomas Hellström"(VMware) <thomas_os@shipmail.org>'
      1 WARNING:BAD_SIGN_OFF: email address 'Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>' might be better as '"Srivatsa S. Bhat"(VMware) <srivatsa@csail.mit.edu>'
      1 WARNING:BAD_SIGN_OFF: email address '"Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>' might be better as '"Rantala, Tommi T."(Nokia - FI/Espoo) <tommi.t.rantala@nokia.com>'
      1 WARNING:BAD_SIGN_OFF: email address '"Kai Mäkisara (Kolumbus)" <kai.makisara@kolumbus.fi>' might be better as '"Kai Mäkisara"(Kolumbus) <kai.makisara@kolumbus.fi>'
      1 WARNING:BAD_SIGN_OFF: email address 'jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, dmurphy@ti.com' might be better as 'jacek.anaszewski@gmail.com,linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, dmurphy@ti.com'
      1 WARNING:BAD_SIGN_OFF: email address 'Frédéric Pierret (fepitre) <frederic.pierret@qubes-os.org>' might be better as '"Frédéric Pierret"(fepitre) <frederic.pierret@qubes-os.org>'
      1 WARNING:BAD_SIGN_OFF: email address 'David.Laight@aculab.com (big endian system concerns)' might be better as 'David.Laight@aculab.com(big endian system concerns)'
      1 WARNING:BAD_SIGN_OFF: email address 'apenwarr@foxnet.net (Avery Pennarun)' might be better as 'apenwarr@foxnet.net(Avery Pennarun)'



