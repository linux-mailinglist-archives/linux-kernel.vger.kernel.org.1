Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061CD281F1E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgJBXfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:35:33 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:47014 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725283AbgJBXfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:35:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6F01B837F253;
        Fri,  2 Oct 2020 23:35:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:4362:5007:7903:9040:10004:10400:10967:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14777:21080:21433:21611:21627:21660:21819:30022:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: space18_4f16f18271a8
X-Filterd-Recvd-Size: 1830
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Oct 2020 23:35:31 +0000 (UTC)
Message-ID: <b3354a8272d0409417291bce7114c10a971abed6.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Emit a warning on embedded filenames
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 02 Oct 2020 16:35:30 -0700
In-Reply-To: <20201002151849.840bd4c1187d870f328da056@linux-foundation.org>
References: <1fd5f9188a14acdca703ca00301ee323de672a8d.camel@perches.com>
         <20201002151849.840bd4c1187d870f328da056@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-02 at 15:18 -0700, Andrew Morton wrote:
> On Thu, 01 Oct 2020 11:28:10 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > Embedding the complete filename path inside the file
> > isn't particularly useful as often the path is moved
> > around and becomes incorrect.
> > 
> > Emit a warning when the source contains the filename.
> > 
> > ...
> > 
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3273,6 +3273,12 @@ sub process {
> >  			}
> >  		}
> >  
> > +# check for embedded filenames
> > +		if ($rawline =~ /^\+.*\Q$realfile\E/) { di
> > +			WARN("EMBEDDED_FILENAME",
> > +			     "It's generally not useful to have the filename in the file\n" . $herecurr);
> > +		}
> > +
> 
> I removed that " di".  Please check that I merged the correct version
> of this!

Thanks, it must have been added accidentally in my email client.

Combined, the patches are correct.

