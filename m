Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3730A297C26
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 13:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761183AbgJXLmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 07:42:04 -0400
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:47410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1761176AbgJXLmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 07:42:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5FA87182CED5B;
        Sat, 24 Oct 2020 11:42:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3866:3867:3870:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4362:5007:7514:7903:7974:9025:10004:10400:11232:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13095:13311:13357:13439:14181:14659:14721:21080:21325:21433:21627:21660:21811:30003:30054:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: kiss23_3c0db5e27261
X-Filterd-Recvd-Size: 1290
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 24 Oct 2020 11:42:02 +0000 (UTC)
Message-ID: <b9f92d932251a3fc6f22cafc36a9d1f0c6fede15.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: fix false positives in REPEATED_WORD
 warning
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        dwaipayanray1@gmail.com
Date:   Sat, 24 Oct 2020 04:42:01 -0700
In-Reply-To: <20201024102253.13614-1-yashsri421@gmail.com>
References: <20201024102253.13614-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-24 at 15:52 +0530, Aditya Srivastava wrote:
> Presence of hexadecimal address or symbol results in false warning
> message by checkpatch.pl.

Thanks Aditya, this looks OK to me.
Andrew can you please pick up this patch on top of Dwaipayan's?

1: https://lore.kernel.org/lkml/20201017162732.152351-1-dwaipayanray1@gmail.com/
2: https://lore.kernel.org/lkml/20201024102253.13614-1-yashsri421@gmail.com/


