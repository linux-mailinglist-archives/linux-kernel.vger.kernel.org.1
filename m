Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B6823160F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 01:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgG1XGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 19:06:15 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:42968 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730323AbgG1XGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:06:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DF3A3182CED5B;
        Tue, 28 Jul 2020 23:06:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:2393:2559:2562:2828:2911:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:4384:4425:4605:5007:6691:7576:7809:7903:9010:9038:10004:10848:11026:11232:11473:11657:11658:11914:12043:12048:12109:12295:12297:12346:12438:12555:12663:12679:12740:12760:12895:12986:13095:13255:13439:14093:14097:14181:14659:14721:21063:21080:21433:21451:21627:30012:30054:30055:30063:30064:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: swing96_0a091fa26f6d
X-Filterd-Recvd-Size: 5557
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jul 2020 23:06:10 +0000 (UTC)
Message-ID: <90f4d174d8a2d50104ad52aa0bd4e0ece86f2e90.camel@perches.com>
Subject: Re: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
From:   Joe Perches <joe@perches.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Date:   Tue, 28 Jul 2020 16:06:08 -0700
In-Reply-To: <398e20e8c3f7436bb50d671b9aa9f809@intel.com>
References: <20200728214139.3129532-1-tomas.winkler@intel.com>
         <e80a9e75-4497-1587-deab-b5c6a0fcc48f@embeddedor.com>
         <8ec7601780b542c2bc0168e03749ec0e@intel.com>
         <d6ef8ca4-6e11-b758-0e24-75301e1a5303@embeddedor.com>
         <398e20e8c3f7436bb50d671b9aa9f809@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 22:14 +0000, Winkler, Tomas wrote:
> > -----Original Message-----
> > From: Gustavo A. R. Silva <gustavo@embeddedor.com>
[]
> > I'm using this command:
> > 
> > $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback
> > 
> > and this is the output for both files:
> > 
> > $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback
> > drivers/misc/mei/hdcp/mei_hdcp.c Arnd Bergmann <arnd@arndb.de>
> > (supporter:CHAR and MISC DRIVERS) Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS) linux-
> > kernel@vger.kernel.org (open list) $ scripts/get_maintainer.pl --nokeywords --
> > nogit --nogit-fallback drivers/misc/mei/hdcp/mei_hdcp.h Arnd Bergmann
> > <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS) Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS) linux-
> > kernel@vger.kernel.org (open list)
> > For some reason you don't appear on the list above. Do you see anything
> > wrong with the command I'm running to get the maintainers and lists?
> 
> Not sure, it should be caught by drivers/misc/mei/* ?  

No, this pattern matches _only_ files in that
particular directory and not any files in any
subdirectory.

> Maybe it is not recursive?

It depends on the pattern.
Patterns with trailing slashes match subdirectories too.

from MAINTAINERS:

	F: *Files* and directories wildcard patterns.
	   A trailing slash includes all files and subdirectory files.
	   F:	drivers/net/	all files in and below drivers/net
	   F:	drivers/net/*	all files in drivers/net, but not below
	   F:	*/net/*		all files in "any top level directory"/net
	   One pattern per line.  Multiple F: lines acceptable.


> Need to check the script, 
> frankly I usually check this manually.  prob
> 
> INTEL MANAGEMENT ENGINE (mei)
> M:      Tomas Winkler <tomas.winkler@intel.com>
> L:      linux-kernel@vger.kernel.org
> S:      Supported
> F:      Documentation/driver-api/mei/*
> F:      drivers/misc/mei/*

You probably want:

F:	drivers/misc/mei/

> F:      drivers/watchdog/mei_wdt.c
> F:      include/linux/mei_cl_bus.h
> F:      include/uapi/linux/mei.h
> F:      samples/mei/*
> 
> 
> > Thanks
> > --
> > Gustavo
> > 
> > > > > I really do not appreciate that the code is bypassing driver
> > > > > maintaner review, I think this is a minimum we can ask for, this is
> > > > > not for a first time.
> > > > > 
> > > > > This reverts commit c56967d674e361ebe716e66992e3c5332b25ac1f.
> > > > > 
> > > > > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > > ---
> > > > >  drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
> > > > > drivers/misc/mei/hdcp/mei_hdcp.h | 2 +-
> > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c
> > > > > b/drivers/misc/mei/hdcp/mei_hdcp.c
> > > > > index d1d3e025ca0e..e6c3dc595617 100644
> > > > > --- a/drivers/misc/mei/hdcp/mei_hdcp.c
> > > > > +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
> > > > > @@ -572,7 +572,7 @@ static int mei_hdcp_verify_mprime(struct device
> > > > *dev,
> > > > >  	       HDCP_2_2_MPRIME_LEN);
> > > > >  	drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data-
> > seq_num_m);
> > > > >  	memcpy(verify_mprime_in.streams, data->streams,
> > > > > -	       array_size(data->k, sizeof(*data->streams)));
> > > > > +	       (data->k * sizeof(struct hdcp2_streamid_type)));
> > > > > 
> > > > >  	verify_mprime_in.k = cpu_to_be16(data->k);
> > > > > 
> > > > > diff --git a/drivers/misc/mei/hdcp/mei_hdcp.h
> > > > > b/drivers/misc/mei/hdcp/mei_hdcp.h
> > > > > index 834757f5e072..18ffc773fa18 100644
> > > > > --- a/drivers/misc/mei/hdcp/mei_hdcp.h
> > > > > +++ b/drivers/misc/mei/hdcp/mei_hdcp.h
> > > > > @@ -358,7 +358,7 @@ struct wired_cmd_repeater_auth_stream_req_in
> > {
> > > > >  	u8
> > > > 	seq_num_m[HDCP_2_2_SEQ_NUM_LEN];
> > > > >  	u8				m_prime[HDCP_2_2_MPRIME_LEN];
> > > > >  	__be16				k;
> > > > > -	struct hdcp2_streamid_type	streams[];
> > > > > +	struct hdcp2_streamid_type	streams[1];
> > > > >  } __packed;
> > > > > 
> > > > >  struct wired_cmd_repeater_auth_stream_req_out {
> > > > > 

