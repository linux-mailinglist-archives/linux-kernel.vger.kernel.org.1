Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17259294409
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 22:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409593AbgJTUlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 16:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409541AbgJTUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 16:41:22 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C05BC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 13:41:21 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id t67so805218vkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 13:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oNb4bPuTPJc9IazjKYiO1BrhZxahR3FAJrD2QNpZEE=;
        b=GoQ+EVKaGML1O0xuJJyCjTyBiaV9U1ZfOBGG8NL6oeTeU5wmSLXa0hXtERape/LFcS
         qtAE7eYPxGswSe7yyoFdd27uU/nT8A6GhdRO4zLnhYDUh1mpbyNp66Mfg/QfLYOugVpR
         H07ef9O5BRyU6uQFsy3Yu6D/+/T9GWoSvHj4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oNb4bPuTPJc9IazjKYiO1BrhZxahR3FAJrD2QNpZEE=;
        b=DoAVCTyNRRrU9c7l+7L8x2CUoHrJ5WiArJh+EwfJ7/gWFbBJcIGshqO81B5VLdEchL
         G5+IqaabXOuzxIHz35iAE8/uh0zUpqjbxP+kPm9CvFX96plIuFFTIvutHeHcxpWXzKy0
         5yid3gd7Rq0mItE9EzZc6wLy+KCHdOluVheHAetGBXjA7rUfyHd5KqwwFRdzFMQ81ZaP
         KBbV5iWDtA7VsTz47BMHXyawkOrliDtSW2sVTjtjkkk/bJnMkZDFAf01LzCXMPcQm6So
         DanUTUJi4yruqZcBemq5Yh47rXNiPuhKpeMsHBRPYVJxksADIYjW8Qe6BjKNLJNZ8j7R
         j4mw==
X-Gm-Message-State: AOAM533eR5/luo4giYQ0SXOrwwyoc4W5mvDRjjfcoKibuOI/Tg8+urFy
        vpWMZcgM7+PY2SvMP3860eiFcn5li/T+/+2dy6AWTQ==
X-Google-Smtp-Source: ABdhPJzr5l3bDAXW3EOAftEuudCHyMKi5cGy1Hw3cWDeuY2TudVm6cfkI7qnQuUSnjYigue2Up2FbPDYaIBW9jh8e/k=
X-Received: by 2002:a1f:9d0e:: with SMTP id g14mr2712231vke.2.1603226480594;
 Tue, 20 Oct 2020 13:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <b74ea9cb201bb98691ecbfb3893d2a49@codeaurora.org> <CANFp7mXMfvHrAcaJhY7q2oZk3MtqOMxLGOEpNc-hnzVSyA+LZA@mail.gmail.com>
In-Reply-To: <CANFp7mXMfvHrAcaJhY7q2oZk3MtqOMxLGOEpNc-hnzVSyA+LZA@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 20 Oct 2020 13:41:09 -0700
Message-ID: <CANFp7mWTPLKx=eKxgZvXGEPi5KbphDJnSGZb12Efe_SWTKdDdg@mail.gmail.com>
Subject: Re: Update WCN3991 FW file
To:     asitshah@codeaurora.org
Cc:     linux-firmware@kernel.org, jwboyer@kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Hemantg <hemantg@codeaurora.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like we hadn't merged an earlier update to crnv32.bin in ChromeOS:
ad1da95 - QCA : Updated firmware files for WCN3991 (3 weeks ago) <Asit Shah>

After merging that commit, everything is working as expected.
--

Tested-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

On Mon, Oct 19, 2020 at 2:37 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Nack.
>
> This resulted in a boot loop on ChromeOS. It looks like only
> 'crbtfw32.tlv' was changed and not 'crnv32.bin'.
>
> Abhishek
>
> On Sat, Oct 17, 2020 at 8:33 AM <asitshah@codeaurora.org> wrote:
> >
> >
> > Hi Team,
> >
> > Please include updated firmware bin for WCN3991.
> >
> > Snapshot of pull request is as below, let me know if anything is
> > missing.
> >
> > >>>>>
> >
> > The following changes since commit
> > 58d41d0facca2478d3e45f6321224361519aee96:
> >
> >    ice: Add comms package file for Intel E800 series driver (2020-10-05
> > 08:09:03 -0400)
> >
> > are available in the git repository at:
> >
> >    https://github.com/shahasit/bt-linux-firmware/tree/master
> >
> > for you to fetch changes up to 8877322c1254f327f47c86ec02c46013b68b9a47:
> >
> >    QCA : Updated firmware file for WCN3991 (2020-10-17 20:53:36 +0530)
> >
> > ----------------------------------------------------------------
> > Asit Shah (1):
> >        QCA : Updated firmware file for WCN3991
> >
> >   qca/crbtfw32.tlv | Bin 126300 -> 126832 bytes
> >   1 file changed, 0 insertions(+), 0 deletions(-)
> >
> > <<<<<<
> >
> > Regards,
> > Asit
