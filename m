Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8049278F70
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgIYRPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:15:54 -0400
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:54858 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728038AbgIYRPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:15:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DA0DF182CED5B;
        Fri, 25 Sep 2020 17:15:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2691:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3865:3867:3868:3870:3871:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6117:6120:7901:7903:9010:9025:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13149:13230:13255:13311:13357:13439:13845:14181:14659:14721:21080:21451:21627:21772:21811:21939:30012:30054:30060:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: park51_4d137d227169
X-Filterd-Recvd-Size: 1836
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 25 Sep 2020 17:15:50 +0000 (UTC)
Message-ID: <670bc2f60983d9d08c697031ea5a59937f5ed489.camel@perches.com>
Subject: Re: [PATCH v7 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, mark@harmstone.com,
        nborisov@suse.com,
        linux-ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>
Date:   Fri, 25 Sep 2020 10:15:48 -0700
In-Reply-To: <20200925155537.1030046-1-almaz.alexandrovich@paragon-software.com>
References: <20200925155537.1030046-1-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding cc's to Anton Altaparmakov and linux-ntfs-dev)

On Fri, 2020-09-25 at 18:55 +0300, Konstantin Komarov wrote:
> This patch adds NTFS Read-Write driver to fs/ntfs3.

This code should eventually supplant the existing NTFS
implementation right?

Unless there is some specific reason you have not done so,
I believe you should cc the current NTFS maintainer and
NTFS mailing list on all these patches in the future.

MAINTAINERS-NTFS FILESYSTEM
MAINTAINERS-M:  Anton Altaparmakov <anton@tuxera.com>
MAINTAINERS-L:  linux-ntfs-dev@lists.sourceforge.net

Link to the v7 patches:
https://lore.kernel.org/lkml/20200925155537.1030046-1-almaz.alexandrovich@paragon-software.com/


