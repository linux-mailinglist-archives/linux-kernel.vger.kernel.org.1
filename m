Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4230F2C9EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgLAKOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:14:06 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57927 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgLAKOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:14:06 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E6AD5C01AC;
        Tue,  1 Dec 2020 05:13:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 01 Dec 2020 05:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ohA2m+90xWVxjgA50kn2nwJYkqy
        mfPqLe0rbM0A0sNk=; b=IZZHn6VqIKzfzxlxcGUOmFBgG77vtwDt62DbI3wwY9D
        jcwtd+PVh4w0wgsU7Z6TlLqYvK8/bIBwObi1PGUHJdy0JEf4Pq3b0D2TRvJY2KXx
        x3IJxaxveg8d1UgaMYs2hUitjpQuG8cXwOAHzKjrDC7BG+zQ8l5kZycLrDVxjHVH
        8U3Ns0CF5jAmqh0Xd1uSzvQFXujM/uFHU6MV25H0QQJcWoqqgAB/WizOeWNazAfV
        5N8ncvS7uf13jvveoTNRm4oxMYLjnoDuZ2FSx83juZ1zZlY5QlXUc68aTwwr5PAi
        SrlfMZNjMHWgt+WKS+XXkwkvuLld0iX/U4dz6NcHdqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ohA2m+
        90xWVxjgA50kn2nwJYkqymfPqLe0rbM0A0sNk=; b=DxClw1TzSEy73lYiSxESdK
        64mIBgmhhyLv6W5HWVt0oJ5/5fAHxUsWuq7nSRMowLnyopmY5vDsZaGBGZlwerbe
        nQxu1WEDtwRFsF4ADvTc/QF8hCtRXj0wxG6HDrmpdvZsw0DosygOWZbZtuAPzJkR
        PL+bKG7kntOs1is8TJ44NUAYpkSH3OIqu9XIN1FvTyJwTE91ssIv+h9jF9FWM0SJ
        CweCzdZQ6CkDWGwZgJHHMdhvGgByBLTatg7Jkv4l3DibTlzdT3xq5URn54U5ciYm
        swhR7pxYOlHXfhxxdEGQ4KKMI36GB1hldr5GSsT6jNiOUm/0S2Erm1FDM7nC9xcw
        ==
X-ME-Sender: <xms:KxfGX6GMaper7m91ISnoDrftxU2izPc3XAj1Hhvxg4w_68YLSvAyaA>
    <xme:KxfGX7WiGL0ZhF2YX3ootQuAE6neQ6guKoZWP5K4Z5CTucmfiM9wpBqXfjAlVg7bc
    lrP5YkdKKKtrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:KxfGX0I96JF6TsqZ9kNrs7rbPfOsA-3LemmGha6Kp73tpujoj4ZsTA>
    <xmx:KxfGX0HNpsCJ6703ClberZbVZxbYfaVcZbZFRPB9SAllHFe4jAdDlw>
    <xmx:KxfGXwWPnbWrhXQrzwwFlD8dTOtkdZdJw0pR__judTL4mlUKa-2WUA>
    <xmx:LBfGX7fft5OORnKxFzEVFpmSpM6JHNWehUh5oo9GV2rqupNDVD4HIw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5AECD108005E;
        Tue,  1 Dec 2020 05:12:59 -0500 (EST)
Date:   Tue, 1 Dec 2020 11:14:12 +0100
From:   Greg KH <greg@kroah.com>
To:     mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, markgross@kernel.org,
        adam.r.gretzinger@intel.com
Subject: Re: [PATCH 00/22] Intel Vision Processing Unit base enabling part 1
Message-ID: <X8YXdJ2CDg2TI5LF@kroah.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130230707.46351-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 03:06:45PM -0800, mgross@linux.intel.com wrote:
> From: mark gross <mgross@linux.intel.com>
> 
> The Intel Vision Processing Unit (VPU) is an IP block that is showing up for
> the first time as part of the Keem Bay SOC.  Keem Bay is a quad core A53 Arm
> SOC.  It is designed to be used as a stand alone SOC as well as in an PCIe
> Vision Processing accelerator add in card.
> 
> This part 1 of the patches make up the base or core of the stack needed to
> enable both use cases for the VPU.
> 
> Part 2 includes 11 more patches that depend on part 1.  Those should be ready
> in a couple of weeks or less.
> 
> I am trying something a bit new with this sequence where I've been working with
> the driver developers as a "pre-maintainer" reviewing and enforcing the kernel
> expectations as I understand them.  Its taken a couple of months to get this
> code to the point I feel its ready for public posting.  My goal is to make sure
> it meets expectations for quality and compliance with kernel expectations and
> there will be mostly technical / design issues to talk about.
> 
> Thanks for looking at these and providing feedback.
> 
> --mark
> p.s. I have had a problem my MTA configuration between mutt and git send-email
> where I was using msmpt to send from mutt (because 15+ years ago its the first
> way I got to work and never changed) while my worstation MTA that git
> send-email uses was un-configured resulting in my return-path naming my
> workstion withing the firewall.  I suck at email administration.
> 
> I appologies for the multiple copies.

Ah, here's the full set of patches...

But, you didn't cc: everyone on them, some of us just got a partial set
of patches, why?

still confused,

greg k-h
