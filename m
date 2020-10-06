Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE428518F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgJFS2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 14:28:11 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:44320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726759AbgJFS2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 14:28:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C4FB0181D3025;
        Tue,  6 Oct 2020 18:28:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3872:3874:4250:4321:5007:6119:7903:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21433:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: apple32_06173e3271c8
X-Filterd-Recvd-Size: 1578
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Oct 2020 18:28:09 +0000 (UTC)
Message-ID: <0daa402f9b4724a3e9bc6908f3b7e095bd892eb3.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add new warnings to author signoff
 checks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 06 Oct 2020 11:28:08 -0700
In-Reply-To: <CABJPP5AkdKekb2mRuiDm1-GOuqZ1vL=eNt=OJZN2iAPH1yNytQ@mail.gmail.com>
References: <20201005192409.192317-1-dwaipayanray1@gmail.com>
         <1d8396cb33b33c3d0107ba701b7e597041dfdbc2.camel@perches.com>
         <CABJPP5DDmurU9c2qCoJcg7hvwnkYo4LCx+TW6xKG2G23Uf_Cxw@mail.gmail.com>
         <c1ca28e77e8e3bfa7aadf3efa8ed70f97a9d369c.camel@perches.com>
         <CABJPP5AmvDPFQhWfxC8TA7SCGtwzurVykR5mtPx0ytm-PJDmYA@mail.gmail.com>
         <alpine.DEB.2.21.2010060635000.10609@felia>
         <CABJPP5AkdKekb2mRuiDm1-GOuqZ1vL=eNt=OJZN2iAPH1yNytQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-06 at 18:45 +0530, Dwaipayan Ray wrote:
> To summarize it, two changes that could be made are
> the CHK for subaddress extension could be converted to
> a WARN, and the WARN in case of a missing author signoff
> could be converted to an ERROR.

Sure, why not...


