Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE62FF3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbhAUS6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhAUSoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:44:03 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21899C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:43:23 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a25so2538206ljn.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEyPkGuZgEmlb3GVGK4qsioYTas+5G0misdXcaiuvdE=;
        b=SiFR69l9jFst8GT76T/ChdmOrcBNxQX4OVSfHQxmZ/RsQneVBzp60MKTByJyA3TIo0
         yrd5P2y8aj2U/hHPUIGafsrH3Nm3RB6XfIZfO4FjlwWUBMMgBRMykpF4oqT4l8U7Z55G
         Yv3Vx5npggEpS/+ViAqDSFUQU1FeSvaDCBh7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEyPkGuZgEmlb3GVGK4qsioYTas+5G0misdXcaiuvdE=;
        b=LEtFRLIbvuIPKJglmpQv71euFSo2AUI3MJ//kmxM85DPwLS5sWssbTLX1+AJVztzD7
         YRLrSI3tyjb+JTPc9vbAMGlyCZe8D6TtA+YZFd1Rg/1VUVmzsWSrkxFqMN7qc5+mKIJY
         j/2BMHMgsDIfDUcMpxnt/rTjYjuLbLZrBdND+DsYpvkmJ4mC6hAWw1nxO6nk0GPxTZNn
         du237z1Qbwj+fsoXBkqW3ETm+4lV7GAArATARrniYVJD9RcuhPZSSq+3Y3oG0OW+HtLW
         148hyxArPNf5BqFINQsfVZxMh6aB71sPR499dDLw7U3z+w8t1gScE2618TUODL8oWUOX
         3Edg==
X-Gm-Message-State: AOAM531A0xWG/dVA9TWuxLRRCB6Bl7Q6L91SBEzLtq+6/l9tXhxyZU4s
        ABnpNkH8Tn2HCr5t8gv2Q5n+YROo4GNV0w==
X-Google-Smtp-Source: ABdhPJzwpijmflMy6AS5OO2x0Ul9wrRJpeDOzqTWMUCC5tppF+8qKyfDVTu/8373DOTq1lIZXdWGew==
X-Received: by 2002:a2e:3201:: with SMTP id y1mr356586ljy.12.1611254601312;
        Thu, 21 Jan 2021 10:43:21 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 189sm605826lfj.192.2021.01.21.10.43.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 10:43:19 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id u25so3991594lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:43:19 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr261220lfu.253.1611254599287;
 Thu, 21 Jan 2021 10:43:19 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
 <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc> <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
 <54108069-3ef4-c02f-b824-d24da79e0009@phytec.de>
In-Reply-To: <54108069-3ef4-c02f-b824-d24da79e0009@phytec.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jan 2021 10:43:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wisqPOnF4TU1H=80L++4iLnKD54uKe1hUZgo_edKPJb1g@mail.gmail.com>
Message-ID: <CAHk-=wisqPOnF4TU1H=80L++4iLnKD54uKe1hUZgo_edKPJb1g@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Robert Karszniewicz <r.karszniewicz@phytec.de>
Cc:     Oliver Giles <ohw.giles@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 9:03 AM Robert Karszniewicz
<r.karszniewicz@phytec.de> wrote:
>
> I confirm that the 4 patches, as well as the 4+2 patches, fix the regression I
> noticed with cat failing on sendfile() to ttymxc0.

Thanks. Now we just need to find somebody with HDLC use cases and
we'll actually have this series properly tested...

          Linus
