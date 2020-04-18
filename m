Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4613A1AF2C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDRRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgDRRSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 13:18:01 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB929C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 10:18:01 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z17so4266959oto.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+oZTiGzIoWEHUhsSEJXo36P9ufCGQX7Nm3qT2iRUFY=;
        b=VCUBphP/lQCBjUcR7RKTO5AyHZnA5qXxncxIH5PIKb+sZANfhgpsE3FbRQbpomso1u
         kyeiFldVaDWbocm0Yq/J1DTutETMYlxFX8Q8megLpvw13CoQ0cbeiPKWV0QbpZ/KOG/e
         6arSG3WmnxwJ1slfcuCPGLouKHNsxDhU0sLhK9XTD+h5sB0VR7KJ/IbEUyRsPJEi0Vx5
         QJpiSjeFfvA01/4M0tBaR0QA30bdtWdSoTS/Dbxo2VKgO9JNcB376uRFxGXqNBSL7vnU
         F+3vU7aP/us5dEocRP88L/slTkPRWmTpD6bI0Ic3N6HdbqqNfi+5PwL09b116YyjqC2k
         8B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+oZTiGzIoWEHUhsSEJXo36P9ufCGQX7Nm3qT2iRUFY=;
        b=FkWynNOCD47UyqtarNGLoaAOhinRnGQzlQleK2J+wbxT9rsfk1/6phiN6eMMPJY303
         ep5nAb3aTqntQd/WNMnM4is2gEUsyhLoBubQ4NL7yPS24DPC2ue0aw80Q26o08CaKcVq
         uNKLfgSFzU2hqAZe0SuauEuCPiRrn3NM/vPUnbXXFIC+3Bjsp3S08pLwQuJKTasZzqum
         iJPfSO95VRvEevrJHmnWCol9HtpdUffKjxKj0bfgytWtV342GxcegIt9J+Y7Nb6B5Bv5
         wv93z5z8wtjsw1E8I8+yY3BN/nomANlgvI47ZJUTJcwBDg4tJrWPfr01nV/WuGSbkYGO
         YhzQ==
X-Gm-Message-State: AGi0PuaSXU/GQSY4EMLY+RF25fWubnjxCYCeJx7dWoWN1x1OJPNNrjrV
        gEyZxg2eLaJW8j2kz8I+PuG5T4KM2dAhNVlKw1s=
X-Google-Smtp-Source: APiQypK8OgOgvTM7AGxxDFGet6qN4tXXkUZmb198A2VVE21x08Kpvee6icHe4AebyfZGwiXHgBvFlWQCcO4rldfTcaQ=
X-Received: by 2002:a9d:ec1:: with SMTP id 59mr1330816otj.143.1587230280929;
 Sat, 18 Apr 2020 10:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200418082440.21277-1-oded.gabbay@gmail.com> <3fcee921-3eba-b7e7-8adf-d95db9aeeed2@infradead.org>
In-Reply-To: <3fcee921-3eba-b7e7-8adf-d95db9aeeed2@infradead.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 18 Apr 2020 20:17:33 +0300
Message-ID: <CAFCwf10B+HRP7PfPv4G3aug4mXLfv-SoNt9eMpH_DJusr_25Aw@mail.gmail.com>
Subject: Re: [PATCH 1/5] habanalabs: Add INFO IOCTL opcode for time sync information
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 6:31 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/18/20 1:24 AM, Oded Gabbay wrote:
> > From: Tomer Tayar <ttayar@habana.ai>
> >
> > Add a new opcode to the INFO IOCTL that retrieves the device time
> > alongside the host time, to allow a user application that want to measure
> > device time together with host time (such as a profiler) to synchronize
> > these times.
> >
> > Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> > Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/goya/goya.c           | 10 +++-
> >  drivers/misc/habanalabs/goya/goyaP.h          |  1 +
> >  drivers/misc/habanalabs/habanalabs.h          |  2 +
> >  drivers/misc/habanalabs/habanalabs_ioctl.c    | 19 +++++++
> >  .../include/goya/asic_reg/goya_regs.h         |  1 +
> >  .../goya/asic_reg/psoc_timestamp_regs.h       | 56 +++++++++++++++++++
> >  include/uapi/misc/habanalabs.h                |  8 +++
> >  7 files changed, 96 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_timestamp_regs.h
>
> Hi,
> Not a comment about this patch per se, but ioctls (main number, 'H' in this case)
> should be documented in Documentation/userspace-api/ioctl/ioctl-number.rst.

I'll send a patch, thanks for telling me.
Oded

>
> thanks.
> --
> ~Randy
>
