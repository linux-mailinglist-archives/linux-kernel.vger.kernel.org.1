Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7762F256C71
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 09:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgH3HBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 03:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgH3HAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 03:00:15 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002FC061575
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 00:00:14 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g14so3066553iom.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 00:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQBUlRioMlWbPftg4AmnacybhFwBNHiRgDukSFWvsS4=;
        b=bmBMJHAXyBCFKv6Xoeg0cFFAEyerKqnUbRm1gOxQyjsHyBlchnV9nXNNKkfO7Ce2C4
         /Yg15YjWMxYO+cFvP3VdN6k10wR5hT0G9hcfiifRT7J+uvzUEPm39Xen3kLCcIeoNWVX
         UqE5Nn2aJn3xMTnAJZI3n69PcNgK4F761lvsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQBUlRioMlWbPftg4AmnacybhFwBNHiRgDukSFWvsS4=;
        b=rk4euz5ztEyb3hhZvieeE2N9d34Tx8KIdwnmDAE3iKXOQ/6/0gzG1K5UGudE+viTQN
         etx8/e5hQZhsGGihS1ag5N3g/XtUlecDW5SdAC0dgBn8E5IEJF7UeqwPJQTUpZhQsPKc
         p08ArtS/M1O6wIre4jhg8G9u9yLL+Et5i9687/7D+JAucrj4yD+6FkchhLiBQyxdj8sd
         BVSNpxBDf8eZdmCw4rm5z3vh+TFG7UEvDKwSqHGwyFQJcKK3WG7R3VtmLZmo3rFK5YM8
         oJdSh9G1m5fDHdwg3CEuz54nH+VI5e1MTHfwDRd7WDDjwCPauJmJ8d48YK2F932+FzG+
         5YXg==
X-Gm-Message-State: AOAM532LOWK3txWjgyuST7wKT24viPBaoKmZdEKr7wN43eGU6W7giRHd
        bXCwmCdskwKvmCETtrppidiZ/DcGp70+8G+OEHsXsA==
X-Google-Smtp-Source: ABdhPJz/OkkgGY1Q2elxBKoSrfB63/QFiiB/PIQmMPFGGis//WHubfzqdEVVopB2GaMlQKFzX8D8TONWfzrI/WdogBg=
X-Received: by 2002:a6b:8f10:: with SMTP id r16mr4688662iod.165.1598770813402;
 Sun, 30 Aug 2020 00:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200826002945.394562-1-gwendal@chromium.org> <20200829165433.57b0e5e4@archlinux>
In-Reply-To: <20200829165433.57b0e5e4@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sun, 30 Aug 2020 00:00:02 -0700
Message-ID: <CAPUE2uu7wQvJtesgk1sw=b7AOj7-7RW3skcvHs9y2kL_k7-tdA@mail.gmail.com>
Subject: Re: [PATCH v2] platform: cros_ec: Reduce ligthbar get version command
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 8:54 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 25 Aug 2020 17:29:45 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > By default, the lightbar commands are set to the
> > biggest lightbar command and response. That length is greater than 128
> > bytes and may not work on all machines.
> > But all EC are probed for lightbar by sending a get version request.
> > Set that request size precisely.
> >
> > Before the command would be:
> > cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 194, insize: 128, result: 0
> > Afer:
> > cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 1, insize: 8, result: 0
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Hi Gwendal,
>
> Description seems to me to suggest this is a fix?
> Are there known machines on which it doesn't work currently?
We have a prototype [without lightbar] where the command size was
limited to 128 bytes.
Given we issue a get_lightbar_version on all chromebooks, we had a
failure on this prototype. Devices with a lightbar must support a
command size greater or equal to 194 bytes.
Beside helping the prototype to boot, this patch slightly speeds up
the enumeration of devices managed by the EC.
>
> If so, please can I have a fixes tag.  If it's just a precaution
> against future problems then let me know and I can add it for the
> next merge window.
Done in v3.
Note I made a mistake by sending the patch to linux-iio as it targeted
platform/chromeos.
>
> Thanks,
>
> Jonathan
>
> > ---
> > Changes since v1:
> > - Remove BUG and TEST fields.
> >
> >  drivers/platform/chrome/cros_ec_lightbar.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> > index b59180bff5a3e..ef61298c30bdd 100644
> > --- a/drivers/platform/chrome/cros_ec_lightbar.c
> > +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> > @@ -116,6 +116,8 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
> >
> >       param = (struct ec_params_lightbar *)msg->data;
> >       param->cmd = LIGHTBAR_CMD_VERSION;
> > +     msg->outsize = sizeof(param->cmd);
> > +     msg->result = sizeof(resp->version);
> >       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> >       if (ret < 0) {
> >               ret = 0;
>
