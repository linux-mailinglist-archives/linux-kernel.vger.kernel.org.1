Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E871E79DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 11:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgE2Jvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 05:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgE2Jvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:51:43 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3E7C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:51:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m21so1220009eds.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3T/zrsuadN22N6xG3haLfTOv3GRzcC9OXLSwcS0asw=;
        b=CUbh2O4u401oOyVmSr+UxiVM9YNSg49tSmupSq9vlnyzdXchtsnTFrDbOIxrDtUyGz
         VSDVH7X6vU+ivzYL3XwvI7oK1CsC/TtUs62xkdxU3hZ2mfkBU782bT+WYaIVCq7vR0hR
         w6aJo45B16uDl3czX6GaTTGMMzc/uWFng7RsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3T/zrsuadN22N6xG3haLfTOv3GRzcC9OXLSwcS0asw=;
        b=l6CPY/j3OGS1oaFePhn15ju1BKGUNRRdlU9+ID90o0fQld+D8x8Mq1ZlLRPWeLSw1s
         LImsj5LuIEegVWyCKDMTztvztuDIgSACGf14iYF6RRyS5cUS+UxYCdLWKShnAQbNnt2Q
         PTtDQC42K442XmtAUmwMoqcn+TwHcort3iXOIbL2ijJw6a5F2v5JBCBNS++25WgHRsT1
         LlBURZVKjiibFVED4TVuG7j7oikTVP8Ngt1kGyjQjp3k2ro3gToxptcbNCePP7gLrPK4
         id0pnU6vdV/Q0oVUFr3yCqphfpIA9Igtpoof3V0FdxXnspsx0w1EUVTdJrt+B/piQlHP
         kEig==
X-Gm-Message-State: AOAM533nmw4tycccl2yH4jhzR1bVTFo8yymRSNPkmIw/b9S72m4CnFvP
        GXB+GnEXuCREE5ymV6M0sh4p+E7f2eFWBTt91UqWkw==
X-Google-Smtp-Source: ABdhPJxafMjOQwHwV5y/xyLtDUSv1zADexNiJH4YkI0/GygZPk4DEmeSK0M/pVVPdm/cPxsKvpsHsZoiJOp5OSRliSw=
X-Received: by 2002:a50:bb29:: with SMTP id y38mr7328686ede.358.1590745901171;
 Fri, 29 May 2020 02:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegstNYeseo_C4KOF9Y74qRxr78x2tK-9rTgmYM4CK30nRQ@mail.gmail.com>
 <875zcfoko9.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zcfoko9.fsf@nanos.tec.linutronix.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 29 May 2020 11:51:30 +0200
Message-ID: <CAJfpegsjd+FJ0ZNHJ_qzJo0Dx22ZaWh-WZ48f94Z3AUXbJfYYQ@mail.gmail.com>
Subject: Re: system time goes weird in kvm guest after host suspend/resume
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:43 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
> > Bisected it to:
> >
> > b95a8a27c300 ("x86/vdso: Use generic VDSO clock mode storage")
> >
> > The effect observed is that after the host is resumed, the clock in
> > the guest is somewhat in the future and is stopped.  I.e. repeated
> > date(1) invocations show the same time.
>
> TBH, the bisect does not make any sense at all. It's renaming the
> constants and moving the storage space and I just read it line for line
> again that the result is equivalent. I'll have a look once the merge
> window dust settles a bit.

Yet, reverting just that single commit against latest linus tree fixes
the issue.  Which I think is a pretty good indication that that commit
*is* doing something.

The jump forward is around 35 minutes; that seems to be consistent as well.

Thanks,
Miklos
