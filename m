Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0D24684A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgHQOXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 10:23:11 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:52682 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728465AbgHQOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:23:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3EC1D182CF66B;
        Mon, 17 Aug 2020 14:23:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3167:3352:3622:3865:3867:3868:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:14764:21080:21347:21451:21611:21627:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: soup81_331683427017
X-Filterd-Recvd-Size: 2118
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Aug 2020 14:23:07 +0000 (UTC)
Message-ID: <fafab4f8754a924a97e2115fbd95085dbf918a9b.camel@perches.com>
Subject: Re: [PATCH] x86: Use fallthrough pseudo-keyword
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Gustavo A. R. Silva" <kernel.org@embeddedor>
Date:   Mon, 17 Aug 2020 07:23:05 -0700
In-Reply-To: <20200817130227.GI549@zn.tnic>
References: <20200707200303.GA4680@embeddedor>
         <20200817130227.GI549@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-17 at 15:02 +0200, Borislav Petkov wrote:
> On Tue, Jul 07, 2020 at 03:03:03PM -0500, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> ...
> 
> > @@ -362,7 +361,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
> >  		case INAT_SEG_REG_GS:
> >  			return vm86regs->gs;
> >  		case INAT_SEG_REG_IGNORE:
> > -			/* fall through */
> >  		default:
> >  			return -EINVAL;
> >  		}
> > @@ -386,7 +384,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
> >  		 */
> >  		return get_user_gs(regs);
> >  	case INAT_SEG_REG_IGNORE:
> > -		/* fall through */
> >  	default:
> >  		return -EINVAL;
> >  	}
> 
> What's the logic for those two to not get a fallthrough; marker?

consecutive case labels do not need one.


