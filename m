Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D566D2841E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 23:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgJEVJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 17:09:48 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:56042 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725861AbgJEVJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:09:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BC787182CED5B;
        Mon,  5 Oct 2020 21:09:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2827:3138:3139:3140:3141:3142:3354:3622:3865:3866:3868:3870:3872:3873:3874:4184:4321:5007:7576:7903:7974:8957:10004:10400:10848:11026:11232:11473:11658:11783:11914:12297:12740:12895:13894:14093:14096:14097:14180:14181:14659:14721:21060:21080:21324:21433:21451:21627:21819:30003:30022:30029:30030:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fold37_3305bb7271c1
X-Filterd-Recvd-Size: 3213
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon,  5 Oct 2020 21:09:46 +0000 (UTC)
Message-ID: <c1ca28e77e8e3bfa7aadf3efa8ed70f97a9d369c.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add new warnings to author signoff
 checks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 05 Oct 2020 14:09:45 -0700
In-Reply-To: <CABJPP5DDmurU9c2qCoJcg7hvwnkYo4LCx+TW6xKG2G23Uf_Cxw@mail.gmail.com>
References: <20201005192409.192317-1-dwaipayanray1@gmail.com>
         <1d8396cb33b33c3d0107ba701b7e597041dfdbc2.camel@perches.com>
         <CABJPP5DDmurU9c2qCoJcg7hvwnkYo4LCx+TW6xKG2G23Uf_Cxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-06 at 01:37 +0530, Dwaipayan Ray wrote:
> On Tue, Oct 6, 2020 at 1:07 AM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2020-10-06 at 00:54 +0530, Dwaipayan Ray wrote:
> > > The author signed-off-by checks are currently very vague.
> > > Cases like same name or same address are not handled separately.
> > 
> > When you run tests for this, how many mismatches are
> > caused by name formatting changes like:
> > 
> > From: "Developer, J. Random" <jrd@bigcorp.com>
> > ...
> > Signed-off-by: "J. Random Developer" <jrd@bigcorp.com>?
> > 
> > Should these differences generate a warning?
> > 
> 
> Hi,
> I ran my tests on non merge commits between v5.7 and v5.8.
> 
> There were a total of 250 NO_AUTHOR_SIGN_OFF Warnings
> 
> 203 of these were email address mismatches.
> 32 of these were name mismatches.
> 
> So for the name mismatches, the typical cases are like:
> 
> 'From: tannerlove <tannerlove@google.com>' != 'Signed-off-by: Tanner
> Love <tannerlove@google.com>'
> 'From: "朱灿灿" <zhucancan@vivo.com>' != 'Signed-off-by: zhucancan
> <zhucancan@vivo.com>'
> 'From: Yuval Basson <ybason@marvell.com>' != 'Signed-off-by: Yuval
> Bason <ybason@marvell.com>'
> 'From: allen <allen.chen@ite.com.tw>' != 'Signed-off-by: Allen Chen
> <allen.chen@ite.com.tw>'
> 
> I didn't find the exact formatting change you mentioned in my commit range.
> But I did find something like:
> 
> 'From: "Paul A. Clarke" <pc@us.ibm.com>' != 'Signed-off-by: Paul
> Clarke <pc@us.ibm.com>'
> 
> So it's like some have parts of their names removed, some have language
> conflicts, and yet some have well different spellings, or initials,
> etc. It's like
> a wide variety of things happening here.
> 
> I think considering these, it should be warned about, and let people know
> that there might be something wrong going on.
> 
> What do you think?

Except for comments and quotes like:

	From: J. Random Developer (BigCorp) <jrd@bigcorp.com>
	Signed-off-by: "J. Random Developer" <jrd@bigcorp.com>

I think any time there's a mismatch, there
should be a warning emitted.

That includes any subaddress detail difference.


