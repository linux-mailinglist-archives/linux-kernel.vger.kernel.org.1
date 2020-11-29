Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D570A2C7BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 23:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgK2W2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 17:28:11 -0500
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:49248 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725950AbgK2W2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 17:28:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 63192100E7B40;
        Sun, 29 Nov 2020 22:27:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2693:2828:2903:2911:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3873:4321:4425:5007:7514:7903:8531:10004:10400:10848:11232:11658:11914:12294:12297:12438:12555:12740:12895:13095:13439:13894:14180:14181:14659:14721:21060:21063:21080:21221:21433:21451:21627:21774:30030:30054:30070:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wheel10_07047072739c
X-Filterd-Recvd-Size: 3936
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sun, 29 Nov 2020 22:27:28 +0000 (UTC)
Message-ID: <45c8575f69602a3ad6bc3129ab99905e9f233af0.camel@perches.com>
Subject: Re: [PATCH v7] checkpatch: add fix option for LOGICAL_CONTINUATIONS
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Sun, 29 Nov 2020 14:27:27 -0800
In-Reply-To: <a0f6479e-0c1b-a2f8-a265-32cc31313870@gmail.com>
References: <afaa79a6d86a4184878595ced3f2de1a92a4058c.camel@perches.com>
         <20201123102818.24364-1-yashsri421@gmail.com>
         <a0f6479e-0c1b-a2f8-a265-32cc31313870@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-29 at 14:25 +0530, Aditya wrote:
> On 23/11/20 3:58 pm, Aditya Srivastava wrote:
> > Currently, checkpatch warns if logical continuations are placed at the
> > start of a line and not at the end of previous line.

Acked-by: Joe Perches <joe@perches.com>

> > 
> > E.g., running checkpatch on commit 3485507fc272 ("staging:
> > bcm2835-camera: Reduce length of enum names") reports:
> > 
> > CHECK:LOGICAL_CONTINUATIONS: Logical continuations should be on the
> > previous line
> > +	if (!ret
> > +	    && camera_port ==
> > 
> > Provide a simple fix by inserting logical operator at the last
> > non-comment, non-whitespace char of the previous line and removing from
> > current line, if both the lines are additions(ie start with '+')
> > 
> > Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> > ---
> > changes in v2: quote $operator at substitution
> > 
> > changes in v3: add a check for previous line ending with comment;
> > If so, insert $operator at the last non-comment, non-whitespace char of the previous line
> > 
> > changes in v4: improve the matching mechanism by matching line termination at comment or white space;
> > insert the operator before comments (if any) separated by a whitespace;
> > append the comment and its pre-whitespace after the inserted operator (if comment was present),
> > ie if no comment was present nothing will be inserted after the operator
> > 
> > changes in v5: improve regex for comment and line end with '$;'
> > 
> > changes in v6: remove if-check; modify commit message
> > 
> > changes in v7: add an extra '$' symbol at '$fixed[$fixlinenr - 1]' regex substitution to ensure match at line end
> > 
> >  scripts/checkpatch.pl | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 5b1a5a65e69a..fb3c50e0bde2 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3553,8 +3553,16 @@ sub process {
> >  
> > 
> >  # check for && or || at the start of a line
> >  		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
> > -			CHK("LOGICAL_CONTINUATIONS",
> > -			    "Logical continuations should be on the previous line\n" . $hereprev);
> > +			my $operator = $1;
> > +			if (CHK("LOGICAL_CONTINUATIONS",
> > +				"Logical continuations should be on the previous line\n" . $hereprev) &&
> > +			    $fix && $prevrawline =~ /^\+/) {
> > +				# insert logical operator at last non-comment, non-whitepsace char on previous line
> > +				$prevline =~ /[\s$;]*$/;
> > +				my $line_end = substr($prevrawline, $-[0]);
> > +				$fixed[$fixlinenr - 1] =~ s/\Q$line_end\E$/ $operator$line_end/;
> > +				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
> > +			}
> >  		}
> >  
> > 
> >  # check indentation starts on a tab stop
> > 
> 
> Hi Joe
> You probably missed this patch. Please review :)
> 
> Thanks
> Aditya


