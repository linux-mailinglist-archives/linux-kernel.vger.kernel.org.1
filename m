Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CA7300A91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbhAVSCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:02:02 -0500
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:45542 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729648AbhAVRw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:52:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E70EE1801F770;
        Fri, 22 Jan 2021 17:52:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2560:2563:2682:2685:2691:2693:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4605:5007:6119:7652:7903:8784:8957:9025:9163:10004:10400:10848:11232:11658:11914:12043:12297:12660:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:14819:21080:21451:21611:21627:21972:21987:30054:30060:30080:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: chess82_4508c6f2756d
X-Filterd-Recvd-Size: 2880
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Jan 2021 17:52:08 +0000 (UTC)
Message-ID: <59dfd27e4b5cfe183a8cd64ed930c6dfd3c0aa20.camel@perches.com>
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang
 line
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Finn Behrens <me@kloenk.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Jan 2021 09:52:06 -0800
In-Reply-To: <CAK7LNAQM5zYu3J-zP1AFPSKqiFL0rmnud9WyNFDNMmg3Dgw00w@mail.gmail.com>
References: <20210121170736.2266-1-scott.branden@broadcom.com>
         <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
         <CAHp75Vf=Ba+e8PDsvi8eDiuNDvC6Pfx3RsRAkaOZvD26Z2pnQA@mail.gmail.com>
         <CAHp75VcLi8hjYaDXrfAjbj+Kw_FRef=xnKiXr_Kv+YUToEjHTQ@mail.gmail.com>
         <CAK7LNARL570EgjijCMY_CF91frwtTeatyhYcnD8-s08aiduFnQ@mail.gmail.com>
         <64d3d8cb83e09d03927dba998a09e8b37e06dece.camel@perches.com>
         <CAK7LNAQM5zYu3J-zP1AFPSKqiFL0rmnud9WyNFDNMmg3Dgw00w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-01-23 at 02:16 +0900, Masahiro Yamada wrote:
> On Sat, Jan 23, 2021 at 12:51 AM Joe Perches <joe@perches.com> wrote:
> > 
> > On Fri, 2021-01-22 at 07:06 +0900, Masahiro Yamada wrote:
> > > I use Ubuntu, where /usr/bin/python is a symlink
> > > to /usr/bin/python3.
> > 
> > Odd, here:
> > 
> > $ lsb_release -a
> > No LSB modules are available.
> > Distributor ID: Ubuntu
> > Description:    Ubuntu 20.10
> > Release:        20.10
> > Codename:       groovy
> > 
> > $ ls /usr/bin/python -la
> > lrwxrwxrwx 1 root root 7 Apr 15  2020 /usr/bin/python -> python2
> 
> Hmm, presumably I changed the symlink path by myself
> although I do not remember...  Sorry for confusion.

Or maybe it's because my system has only been upgraded since
about Ubuntu 8.04... Maybe it's time for a fresh reinstall..

I believe that Ubuntu now only installs python3 since 18.04

https://wiki.ubuntu.com/BionicBeaver/ReleaseNotes

Other base system changes since 16.04 LTS

    The gpg binary is provided by gnupg2

    For new installs, a swap file will be used by default instead of a swap partition.

    Python 2 is no longer installed by default. Python 3 has been updated to 3.6. This is the last LTS release to include Python 2 in main.



