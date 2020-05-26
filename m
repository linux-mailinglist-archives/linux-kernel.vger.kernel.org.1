Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98BB1BF68F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgD3LVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 07:21:37 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47695 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727781AbgD3LVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:21:36 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A8E65C0078;
        Thu, 30 Apr 2020 07:21:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 Apr 2020 07:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=I
        re/HJwAwgSTKygoV1QG1FpU4KijXw7qqx+Dyl1oVg0=; b=hPb9OoumKOfBNRKoZ
        mDAylm3QuVAD54VmRtRQ4JhuaUCO5pKDVDHrEVjA6KR8uS6xW1kq43lng8nhoiv9
        53VOt78WVDhmfi7A+YnUEc1hAvvzuimm+WUKg8YxcpchCorUnCOZS7ugvqjELAtv
        PskLb1UxvrfhOnenCHdh6qCwO7p4d9QawV/fYr3stY4vU79McYkbaxDkfSGvnCLv
        RPwTNNyizQ8nNqGGRt40P4jjwvxHEfH2xtvYJt2LppDx1wQknGvfbrL6mL/jvwJp
        VRcvHgV5RoJ7P/dRzxUpNv0hZjP3Bj0jpF45w1cwnQ+QJqqhoIiXfNaLiE6LJZuN
        Rw4vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Ire/HJwAwgSTKygoV1QG1FpU4KijXw7qqx+Dyl1oV
        g0=; b=i5z5kzwSx5WXlvhTbesDmQJ1xds21lhA7cjHSLXYQe8g4GGRiJOKUf5qo
        xGet1Ypri8gg3kKA/vtmdKdVypkK9UWJlkODgSdtLD+wfo8Thr0I4rHd1itpcadm
        GkvpZ1p2rS4SXNx7p/CFq9+9+TLHEeSfrdcmuUOAYDqtnoAMrbswXtLnsGVAuvZM
        prHSCFCaHyEyEZ6KKYilFKlqbnrxtqa4hXkpZvk2NYXDeCAedB3hXF03GwfCU8nN
        nAmJFP1hTkMt3ZKSQ7tIhix52nny+gTMDD99X6LmXXYQ99+BjhVl8bBPH40INHfO
        mxR/TzNcWtH7Udk55qqYjtqKqcP9A==
X-ME-Sender: <xms:v7SqXjPIdjLf5ykK2s__DmzIIc8szHlevnRmRcHWQNbgPHJrBvGsIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieehgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjgesthekre
    dttddtudenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepvedtieelueetgeeggfeufefhvefgtdetgfetgfdtvdegje
    ehieduvddtkeffheffnecukfhppeekfedrkeeirdekledruddtjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homh
X-ME-Proxy: <xmx:v7SqXoIOW-1PAZCC1GhJ-6TQE_Ezzdc0zWabuC7xqC9eKB9yI-PrIA>
    <xmx:v7SqXm4XiINvzaU00P9hr2ArkBktVNJoUWX3Ydvr-oOdAIv7enut1Q>
    <xmx:v7SqXoRWxEgHHNK-jR4yQMkOjRCdi3VZdD60IOEIe3LobRiUdCyYjw>
    <xmx:v7SqXhWmpb3H0kVaZyIkHMqIRP_dfg15mV8r2GF6V31DgavIeU9ruQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id C2B64328005A;
        Thu, 30 Apr 2020 07:21:34 -0400 (EDT)
Date:   Thu, 30 Apr 2020 13:21:31 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira shimahara <akira215corp@gmail.com>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] w1_therm: adding sysfs entry to check device power
Message-ID: <20200430112131.GA2945965@kroah.com>
References: <20200429133204.140081-1-akira215corp@gmail.com>
 <20200429134655.GB2132814@kroah.com>
 <330221588173223@mail.yandex.ru>
 <2602d65b534fc0e9d6738d3c670bdb07fd287e5b.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2602d65b534fc0e9d6738d3c670bdb07fd287e5b.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:34:03PM +0200, Akira shimahara wrote:
> Hello,
> 
> Le mercredi 29 avril 2020 � 18:18 +0300, Evgeniy Polyakov a �crit :
> > Hi
> > 
> > 
> > 
> > 29.04.2020, 16:47, "Greg KH" <greg@kroah.com>:
> > 
> > 
> > 
> > > >  +What: /sys/bus/w1/devices/.../w1_slave
> > > >  +Date: Apr 2020
> > > >  +Contact: Akira Shimahara <akira215corp@gmail.com>
> > > >  +Description:
> > > >  + (RW) return the temperature in 1/1000 degC.
> > > >  + *read*: return 2 lines with the hexa output data sent on the
> > > >  + bus, return the CRC check and temperature in 1/1000 degC
> > > the w1_slave file returns a temperature???
> > > And sysfs is 1 value-per-file, not multiple lines.
> > 
> > 
> > It was 'content crc' previously, and probably a good idea would be to
> > add just one file with 'content'
>  
> That's the purpose of the new sysfs entry 'temperature'. It only
> content temperature. As already mentionned we have to keep the w1_slave
> entry for compatibility purpose, all existing user application parse
> this file.

That's fine, but the document you wrote here says the file is called
"w1_slave", not "temperature" :)

