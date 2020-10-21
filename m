Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C95295387
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505398AbgJUUhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:37:02 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:45718 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410722AbgJUUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:37:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 57D7B181D3058;
        Wed, 21 Oct 2020 20:36:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2902:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:4321:4605:5007:8531:8957:9121:10004:10044:10400:10848:11232:11233:11658:11914:12043:12297:12740:12895:13069:13311:13357:13523:13524:13894:14659:14721:21080:21433:21627:21660:21740:21795:21939:30029:30054:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: verse65_2d0591e2724b
X-Filterd-Recvd-Size: 2997
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Oct 2020 20:36:58 +0000 (UTC)
Message-ID: <05ace32973590e28f62ccddfd7874cf1fcaca8b1.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Date:   Wed, 21 Oct 2020 13:36:57 -0700
In-Reply-To: <5bacf91085ce7e253b2697333dc8ff0378fcfae9.camel@perches.com>
References: <20201021150120.29920-1-yashsri421@gmail.com>
         <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
         <0562c42d-f9af-1141-ab77-8abb73bfd31f@gmail.com>
         <5bacf91085ce7e253b2697333dc8ff0378fcfae9.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-21 at 12:26 -0700, Joe Perches wrote:

> Perhaps a regex for permissions is good enough
> 	$line !~ /\b[cbdl-][rwxs-]{9,9}\b/

Maybe not completely correct...

From info ls:

    The file type is one of the following characters:

     ‘-’
          regular file
     ‘b’
          block special file
     ‘c’
          character special file
     ‘C’
          high performance (“contiguous data”) file
     ‘d’
          directory
     ‘D’
          door (Solaris 2.5 and up)
     ‘l’
          symbolic link
     ‘M’
          off-line (“migrated”) file (Cray DMF)
     ‘n’
          network special file (HP-UX)
     ‘p’
          FIFO (named pipe)
     ‘P’
          port (Solaris 10 and up)
     ‘s’
          socket
     ‘?’
          some other file type

     The file mode bits listed are similar to symbolic mode
     specifications (*note Symbolic Modes::).  But ‘ls’ combines
     multiple bits into the third character of each set of permissions
     as follows:

     ‘s’
          If the set-user-ID or set-group-ID bit and the corresponding
          executable bit are both set.

     ‘S’
          If the set-user-ID or set-group-ID bit is set but the
          corresponding executable bit is not set.

     ‘t’
          If the restricted deletion flag or sticky bit, and the
          other-executable bit, are both set.  The restricted deletion
          flag is another name for the sticky bit.  *Note Mode
          Structure::.

     ‘T’
          If the restricted deletion flag or sticky bit is set but the
          other-executable bit is not set.

     ‘x’
          If the executable bit is set and none of the above apply.

     ‘-’
          Otherwise.

So apparently to be correct this should be:

	$line !~ /\b[bcCdDlMnpPs\?-][rwxsStT-]{9,9}\b/


