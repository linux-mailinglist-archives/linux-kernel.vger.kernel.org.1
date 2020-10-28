Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A1929D363
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJ1Vn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:43:26 -0400
Received: from smtp1.axis.com ([195.60.68.17]:30541 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgJ1VnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1245; q=dns/txt; s=axis-central1;
  t=1603921395; x=1635457395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V5PC9rrr4wvQwwqKdrCWhTxTTXC0hA0+smGFsW9FA6A=;
  b=A5RkGxHfJuaQ1nUkFUxA8YBJ4fn4dn6wqQKRVt/yTTzPoJdj9ts18QdN
   NFRIFYo1Mnb3UDODqqjltKYIINRluw20sNq9kJ9y3A+E/6k6fcDuyrjJQ
   3P5TBVUfn04zn9STq3C7qP5kMOs2ENG1TC6LL8vLYJdsHX5pdSikSAasZ
   +8smpR4X6eJw8SxTOoX8oG3eKfVj9Kkxo5KnMt22lCd4PT8rSCFKEfBD8
   pm7qHW/0tV1s8oDiVnYDO8P0Uvh+fj18tvvC0jMBvQP9R4mDzVg5lS+Tq
   omtFFFBQ+WJguOaREPtetF1Yt4jzEG0komjhaIeCyuuoTUsOYQKpeOqCV
   Q==;
IronPort-SDR: RW1GWNphPPFtmQaT7DrDcktgp5Xkcqs01gk50OCvjdEx3SaHFxbXIMUZ1/yl7R83QRb/R/Jge7
 rCMCW/7NCuBK/+gi7TUbtOTmVH6n9Js46ipJmO0lJLNciEM+8ZX5kXBxvJzoOoZvbeI3750LoB
 d171LXGepfvaPJdhxcmCO+kyx4qerhaWegYn5nTGcYeZUgDtplkneIjjKgJIF09Agx+NCVPg12
 Fl5cMQB1BUOyUOLZ5nHaWLAgGYXqWPcP7BmGmoN/Tktnhgg8BWQqlSAdZZiStVMIqCQo8yQbSh
 qII=
X-IronPort-AV: E=Sophos;i="5.77,425,1596492000"; 
   d="scan'208";a="14495795"
Date:   Wed, 28 Oct 2020 10:14:10 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Sherry Sun <sherry.sun@nxp.com>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Message-ID: <20201028091410.o2odlqrhzzbiqh44@axis.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-3-sherry.sun@nxp.com>
 <20201023092650.GB29066@infradead.org>
 <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com>
 <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027151106.e4skr6dsbwvo4al6@axis.com>
 <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:47:49AM +0100, Sherry Sun wrote:
> > Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
> > ring
> > 
> > On Tue, Oct 27, 2020 at 08:05:43AM +0100, Sherry Sun wrote:
> > > Can you help test the patch about removing the codes of reassign used
> > > ring, and comment on the impact for Intel MIC platform?  Thanks for
> > > any help.
> > 
> > I don't have access to MIC hardware myself, either.
> > 
> > But this patch is quite certainly going to break it since guests using a kernel
> > without the patch will not work with hosts with a kernel with the patch.
> 
> Thanks for your reply.
> This patch can be used by both guests and hosts.
> I have tested it on imx8qm platform(both guest and host are ARM64 architecture), and it works well.
> So I guess Intel MIC won't meet big problems when both guest and host
> apply this patch. But it is best if it can be tested.

The guest and host are different systems and it should be possible to
upgrade the host kernel without being forced to upgrade the guest
kernel, and vice-versa.  This patch breaks that.

If MIC hardware has no users and the drivers are being deleted then of
course backward compatibility doesn't matter. 
