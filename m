Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5507B2D22F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 06:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgLHFSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 00:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgLHFSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 00:18:40 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BFBC061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 21:18:00 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2so8881554pfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 21:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6B27MjfiQVy0rXuqasBw27ufwoC3xQGBEn2nziAxKKw=;
        b=MxvmroRxK7TMgJsiKckqSSoIB1O+g9Hvlhy4w/byUGZUDIJ6Jg1CBBkjd8zwI+Uc4T
         8OrBN1jwckJQo+Xuo17WQmP+SiKRlvKZY9ux9srN+/s3vucDJ0/32U43b2mz13WU5/k+
         K6oArXu2qDuUK1hGbaOmAokFYwVPGvmt5B1/uCbXhVK0r4JgsxzIEdgaHStnW4pG/4p3
         XHHtaKke6fFEMUTOLi4eVH5LfFj1OSW8ucnYpAO0LM9fIUSpnnsmdCypbtWGcBpM2a2f
         OXmAQ7tp4kwE39Lvfxs9DEfDO3udXI5o0T6joSdPWXuN4rWa49yuH/i14tGxVCbC79lw
         ic2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6B27MjfiQVy0rXuqasBw27ufwoC3xQGBEn2nziAxKKw=;
        b=eXHyF/eTHq0S3H40o8gHaguZWT1sUPNoZw0daGLifG/AF3Sn5a21bk5Hx3xB0YjwSG
         8ya2e0zl5JIAfMmthbilblI0fQAkPtx5pjKaDKjx7znfDKDrtzKove/5cqWKqpOrOA9K
         nojkTtsjAgsa1F7uRO3L51jV9si4Vf79o/2dOgtHgCoxCBcwp0dSc3ATWzfPR79qsfRD
         K/6KLjaUfMt7uR6xQcHxVHCJQRUfahy14aIs2moOAW2m6KW6navAVEL4qmYrgz4HH3zh
         l9NvUqBsyHvK4KZBb7B6DNRTV5+GTmJto90KRI7BT8WDkRxr+gUJLoPBM5myPYVXdcdb
         Ix4A==
X-Gm-Message-State: AOAM531/EwgqKVbJIiMM0xx3FryJPhaOjYM/S/s2c/sCt4p9X0nbMQ2Z
        BqM0V6A5sPynN5RfwxQEwogTuvhnJ/yG9pSiWvkqcQ==
X-Google-Smtp-Source: ABdhPJxAyat6w/s5kIrYWRiG8fkEEx0Fy4ugnBvg0BiPnvUvHJ9D+f7afjLBBjveFnwE5uOkVGTPnEKZr1qNWQiKdYw=
X-Received: by 2002:a62:1dd5:0:b029:19d:fc87:5f45 with SMTP id
 d204-20020a621dd50000b029019dfc875f45mr9281048pfd.63.1607404679429; Mon, 07
 Dec 2020 21:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20201207073346.16571-1-chiu@endlessos.org> <s5h360i2eov.wl-tiwai@suse.de>
In-Reply-To: <s5h360i2eov.wl-tiwai@suse.de>
From:   Chris Chiu <chiu@endlessos.org>
Date:   Tue, 8 Dec 2020 13:17:48 +0800
Message-ID: <CAB4CAwcuZxz260Q=7VntkZnit_x0K4Pthcdnv1xD=NgmcRCDew@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek - Add support for Memeza EDL03 headset mic
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, Kailang <kailang@realtek.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux@endlessos.org, Jian-Hong Pan <jhp@endlessos.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 4:38 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 07 Dec 2020 08:33:46 +0100,
> Chris Chiu wrote:
> >
> > The Memeza laptop EDL03 with codec ALC256 can't detect the headset
> > microphone. The headphone jack sensing works after we add a pin
> > definition for it by ALC256_FIXUP_ASUS_MIC_NO_PRESENCE.
> >
> > Signed-off-by: Chris Chiu <chiu@endlessos.org>
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> >  sound/pci/hda/patch_realtek.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index d5e4d0ba1008..8b9b94cfc67e 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -7871,6 +7871,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >       SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
> >       SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
> >       SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
> > +     SND_PCI_QUIRK(0x10ec, 0x115a, "Memeza EDL03", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
>
> This looks suspicious.  10ec is the vendor ID for Realtek, i.e. it
> implies that the BIOS on this machine didn't give the proper unique
> ID.  As you can see, the other entries with 10ec are only reference
> boards.
>
> If the newer BIOS still doesn't fix the PCI SSID, you can check the
> codec SSID instead.
>
>
> thanks,
>
> Takashi

Thanks for the feedback. This is a special case that the ODM didn't
flash the DMI information
and assign a formal SSID. They simply ship with the current status w/o
any BIOS customization.

I agree that we should push the vendor for a BIOS fix or figure out a
generic solution for this
instead of a pin quirk. Please ignore this. Thanks

Chris
