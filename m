Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB3F2C3B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgKYIuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgKYIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:50:52 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEEAC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:50:52 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so3005357qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiIo5gtxUukkJ1OS6WAMZc9+hs44w8+wO18W0mZxmq4=;
        b=DbiBwku7zRL2oDFQ/UeaOxiRRNmn82Kq+JPUuDCoJBTndUb8etD/USDBiZKM6IcS6q
         WxqDSpyBlCred2gMxiXXfHNy+kXxDrZPoeWnHqZ7gv1dPRDEanCflI2WDbKiwG3Yji0B
         BHHUwGvOQ6jnbhWdNSs2EBhgfVJpvdcXktL+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiIo5gtxUukkJ1OS6WAMZc9+hs44w8+wO18W0mZxmq4=;
        b=T4tu5BM0J+7NgJD0iyUzsozMDJds0Zpe8icKUWhwCGmqVhx7nl85DSEp9LFtpFkwzY
         KU0gnBgzlK4Z/7Pi7ZYFHPRqTI+tVxMbBy4OCoouyX8Zrz57Nt7ISH1iZNT283tKCNdA
         fNgfuSKmlXAGIz6o87kreofTwSPfiUYp2PuGLYcoaqK7tKIlnKeT8e2G5HswSJeYGill
         Bg+Yrhn33KzwlNBFmW6uo6F2dkXdplBDSQdrtbFxqGJme6sLyBOlnucM0zNibDLFROL4
         Rb/gnjRjg31tZrworxbE9S9Yk4IGasGWfLafj0WqJ6s2LK+o+SX+J0LXlUgRTvYWu6sQ
         tTlA==
X-Gm-Message-State: AOAM531gC+rOJmjvVJg4dDkWXODH4eSfEQ4b282O4zv46nyXMdnROSi6
        xS+BAj2g+E8ZuL4JTYTHcmMz9mFUMZjtReQ3wt8D/A==
X-Google-Smtp-Source: ABdhPJyYhrHDkMEIM8sb30HvdNm9NvwXGvBpsmEB4pj4wWZjVWYx75pOHTRRFt0zGG4skCe/Sv7mn3ak8R0vmw91IN8=
X-Received: by 2002:a37:a907:: with SMTP id s7mr2228607qke.157.1606294251245;
 Wed, 25 Nov 2020 00:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20201124201033.592576-1-pmalani@chromium.org> <20201124203235.GA517388@google.com>
 <20201125074603.GE1008337@kuha.fi.intel.com> <20201125075312.GF1008337@kuha.fi.intel.com>
In-Reply-To: <20201125075312.GF1008337@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 25 Nov 2020 00:50:40 -0800
Message-ID: <CACeCKadOnMYjHXcVARAESbrmT5RPaoK4moJBfs0QfN2o38hPFQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] usb: typec: Consolidate sysfs ABI documentation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Tue, Nov 24, 2020 at 11:53 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Nov 25, 2020 at 09:46:06AM +0200, Heikki Krogerus wrote:
> > On Tue, Nov 24, 2020 at 12:32:35PM -0800, Prashant Malani wrote:
> > > Hi,
> > >
> > > On Tue, Nov 24, 2020 at 12:10:31PM -0800, Prashant Malani wrote:
> > > > Both partner and cable have identity VDOs. These are listed separately
> > > > in the Documentation/ABI/testing/sysfs-class-typec. Factor these out
> > > > into a common location to avoid the duplication.
> > > >
> > > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > > Acked-by: Heikki Krogerus <heikki.krogeurus@linux.intel.com>
> > > I copied the Acked-by line from v3 [1] as is, but looks like there was a
> > > typo there and the email address should be
> > > "heikki.krogerus@linux.intel.com".
> > >
> > > Please let me know if it's fine as is or whether I should send another
> > > patchset.
> >
> > It is fine. Thanks for taking care of that :-)
>
> Arch, no. It's not fine (I don't know what I'm talking about there). I
> think it would be better that you do resend.

Got it. v5 sent [1]

[1] https://lore.kernel.org/linux-usb/20201125084911.1077462-1-pmalani@chromium.org/

Thanks,

-Prashant
