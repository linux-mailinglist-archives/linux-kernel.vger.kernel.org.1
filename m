Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12E71F1497
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgFHIlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 04:41:16 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:50282 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727788AbgFHIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:41:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 693DC802FD46;
        Mon,  8 Jun 2020 08:41:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2895:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4605:5007:7903:8957:10004:10400:10450:10455:10471:10848:11026:11232:11473:11658:11914:12043:12109:12114:12296:12297:12438:12740:12760:12895:13161:13229:13255:13439:13972:14181:14659:14721:19904:19999:21080:21433:21451:21627:21740:21819:21939:21990:30012:30022:30034:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tramp89_2b10e8f26db8
X-Filterd-Recvd-Size: 4924
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Jun 2020 08:41:12 +0000 (UTC)
Message-ID: <e3d7cc965eccec881bc35ae18d63f4bc23c33dfc.camel@perches.com>
Subject: Re: Forest Bond <forest@alittletooquiet.net>,Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Rodolfo C. Villordo" <rodolfovillordo@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Jun 2020 01:41:11 -0700
In-Reply-To: <alpine.DEB.2.21.2006080758510.2430@hadrien>
References: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal>
         <20200608054614.GO23230@ZenIV.linux.org.uk>
         <alpine.DEB.2.21.2006080758510.2430@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-08 at 07:59 +0200, Julia Lawall wrote:
> On Mon, 8 Jun 2020, Al Viro wrote:
> 
> > On Sun, Jun 07, 2020 at 10:41:56PM +0000, Rodolfo C. Villordo wrote:
> > > Multiple line over 80 characters fixes by splitting in multiple lines.
> > > Warning found by checkpatch.pl
> > 
> > I doubt that checkpatch.pl can catch the real problems there:
> > 
> > * Hungarian Notation Sucks.  Really.
> > * so does CamelCase, especially for wonders like s_uGetRTSCTSRsvTime
> 
> Rodolfo,
> 
> If you work hard with Coccinelle and python scripting, it can help with
> the first two problems.

These VIA vt6655/vt6656 drivers have been in staging for more than
a decade.  There are relatively few checkpatch coding style
cleanups to do but there are many overall style issues to resolve.


It's true the identifier transforms could be done with Coccinelle,
but the problem is larger than identifier types and line lengths.

Hungarian renaming can't really be automated, it's basically a
sed problem where the new identifiers have to be chosen by someone
with specific device knowledge.

Look at vt6655/rf.c:

Lots of things should be reduced/replaced/simplified.
For instance, these repeated patterns exist:

	"(BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW"
	"(BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW"

There are 300+ uses just in this one file.

It's a lot of visual noise that should be minimized by using macros.
It would also reduce the number of checkpatch's long line warnings.

All the of unsigned char could be u8, unsigned short -> u16, etc.
Many arrays could be static const.

Nearly every function in the file could be improved.

For instance, this code could be written altogether:

bool RFbAL7230SelectChannelPostProcess(struct vnt_private *priv,
				       u16 byOldChannel,
				       u16 byNewChannel)
{
	bool ret;

	ret = true;

	/* if change between 11 b/g and 11a need to update the following
	 * register
	 * Channel Index 1~14
	 */
	if ((byOldChannel <= CB_MAX_CHANNEL_24G) && (byNewChannel > CB_MAX_CHANNEL_24G)) {
		/* Change from 2.4G to 5G [Reg] */
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[2]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[3]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[5]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[7]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[10]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[12]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[15]);
	} else if ((byOldChannel > CB_MAX_CHANNEL_24G) && (byNewChannel <= CB_MAX_CHANNEL_24G)) {
		/* Change from 5G to 2.4G [Reg] */
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[2]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[3]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[5]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[7]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[10]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[12]);
		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[15]);
	}

	return ret;
}

This could be something like: (written in email client, untested)

{
	unsigned long *table;
	static const int indices[] = {2, 3, 5, 7, 10, 12, 15};
	int i;
	bool ret = true;

	/* if changing between 11b/g and 11a, update the indices registers */

	if (byOldChannel <= CB_MAX_CHANNEL_24G && byNewChannel > CB_MAX_CHANNEL_24G)
		table = dwAL7230InitTableAMode;
	else if (byOldChannel > CB_MAX_CHANNEL_24G && byNewChannel <= CB_MAX_CHANNEL_24G)
		table = dwAL7230InitTable;
	else
		return ret;

	for (i = 0 ; i < ARRAY_SIZE(indices); i++)
		ret &= IFRFbWriteEmbedded(priv, table[indices[i]]);

	return ret;
}


