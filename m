Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6CA19E9A6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 08:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDEG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 02:59:52 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40515 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbgDEG7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 02:59:52 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id AAEDE58026A;
        Sun,  5 Apr 2020 02:59:50 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Sun, 05 Apr 2020 02:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=yWE5iV1vF2rjVGqJzP4udG6OgWvMuVf
        D2zKlW0VL8vc=; b=goGwj/jmvd74/4dXXrkmJVPe5xI9r3yKgasZjk9WlI8sZvA
        Hq8FllL86de3H+jkfEIilxOxo12fkh/uZUGny/AvGivr3scfemC7SN6haQ8cLUDX
        kNhFTFxt3PvIwPTWj8+orWCj7oZPLvd5Jy1TS0VAMqEv9td8mDYMkk8gex5pvoeA
        ucNFcYwGXilpC8XYUKedvB+1ommO41Vzbiusd1/aW5yknjdpImx7oilaa+/dl9qW
        KE3k6T7vf1ggYLO/YNXbgb4F8FxAlcVUZ/d5VQ+sZyJEYLzQw5rkmZD96vbYLLu/
        Vlukw8OOzCVMFp3RsorCHmsR+YcxKKESTznHguA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yWE5iV
        1vF2rjVGqJzP4udG6OgWvMuVfD2zKlW0VL8vc=; b=QQpV+ip6yBO7k7deoxKGUs
        rW3WfZZP7kKZy5IZipRQlASYytedxXztVz9s6lAsbr9r1rfrO4aaV5W/NgiNkG2E
        dcwvdQ+XbPv7RwpPM2Ek7A+AqhaYPEQtoEg8FP2ct2LKqXsA//neIK5q0H5Kmv9p
        ESfTAcXiw+aRhyXlvNuR5YKUOayawJtEIkwpYkOO6fSTgb142/azseN7ik/FsTbf
        JdXgvn/gh/lkZtCk6sYTR3NB8gvhSy+5/RNDytiIgGfJH0n0RNJG5OJg8SLaezdB
        dnVkGcD2iuBA+cRfi5P7ID9bOvcIdfhofBrMax6bBiggzvEoSgEP/OpDUMvMtw1Q
        ==
X-ME-Sender: <xms:5IGJXgh39OEGA02bB29v2YQALa7x8qIPFiG_n0zd-ko5F5rCutG2cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrg
    hinhepkhgvrhhnvghlrdhorhhgpdguvghvihgtvghsrdhpihhnghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiug
    drrghu
X-ME-Proxy: <xmx:5IGJXoUMkaRJo6jN3vOIm7edHXudlz9cSM0j6tpYFurIuA7U-IYdnQ>
    <xmx:5IGJXvCM5nfC-tJ_HT3EdJZkXcpgb3h5JENEvcJysnffznYFloNhjw>
    <xmx:5IGJXslnrlyKOycSkd-ZzaXEsrp6Cgglk7UNiANZGtnAa-OYfektrg>
    <xmx:5oGJXtU6C2CZPne5rDC3sbV-JSzh2weW3z2qanuGgwholBRpBXk-Qg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A15A8E00B1; Sun,  5 Apr 2020 02:59:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1082-g13d7805-fmstable-20200403v1
Mime-Version: 1.0
Message-Id: <69bfc045-2059-4d37-af7a-52f5840664cf@www.fastmail.com>
In-Reply-To: <20200403130840.GR2910@minyard.net>
References: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
 <7734002a-181e-4baf-b9a3-af66894acc16@www.fastmail.com>
 <20200403130840.GR2910@minyard.net>
Date:   Sun, 05 Apr 2020 16:30:09 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Corey Minyard" <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net, mark.rutland@arm.com,
        devicetree@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Haiyue Wang" <haiyue.wang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_0/3]_ipmi:_kcs-bmc:_Rework_bindings_to_clean_up_?=
 =?UTF-8?Q?DT_warnings?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Apr 2020, at 23:38, Corey Minyard wrote:
> On Fri, Apr 03, 2020 at 02:20:21PM +1030, Andrew Jeffery wrote:
> > 
> > 
> > On Mon, 16 Dec 2019, at 12:57, Andrew Jeffery wrote:
> > > Hello,
> > > 
> > > This is a short series reworking the devicetree binding and driver for the
> > > ASPEED BMC KCS devices. With the number of supported ASPEED BMC devicetrees the
> > > changes enable removal of more than 100 lines of warning output from dtc.
> > > 
> > > v1 can be found here:
> > > 
> > > https://lore.kernel.org/lkml/cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au/
> > > 
> > > v2 cleans up the commit message of 2/3 and changes the name of the property
> > > governing the LPC IO address for the KCS devices.
> > 
> > Ping?
> 
> Sorry, I've been busy.

No worries, so have I. I was surprised when I found it had been 4 months :)

>  I've looked this over and it seems ok, and it's
> in my next tree.

Thanks.

Andrew
