Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53A420999F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 07:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbgFYFvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 01:51:00 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:55878 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725998AbgFYFvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:51:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2E12618029120;
        Thu, 25 Jun 2020 05:50:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:560:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2895:3138:3139:3140:3141:3142:3353:3622:3867:3868:3871:3872:4321:5007:6742:7875:10004:10400:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21740:21990:30012:30034:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: head29_411519126e4a
X-Filterd-Recvd-Size: 2280
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jun 2020 05:50:57 +0000 (UTC)
Message-ID: <51ca818443648cb25a604448dea022d6ac2ea09f.camel@perches.com>
Subject: Re: [RFC] Reed-Solomon Code: Update no_eras to the actual number of
 errors
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Aiden Leong <aiden.leong@aibsd.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Date:   Wed, 24 Jun 2020 22:50:56 -0700
In-Reply-To: <202006242231.E17DAB2@keescook>
References: <20200625041141.8053-1-aiden.leong@aibsd.com>
         <202006242231.E17DAB2@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-24 at 22:35 -0700, Kees Cook wrote:
> On Wed, Jun 24, 2020 at 09:10:53PM -0700, Aiden Leong wrote:
> > Corr and eras_pos are updated to actual correction pattern and erasure
> > positions, but no_eras is not.
[]
> > @@ -312,14 +313,21 @@
> >  				eras_pos[j++] = loc[i] - pad;
> >  			}
> >  		}
> > +		if (no_eras > 0)
> > +			*no_eras = j;
> 
> Is this meant to be "if (j > 0)" or "if (no_eras != NULL)" ? It's
> uncommon to use > 0 for a pointer value.
> 
> >  	} else if (data && par) {
> >  		/* Apply error to data and parity */
> > +		j = 0;
> >  		for (i = 0; i < count; i++) {
> >  			if (loc[i] < (nn - nroots))
> >  				data[loc[i] - pad] ^= b[i];
> >  			else
> >  				par[loc[i] - pad - len] ^= b[i];
> > +			if (b[i])
> > +				j++;
> >  		}
> > +		if (no_eras > 0)
> > +			*no_eras = j;
> 
> I assume it's a pointer test, so both would be:
> 
> 		if (no_eras_ptr != NULL)
> 			*no_eras_ptr = j;

More common still would be

		if (no_eras_ptr)
			*no_eras_ptr = j;

though I think using _ptr is too Hungarian.


