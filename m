Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BFC2AD0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbgKJIMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:12:23 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48569 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgKJIMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:12:23 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D3A4B5C0180;
        Tue, 10 Nov 2020 03:12:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 10 Nov 2020 03:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=U1LfiC5Xa/E1oIfmlMHoNEZwb+i
        nOk2P6HGJve+Wjqs=; b=FTPc/fhL77+zD5OahwzAQueOBSarEzpSfubCMBgKUhz
        JJwofjjQeXu7p6mWe3mSzwk9W+vDZX27NLGyHto1woOmcfQi1h+bCGL44g+vxWLr
        ga2eFHbF0g+12PjjKoffZeBbKsE3mjCb73PFadVb+gTGwYyX5LaUb3UhnKOIo/2A
        hAYA45elLVRHG0fMgwFqb0CwW4S6dJU4R6dqLa9f9EH2EqvDYaUUzE5gs7XplLat
        h10xK7o0arW7kGiG9fNjzaj3C5Q41dRMcEfR20sVT3gYapeuOEyVIMEBMo9XWDfO
        85AO29itaPzYFNg7v9e7f7LPzmJvLlQqK3COwh3Yp/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=U1LfiC
        5Xa/E1oIfmlMHoNEZwb+inOk2P6HGJve+Wjqs=; b=jzDwyVq30MthjCAju/F3md
        f+bT5ikVV2oNiWQtJFT2LVWEPzRRQbeIOvUylkgRPi7ws4VL8cJWGtUgByjelK/2
        nffC+mGube0FO0aAWWMiW7trvkQztvTPD2nVxNf5lzTJiy6Zv4bLrMBIrW/GI0i9
        2q7zP2yuYF+YHxLRFU/0g1zhKh5pqIZzv4XM19a1nj83qwxM8jg6C2shyJZBlijk
        7esWPQNNWgQ8tQo7eufv+i6/hOZ5PpFGjOPrFZHahwaGgsfc+XV+RTMKSVyr1uZz
        6gmUXKngpReKt1zyvCHGSu3moX6rXEkiYXJIwlD9OBRzgLwub9sbFipxJzLslIjw
        ==
X-ME-Sender: <xms:ZUuqX0kGhji1b0zOUEC77QCvWTIlsk2r-EbDw9rk6kVe3glkmi71Tg>
    <xme:ZUuqXz1f-NsBjojz4lc0yKxcFd7lDXdUARbEyGydWBZOByBIAYU6T69j-nbGNYvLM
    rAicWHLwuB75UuSiDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduiedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnheplefhueegvdejgfejgfdukeefudetvddtuddtueei
    vedttdegteejkedvfeegfefhnecukfhppedugedrfedrieegrddvtdejnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:ZUuqXyqz7Xcy6C696irGOpfpKpPa62ZOHMzNXWkve4jNMOOznPrqlg>
    <xmx:ZUuqXwlxyHprMiNMY8QbKU69fLrCSHnwptXKOIlt24QzX2lp6YgyFw>
    <xmx:ZUuqXy37dZuaTt8X3DTlTCZ7CCZnfDv-lU5BrK4mx8G23ezkJVyjDw>
    <xmx:ZUuqX3xWqAvlpvb53u6OTQU3XjizaegHbL9hvQqfffiRGN6ZBR_4NQ>
Received: from workstation (ae064207.dynamic.ppp.asahi-net.or.jp [14.3.64.207])
        by mail.messagingengine.com (Postfix) with ESMTPA id DFBF13063080;
        Tue, 10 Nov 2020 03:12:19 -0500 (EST)
Date:   Tue, 10 Nov 2020 17:12:17 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     xiakaixu1987@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Kaixu Xia <kaixuxia@tencent.com>,
        tiwai@suse.com
Subject: Re: [PATCH] ALSA: firewire: fix comparison to bool warning
Message-ID: <20201110081217.GA50128@workstation>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, xiakaixu1987@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Kaixu Xia <kaixuxia@tencent.com>, tiwai@suse.com
References: <1604765611-8209-1-git-send-email-kaixuxia@tencent.com>
 <s5hblg5ljp6.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hblg5ljp6.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:06:29AM +0100, Takashi Iwai wrote:
> On Sat, 07 Nov 2020 17:13:31 +0100,
> xiakaixu1987@gmail.com wrote:
> > 
> > From: Kaixu Xia <kaixuxia@tencent.com>
> > 
> > Fix the following coccicheck warning:
> > 
> > ./sound/firewire/amdtp-stream.h:273:6-19: WARNING: Comparison to bool
> > 
> > Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
 
The message seems not to reach my mailbox. Anyway:

Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> Thanks, applied.
> 
> 
> Takashi
> 
> > ---
> >  sound/firewire/amdtp-stream.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
> > index 2ceb57d1d58e..a3daa1f2c1c4 100644
> > --- a/sound/firewire/amdtp-stream.h
> > +++ b/sound/firewire/amdtp-stream.h
> > @@ -270,7 +270,7 @@ static inline bool amdtp_stream_wait_callback(struct amdtp_stream *s,
> >  					      unsigned int timeout)
> >  {
> >  	return wait_event_timeout(s->callback_wait,
> > -				  s->callbacked == true,
> > +				  s->callbacked,
> >  				  msecs_to_jiffies(timeout)) > 0;
> >  }
> >  
> > -- 
> > 2.20.0

Regards

Takashi Sakamoto
