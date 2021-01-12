Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31E12F323F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbhALNyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:54:19 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37337 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbhALNyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:54:18 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 97DD85C022A;
        Tue, 12 Jan 2021 08:53:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Jan 2021 08:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wQHIBUX95kd7FYyqstLD3bY3Dfr
        sn25GzthoZs7X/Ac=; b=V3pcoxQUY0rNSzsaAGAOloFEq5Kotrg6LPGKrQ19BVF
        dUVtjFJpcSPZ1FwJUOohF9HssfcrtJqkAN2pH77HJJAfoxlFBA4RPhMBY5f+7u7w
        qONdTzBh3NC1dQFTuJoO4cXZhoVxIkPmR/LZsK9D9GU/sbFCHmp7T5gtgCTd3KOw
        IwDm17LPmK6Mn+ATY8HsPuT7WaDBZ+dkYH3hjWiL0E7YSC7WYwNI6X94gQ2SQWsh
        y/Wad4yjdaX0c/GXAE/Zrrcjfj7UDp/ANAft0O2YCTM2FZT84PRBTupiFop3zrJS
        pvqLUK6IoMh4JwJSWhOwHSosPHapvcEA2EnMjJgBXLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wQHIBU
        X95kd7FYyqstLD3bY3Dfrsn25GzthoZs7X/Ac=; b=pBe707M//5xjdT8ZRSsjYE
        LkvmOU+vZuy1W4idgKBGkLkBIuIrhqQRCj3UYm+Kw3oJvJsGeZy7krfjmzeQTIcE
        HNz10EnTdcO/9PwEDQjGnvFsaTyctl1UfMkgiA2slP+zVDStnB7FmnFsEGL1K7Ua
        SNDy5bUPGFknT3CwbcGPCr58gCR6rsK5hJxD+iiPXmJ5fhZo7nkZ43DyeyyJK3x3
        7mseWsmxZuAbu3Mq6TDmhEEQrqkFVoQmszejCz1XenLhTAEQm7eU2jPZ4oR4BO7I
        BNQ45yTR2P8tZER9h9b7hIU5PFEPKCYW/TfWniO3qMweYxfKPYFb54j5GoKuvnsQ
        ==
X-ME-Sender: <xms:x6n9XzvUfpg0fwn8fVLWE68C5GEpeuEBQ8rw_Cp52yQmZlYcj5nxQQ>
    <xme:x6n9X0d7B_knLaOTdUr6rbdw2WP2fZPWWKHcCrDhJ3u9ASVl91h1rUx3PySEJXWR2
    _LEh6MHztMsoG2W-9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhh
    ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
    eqnecuggftrfgrthhtvghrnheplefhueegvdejgfejgfdukeefudetvddtuddtueeivedt
    tdegteejkedvfeegfefhnecukfhppeduudekrddvgeefrdejkedrheeknecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:x6n9X2yfxe9W3LbFBicMNaJgOTmuRhKIJ_SAEwxXNIOekUD-ywRefw>
    <xmx:x6n9XyNV04gig9rmkPyzBMpxWJ-PFQH8Ag4RCfKOVb5KM_mrmkroiw>
    <xmx:x6n9Xz92ADNDaoWaCNBZ1LhrHR-4dWXwOkx9gnaBrI0li8H8eJcG6w>
    <xmx:yKn9X2bUhDQhG-oiwzBAh0FKL8JCFoRYbY24rCDSspXmU6qqjBt4lg>
Received: from workstation (y078058.dynamic.ppp.asahi-net.or.jp [118.243.78.58])
        by mail.messagingengine.com (Postfix) with ESMTPA id A60C924005D;
        Tue, 12 Jan 2021 08:53:09 -0500 (EST)
Date:   Tue, 12 Jan 2021 22:53:06 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC 1/2] ALSA: fireface: Fix integer overflow in
 transmit_midi_msg()
Message-ID: <20210112135306.GB44140@workstation>
Mail-Followup-To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210111130251.361335-1-geert+renesas@glider.be>
 <20210111130251.361335-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111130251.361335-2-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 11, 2021 at 02:02:50PM +0100, Geert Uytterhoeven wrote:
> As snd_ff.rx_bytes[] is unsigned int, and NSEC_PER_SEC is 1000000000L,
> the second multiplication in
> 
>     ff->rx_bytes[port] * 8 * NSEC_PER_SEC / 31250
> 
> always overflows on 32-bit platforms, truncating the result.  Fix this
> by precalculating "NSEC_PER_SEC / 31250", which is an integer constant.
> 
> Note that this assumes ff->rx_bytes[port] <= 16777.
> 
> Fixes: 19174295788de77d ("ALSA: fireface: add transaction support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> 
> I don't know the maximum transfer length of MIDI, but given it's an old
> standard, I guess it's rather small.  If it is larger than 16777, the
> constant "8" should be replaced by "8ULL", to force 64-bit arithmetic.
> ---
>  sound/firewire/fireface/ff-transaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The rx_bytes member has value for the length of byte messages to
process. The range of value differs depending on Fireface protocol
version. For former protocol, the value is equals to or less than
SND_FF_MAXIMIM_MIDI_QUADS (= 9). For latter protocol, the value is
equals to or less than 3. Anyway, the value should not be larger
than 16777 and the calculation can be done without ULL suffix.

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
> index 7f82762ccc8c80ba..ee7122c461d46f44 100644
> --- a/sound/firewire/fireface/ff-transaction.c
> +++ b/sound/firewire/fireface/ff-transaction.c
> @@ -88,7 +88,7 @@ static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
>  
>  	/* Set interval to next transaction. */
>  	ff->next_ktime[port] = ktime_add_ns(ktime_get(),
> -				ff->rx_bytes[port] * 8 * NSEC_PER_SEC / 31250);
> +			ff->rx_bytes[port] * 8 * (NSEC_PER_SEC / 31250));
>  
>  	if (quad_count == 1)
>  		tcode = TCODE_WRITE_QUADLET_REQUEST;
> -- 
> 2.25.1


Thanks

Takashi Sakamoto
