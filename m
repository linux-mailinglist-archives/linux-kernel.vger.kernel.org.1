Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828FD26DC2F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgIQMzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgIQMw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:52:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:52:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id j2so2360203eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BdxYdx9XHrwCdr4dzP1oTYv5YWLs/o7KoSb8tPS/nSw=;
        b=ccM+MAvgoCEG4vttx6xCSHufmhS0PZEIedC4PRllc90ud3FF8xpocJ7v7zm20tcZYk
         Y48aDJAb/rrKj3Xk9P9KO5CaLGn7plZ1ehW8ylgxUpcRcso5dQy13FdSnUuMHNijRgVu
         AVICzFSg+9EIXT1tbDVLJQ1WvvZSzYcw1XHl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BdxYdx9XHrwCdr4dzP1oTYv5YWLs/o7KoSb8tPS/nSw=;
        b=Sv4RDmCznp3cZsMRntEsKs9kZb2ycrfRxuPx4nvWc/3/NhsPv81yMpC4y8nWjGJbFA
         NdgZIj/Cy/LhU6sPzafE4rDzj9hTZe9+4l50Hi9JG+YnGBoTPfpbvgPF7RMzOXVa4gO9
         lmINjv6DQQFIoVKQdkVs6fhcvPZciLvxvWVnDFdRM+v1xrt37y+4MjOnXZQ70h1NBEIQ
         qTImhCMmaLAprTz6YAogdb68erg03xEGbXn1m3Fzy3yiotLFm3c69Ts+gmMlw/BVbDTq
         AXlN2RSuTFQbJQW3rXv2oVndUkHQge/PweB8erOpvx1HYXb1dFXdJFDaqhZ7fkzoO5Zg
         ly6g==
X-Gm-Message-State: AOAM533omF7UeIXBkl2PTL4uW2I8SaR5kn0S0boUfhvQnen5wsVRjl/Q
        mPFP5HnxMO6OG2ApIDxQCKcphxrIiSC9kA==
X-Google-Smtp-Source: ABdhPJzj1jqjT1NrApP9K76okoSugoFVV/TkImBHnJWFHre3tf44jLdTQD5XlVbEInzs4J8ahJMvWg==
X-Received: by 2002:a50:875c:: with SMTP id 28mr32718732edv.20.1600347172766;
        Thu, 17 Sep 2020 05:52:52 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id ly16sm15096777ejb.58.2020.09.17.05.52.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 05:52:51 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id d4so1852611wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:52:51 -0700 (PDT)
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr9361892wmi.99.1600347171113;
 Thu, 17 Sep 2020 05:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200502194052.485-1-andriy.gelman@gmail.com> <21733d1ad3c2f79a5646b4f1c541dfabda0978be.camel@ndufresne.ca>
In-Reply-To: <21733d1ad3c2f79a5646b4f1c541dfabda0978be.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 17 Sep 2020 14:52:33 +0200
X-Gmail-Original-Message-ID: <CAAFQd5B+5Zb7pzyQga+-KjfzUCYpuC1oPRjMXsTKHJzJAcmgdw@mail.gmail.com>
Message-ID: <CAAFQd5B+5Zb7pzyQga+-KjfzUCYpuC1oPRjMXsTKHJzJAcmgdw@mail.gmail.com>
Subject: Re: [PATCH] media: s5p-mfc: set V4L2_BUF_FLAG_LAST flag on final buffer
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Andriy Gelman <andriy.gelman@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 5:09 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrot=
e:
>
> Hi Andriy,
>
> thanks for you patch.
>
> Le samedi 02 mai 2020 =C3=A0 15:40 -0400, Andriy Gelman a =C3=A9crit :
> > From: Andriy Gelman <andriy.gelman@gmail.com>
> >
> > As per V4L2 api, the final buffer should set V4L2_BUF_FLAG_LAST flag.
> >
> > Signed-off-by: Andriy Gelman <andriy.gelman@gmail.com>
> > ---
> >  drivers/media/platform/s5p-mfc/s5p_mfc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/p=
latform/s5p-mfc/s5p_mfc.c
> > index 5c2a23b953a4..b3d9b3a523fe 100644
> > --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> > +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> > @@ -614,6 +614,7 @@ static void s5p_mfc_handle_stream_complete(struct s=
5p_mfc_ctx *ctx)
> >               list_del(&mb_entry->list);
> >               ctx->dst_queue_cnt--;
> >               vb2_set_plane_payload(&mb_entry->b->vb2_buf, 0, 0);
> > +             mb_entry->b->flags |=3D V4L2_BUF_FLAG_LAST;
> >               vb2_buffer_done(&mb_entry->b->vb2_buf, VB2_BUF_STATE_DONE=
);
>
> The empty buffer is only there for backward compatibility. As the spec
> says, userspace should completely ignore this buffer. I bet it will
> still have the effect to set last_buffer_dequeued =3D true in vb2,
> unblocking poll() operations and allowing for the queue to unblock and
> return EPIPE on further DQBUF.
>
> Perhaps you should make sure the if both the src and dst queues are
> empty/done by the time cmd_stop is called it will still work. Other
> drivers seems to handle this, but this one does not seems to have a
> special case for that, which may hang userspace in a different way.
>
> What you should do to verify this patch is correct, and that your
> userpace does not rely on legacy path is that it should always be able
> to detect the end of the drain with a EPIPE on DQBUF. LAST_BUF is just
> an early signalling, but may not occur if there was nothing left to
> produce (except for MFC which maybe be crafting a buffer in all cases,
> but that's going a roundtrip through the HW, which is not clear will
> work if the dst queue was empty).

The spec guarantees that a buffer with the LAST_BUF flag is returned
to the userspace. In fact, handling entirely by the DQBUF return code
may be buggy, because the LAST_BUF flag may also be set for other
reasons, like a resolution change happening after a drain request was
already initiated. The proper way to handle a drain is to look for the
LAST_BUF flag and then try to dequeue an event to check what the
LAST_BUF flag is associated with. It might be worth adding a relevant
note to the drain sequence documentation in the spec.

As for the patch itself, I think it's valid, but it's a bit concerning
that the code is inside a conditional block executed only when there
is a buffer in the CAPTURE queue [1]. As I mentioned above, the driver
needs to signal the LAST_BUF flag, so if there is no buffer to signal
it on, it should be signaled when a buffer is queued. Of course it's
well possible that the condition can never happen, e.g. the function
is called only as a result of a hardware request that can be scheduled
only when there is at least 1 CAPTURE buffer in the queue. Looking at
[2], it might be the case indeed, but someone should validate that.

[1] https://elixir.bootlin.com/linux/v5.9-rc5/source/drivers/media/platform=
/s5p-mfc/s5p_mfc.c#L611
[2] https://elixir.bootlin.com/linux/v5.9-rc5/source/drivers/media/platform=
/s5p-mfc/s5p_mfc_dec.c#L222

Best regards,
Tomasz

>
> As shared on IRC, you have sent these patch to FFMPEG:
>
> https://patchwork.ffmpeg.org/project/ffmpeg/patch/20200429212942.28797-2-=
andriy.gelman@gmail.com/
>
> This should have been clarified as supporting legacy drivers / older
> kernel with Samsung driver. Seems like a fair patch. And you added:
>
> https://patchwork.ffmpeg.org/project/ffmpeg/patch/20200429212942.28797-1-=
andriy.gelman@gmail.com/
>
> This one should maybe add the clarification that this is an
> optimization to skip an extra poll/dqbuf dance, but that end of
> draining will ultimately be catched by EPIPE on dqbuf for the described
> cases. Remains valid enhancement to ffmpeg imho.
>
> >       }
> >
>
