Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0422D65CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393278AbgLJS6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393267AbgLJS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:58:08 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1659EC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:57:25 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id v185so1473723vkf.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89ETQBahwfQbokMIPaPBbY34+Gcb1bOyU5ZoPKDVcLY=;
        b=MttlDK1+8tbWkGyYEQUVRuwpKxeMMntNkgsLXLbOcY+cdy+6ftnGwV9DuuDfP92w1m
         W2xThlhrF9jI0resoHnnvlQvfEOewwuXYcEYKD3Ig7aUENL+j4x5l/WkOo+tDi1Ym1xL
         f3l37CxypmgAyMMALCHmSz5YZMXYUA/hjwrNGXys3FJdAVidAJaB7NXAQJW20Q0lI+x6
         E4AcUytF1V7IImwstqZrX19JL8KESW37HGFylqMn7K44e4T7iaguzWxjqJwe+XNaBt2S
         WU7gDRexrqIts8sTb841cdCF4YGIoItGFacqB5W2WO1A4xUIeCvlbAZetBMnM+QGYcr4
         QMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89ETQBahwfQbokMIPaPBbY34+Gcb1bOyU5ZoPKDVcLY=;
        b=nuwrXP/Y+OC4n716AhqjbVJHV83F5Dczb+5R3JYzSYrFfFkCl0TMaF8pfKtAQieVqV
         eEewM5v43aMWtcg4YUGd/mZrG9lPRr26KwI43xBmRmzF9loYS+HOJ0hOpcTpWJH/i9j2
         wuX4h7LygQV7mdo39m1tuqWzsvGTA9rHtc6eUTRVcatkDnb2995IaY9/DlTMJPZsHq5B
         Vl2Hnj+ZY3SSBi9/0sUTcy1OEag48SRwgk2v2edKIzGpbcZ07prh1s6CGePzTDEKCaHw
         gHu9fFlGNEEoeZ9A4l1zTvdSlvR29LtS1CzwhxJzQ6rOR6HXqqT3xLqH54rtkJuBnQhB
         Qm2Q==
X-Gm-Message-State: AOAM530/2Mk0poHrPIiCz35qm3SeLOePU5R9XvVk3LQVfhLQngeUGaI8
        vdLIISqmbLLmXTKIb30ZrFHJvvcYWHCscldyccQNtA==
X-Google-Smtp-Source: ABdhPJxyg/RRfgpJFHX+2N5KdkecP634kvYKPLS9rvWdmoEMyKhfZBfFjzAhCxAbOlAFErwUbk1ZD0ve9Ldb+V69IQw=
X-Received: by 2002:a1f:aed2:: with SMTP id x201mr10850305vke.22.1607626644059;
 Thu, 10 Dec 2020 10:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
 <20201210160521.3417426-6-gregkh@linuxfoundation.org> <20201210174548.GF107395@roeck-us.net>
In-Reply-To: <20201210174548.GF107395@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 10 Dec 2020 10:56:48 -0800
Message-ID: <CAPTae5JBj1PgZw7=00ZPuT8OZP7=SNSAcPBtaiQ_LyxZm7UhNw@mail.gmail.com>
Subject: Re: [PATCH 5/5] USB: typec: tcpci: Add Bleed discharge to
 POWER_CONTROL definition
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Yes I will send a follow up patch to update tcpci_maxim.c.

Thanks,
Badhri


On Thu, Dec 10, 2020 at 9:45 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Dec 10, 2020 at 05:05:21PM +0100, Greg Kroah-Hartman wrote:
> > From: Badhri Jagan Sridharan <badhri@google.com>
> >
> > "Table 4-19. POWER_CONTROL Register Definition" from tcpci spec
> > defines BIT(3) as the control bit for bleed discharge.
> >
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Kyle Tso <kyletso@google.com>
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Just wondering - is that going to be used in a follow-up commit ?
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Guenter
>
> > ---
> >  drivers/usb/typec/tcpm/tcpci.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> > index 116a69c85e38..c3c7d07d9b4e 100644
> > --- a/drivers/usb/typec/tcpm/tcpci.h
> > +++ b/drivers/usb/typec/tcpm/tcpci.h
> > @@ -72,6 +72,7 @@
> >
> >  #define TCPC_POWER_CTRL                      0x1c
> >  #define TCPC_POWER_CTRL_VCONN_ENABLE BIT(0)
> > +#define TCPC_POWER_CTRL_BLEED_DISCHARGE      BIT(3)
> >  #define TCPC_POWER_CTRL_AUTO_DISCHARGE       BIT(4)
> >  #define TCPC_FAST_ROLE_SWAP_EN               BIT(7)
> >
> > --
> > 2.29.2
> >
