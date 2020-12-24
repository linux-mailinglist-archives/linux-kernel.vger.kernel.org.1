Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC212E25D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 11:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgLXKCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 05:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgLXKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 05:02:49 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB8C061794;
        Thu, 24 Dec 2020 02:02:09 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id n127so350648ooa.13;
        Thu, 24 Dec 2020 02:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FdH9kHukbpEmlFgJThukrwd7alESrljVgzVGQtLzes=;
        b=Jh9iCKv3tpQnsnq/njrR4qcIR9jH+SwfR3DtYQrS7N83g1xQMf4ZrOl2OxBKkFk1da
         UmzO3jJXSSs2wpteQZArtXXrJywhn7kFxKbe2pKtghfgh8elYdgHHSGH3B5hO/J/qnqD
         2mHB8JOPGIVKPdro8zF2fGlUj4p5CC5ZcA4G3lu9SUxQZHKtNh1HDewsDEA5D54JaogW
         +2aY7CkHAwbCQ9U3Uku5db/7dIswUKUrHDaoCFcaLlJ9JsrFsShmYehqo2iLd8bIVXMQ
         HhWn7kbzYAVLJoCwKedPXCJ/JjJXnw+AJH/shYwccogan8VpwqYaghcpmPP6lyNxS6c0
         35Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FdH9kHukbpEmlFgJThukrwd7alESrljVgzVGQtLzes=;
        b=lqapZYxTFPbvr9nahGv8tWKVH82el/ZifqFwsYSfzMuuEonYPhUHShVAePuF85abAT
         /mtW+glwiFNphgdEndko3ZbGW5Gc+qlh60slUZPX1gXmUmIYuy8FrGOZ1k66uxalP2F6
         xpRlvVVUoToYkGL5Nkx1kELvkQxDXnVbw4i0fEwkxnIlwXegxMK0qocUIm9EYj0Rf9PP
         0cyhtkq8TpeQdtnJCn1cwvV+KyKFLEmu2ZF8HcTBcW+kZXjfTeD9w9ebkucdfk0g7VWo
         fEnuEp4MCcGRle7y+iSFTCPHddQyljUKCv/YxUkv+qpquCU8OIEeBA+skGfaoozuwjhE
         aUAg==
X-Gm-Message-State: AOAM533Ic/lliV7CLRsh38SBxSjcM4p3KZR/UBPb/MtLUQ9SFGuqIi3m
        2StYeGtzxn6I0A3VpKPxtIOjgX+g+tm5yyOmpS012wjbSf4=
X-Google-Smtp-Source: ABdhPJwBBv1fYfwKN7MW5t0f5xCBW3D3C4A1NT3yVjluA/PFPJneiDCTfz2Evu0QGwasq19Fp8zW+lNqhyTGRVuaAyg=
X-Received: by 2002:a4a:e14f:: with SMTP id p15mr21032818oot.25.1608804128909;
 Thu, 24 Dec 2020 02:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20201104064703.15123-1-himadrispandya@gmail.com> <X8n8yR5At1ptPkQ4@localhost>
In-Reply-To: <X8n8yR5At1ptPkQ4@localhost>
From:   Himadri Pandya <himadrispandya@gmail.com>
Date:   Thu, 24 Dec 2020 15:31:57 +0530
Message-ID: <CAOY-YVmDW0E9Wfs-K2w5+DP4qJgn6_j_OWnGu_zSK_qGqoiXvw@mail.gmail.com>
Subject: Re: [PATCH 00/15] usb: serial: avoid using usb_control_msg() directly
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 2:38 PM Johan Hovold <johan@kernel.org> wrote:
>
> Hi Himadri,
>
> and sorry about the late feedback on this one. I'm still trying to dig
> myself out of some backlog.
>
> On Wed, Nov 04, 2020 at 12:16:48PM +0530, Himadri Pandya wrote:
> > There are many usages of usb_control_msg() that can use the new wrapper
> > functions usb_contro_msg_send() & usb_control_msg_recv() for better
> > error checks on short reads and writes. Hence use them whenever possible
> > and avoid using usb_control_msg() directly.
>
> Replacing working code with shiny new helpers unfortunately often ends
> up introducing new bugs and I'm afraid there are a few examples of that
> in this series as well.
>
> I'll comment on the patches individually, but my impression is that we
> should primarily use these helpers to replace code which allocates a
> temporary buffer for each transfer as otherwise there's no clear gain
> from using them.
>
> Some of your patches contains unrelated changes which needs to go in
> separate patches if they're to be included at all.
>
> Please also try to write dedicated commit messages rater than reusing
> more or less the same stock message since not everything in these
> messages apply to each patch. You never mention that these helpers
> nicely hides the allocation of temporary transfer buffers in some cases
> for examples. In other places they instead introduce additional
> allocations which at least should have been highlighted.
>
> > Himadri Pandya (15):
> >   usb: serial: ark3116: use usb_control_msg_recv() and
> >     usb_control_msg_send()
>
> Nit: please also use an uppercase "USB" prefix.

Hi Johan,

Thanks for reviewing this series and sorry for the late reply. I'll
soon send a v2 according to your comments.

Best regards,
Himadri

>
> >   usb: serial: belkin_sa: use usb_control_msg_send()
> >   usb: serial: ch314: use usb_control_msg_recv() and
> >     usb_control_msg_send()
> >   usb: serial: cp210x: use usb_control_msg_recv() and
> >     usb_control_msg_send()
> >   usb: serial: cypress_m8: use usb_control_msg_recv() and
> >     usb_control_msg_send()
> >   usb: serial: f81232: use usb_control_msg_recv() and
> >     usb_control_msg_send()
> >   usb: serial: f81534: use usb_control_msg_recv() and
> >     usb_control_msg_send()
> >   usb: serial: ftdi_sio: use usb_control_msg_recv() and
> >     usb_control_msg_send()
> >   usb: serial: io_edgeport: use usb_control_msg_recv() and
> >     usb_control_msg_send()
> >   usb: serial: io_ti: use usb_control_msg_recv() and
> >     usb_control_msg_send()
> >   usb: serial: ipaq: use usb_control_msg_send()
> >   usb: serial: ipw: use usb_control_msg_send()
> >   usb: serial: iuu_phoenix: use usb_control_msg_send()
> >   usb: serial: keyspan_pda: use usb_control_msg_recv() and
> >     usb_control_msg_send()
> >   usb: serial: kl5kusb105: use usb_control_msg_recv() and
> >     usb_control_msg_send()
> >
> >  drivers/usb/serial/ark3116.c     |  29 +----
> >  drivers/usb/serial/belkin_sa.c   |  35 +++---
> >  drivers/usb/serial/ch341.c       |  45 +++-----
> >  drivers/usb/serial/cp210x.c      | 148 +++++++------------------
> >  drivers/usb/serial/cypress_m8.c  |  38 ++++---
> >  drivers/usb/serial/f81232.c      |  88 +++------------
> >  drivers/usb/serial/f81534.c      |  63 +++--------
> >  drivers/usb/serial/ftdi_sio.c    | 182 +++++++++++++------------------
> >  drivers/usb/serial/io_edgeport.c |  73 +++++--------
> >  drivers/usb/serial/io_ti.c       |  28 ++---
> >  drivers/usb/serial/ipaq.c        |   9 +-
> >  drivers/usb/serial/ipw.c         | 107 ++++++------------
> >  drivers/usb/serial/iuu_phoenix.c |   5 +-
> >  drivers/usb/serial/keyspan_pda.c | 172 ++++++++++++-----------------
> >  drivers/usb/serial/kl5kusb105.c  |  94 ++++++++--------
> >  15 files changed, 406 insertions(+), 710 deletions(-)
>
> Johan
