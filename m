Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1969A1F88AC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 14:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgFNMH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 08:07:57 -0400
Received: from sonic303-24.consmr.mail.gq1.yahoo.com ([98.137.64.205]:34234
        "EHLO sonic303-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgFNMH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 08:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1592136475; bh=P/Ws/g97d9TXQGyC9BzZilU2SE7WZw+Oyu/FXGiZP3g=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject; b=JH8MJsCaikiorrI67wg5C5sxeVG1lMZzAe83cZPDhu9Oi4DysWS5cjU61R1ggnb+TIOzQ+UXMQqh9X1KSe6WlQzVP6snHFxWlAGD1C0pz6LeZ+DDkxkEBYBsUJUhmMDlQHPIrFpdB0PBL47W6WV110TzMPp+mxpQIRwjJ2iAxWRTPHg+dDhvww5jZqEJOJvZivgz3zZoeGhJsDu7JQIoag+JE6xcDzSRQPgycmNSopPcVnU13iaVjoNqwlI9LOsyn4/jVO8DM3HTb2KxgvUdvcEDVxK/9XjgvSDJKXz+dXGYHBwUiDD8caGnVt8F06Su+dHKEzTIYWwbaZBoieVHWA==
X-YMail-OSG: 0ZXeg6YVM1kHLwvs8M2uX54BmY4RStNfJoPqY9PrHlqFuNzAcvfn1k8_PN_Owup
 cFBcd77k8pKZVuG_zTqFh6nWMxhSMEvTOHQXPSKt.Si2r0lu1YT3e87btXOXdPJI5wG4RoSusbgj
 eery1EqNTrTSeWD81KSK0hulk3PZTntkufww.th2riaPEkhYV5WbtSfUYal6zhEYOYWCyzHjhOc_
 Cf6sNQLC2yW_SRiKhoC_WTJ8KDSrrtMN26gOKdxtwqOxQjlOAAHd9Uu0WxTs1jWZgYiCuGi2a.Zg
 2Wyd7TbsShaNA8.NjOdpoJ5jFjh6nLbe4IBN5dmlbGewYZV0mC7rSFJSNkD4lnnpUW97s7h3FJbj
 8lc5jyJVSOeZdpFcLaE.kvLoTKMNCIi4RnqYXg45.56kxh6yiAenAQX2AH195GDfNS8Gu1NYm3tc
 rKK4B1_zOfxL52vLQ32uLI6uypNVht7nQo.tdIvBxL9h45g2Nl.bATvQWCDaM13iz1vz2YpCrUtA
 ft60DBOVCddTukxeMVNdy4VL.bZ7FPaXbXJ6ZMb9nDrswyOlvsf5DusaNwm9CK0YpzDW.D..DG8U
 R9NKOPocXiYivVADs4sw9HVi9i1XVHUCD8TJtobXBFb_wDcryDiKyaKt0BuCGxFh6FccHwKapUps
 NVmOFH_FOBc.xRL3DlCyRHSVM_t2txWNY0vTXXMX4UTfPgfi9Arpn6BIxXKgfHof3g27mZlPq79Z
 HNnMqVVALrUFxpbideOA6N6iNTxafhHpp0JRvNzns5lqRgT4vkwFRncybcjy51law34pyCwlW23W
 LsGayPQ43uflGxVFa1X6YYZMFKrlx9qoE1oCjWwqLOIqHTZme9WQsWrVERz.ir3IQYv0w.w2n4kL
 KU8vZz2YnGA_tS.3ONgCFLXEeO3BIGiHl4_KnTu._rERzmUJYlk8m6Ncv52DMfVyDZq7xFBfY2Cl
 .HCvN0tCRk9ElQzdGQifsUx9ykQxozfEw9xew4QW8gUQD0_Kd.btRNVHp18YY..dJ3yTO4TAWDoJ
 Q8SrfRs70K6LzxN49lG3_RdL5Ot7bll37N8VoInkQ3f1FjduLrnT2XMcqvtAljVQ7A3yXP7uBVUK
 MBJTok3_lRR.us5ZHoF8meAtLPjKT57Hs1X4s36xklTC32GlQocc9HA.tILDGDWkXgyIWrZxD8cJ
 APxSNM2yX_hO2CAbGSAf3Z9l_nVQfuv8iXX0.txVKksvAJj6ht3XWcUFLmTyzp.osJlRpCVxwtQO
 Ls9oF1iBuD_WAKjXBbw4MYcBOJMrFyRs93YPmNEycl_XLm9GT9b7.HBKADxAkrgtDC7qWeDhuZ9d
 kVr6SeFYkRTdiFje_DQJDcrySXl7V3SHJXVCKbFtZO3uo..jPzGpN_m79.BxOh9.ggVtzrGSnqPW
 krFffDhdnk9bSr6c_0Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sun, 14 Jun 2020 12:07:55 +0000
Received: by smtp420.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 327748a6db7ae5cbc8970bcaad686494;
          Sun, 14 Jun 2020 12:07:52 +0000 (UTC)
Date:   Sun, 14 Jun 2020 08:07:48 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        Christoph Hellwig <hch@lst.de>, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        rientjes@google.com, tglx@linutronix.de, tiwai@suse.com,
        x86@kernel.org
References: <20200520111136.GA3802@amd>
        <1591545088.74ii116nf2.none@localhost> <20200608061950.GA17476@lst.de>
        <1591624340.z01ejtod28.none@localhost> <20200609114733.GA1621@lst.de>
        <s5hr1uogtna.wl-tiwai@suse.de> <s5h8sgtede5.wl-tiwai@suse.de>
        <1592065395.r5zwoblr15.none@localhost> <s5hv9ju9dmd.wl-tiwai@suse.de>
In-Reply-To: <s5hv9ju9dmd.wl-tiwai@suse.de>
MIME-Version: 1.0
Message-Id: <1592135950.lcpn6p9fh0.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.16119 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Takashi Iwai's message of June 14, 2020 5:54 am:
> On Sat, 13 Jun 2020 18:25:22 +0200,
> Alex Xu (Hello71) wrote:
>>=20
>> Excerpts from Takashi Iwai's message of June 11, 2020 1:11 pm:
>> > Thanks, so something still missing in the mmap handling, I guess.
>> >=20
>> > I've worked on two different branches for potential fixes of your
>> > problems.  Could you test topic/dma-fix and topic/dma-fix2 branches?
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>> > Just pull one of them onto Linus' git HEAD.
>> >=20
>> > I guess we'll go with David's new patch, but still it's interesting
>> > whether my changes do anything good actually.
>> >=20
>> >=20
>> > Takashi
>> >=20
>>=20
>> On torvalds 623f6dc593, topic/dma-fix causes sound to be output as=20
>> alternating half-second bursts of noise and a few seconds of silence.=20
>> topic/dma-fix2 appears to work properly.
>=20
> OK, thanks for the feedback!  Just to make sure, you're using
> PulseAudio, right?
> If so, it was still something wrong about mmap, and the secondary
> method (the fallback to the continuous page) looks like a safer
> approach in the end.
>=20
> I suppose that David's fix will be merged sooner or later.  Meanwhile
> I'll work on the change in the sound driver side to make things a bit
> more robust.  They don't conflict and both good applicable.
>=20
>=20
> thanks,
>=20
> Takashi
>=20

Ah, no, I think that wasn't clear. I use ALSA directly with mostly=20
default configuration, except an asym sets separate default playback and=20
record devices.

asound.conf:

defaults.pcm.card 1
defaults.ctl.card 1

pcm.!default {
    type asym
    playback.pcm
    {
        type plug
        slave.pcm "dmix"
    }
    capture.pcm
    {
        type plug
        slave.pcm {
            type dsnoop
            ipc_key 6793
            slave.pcm "hw:U0x46d0x81d"
        }
    }
}

I think I wasn't able to set defaults.pcm.dmix.card and=20
defaults.pcm.dsnoop.card for some reason, not sure why. I can try that,=20
but I don't think it will affect this mmap issue.

Thanks,
Alex.
